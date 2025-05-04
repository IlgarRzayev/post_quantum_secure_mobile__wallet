import 'dart:core';  // Make sure this is included
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/export.dart' as pc;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:typed_data';
import 'dart:math';

class CardFormPage extends StatefulWidget {
  @override
  State<CardFormPage> createState() => _CardFormPageState();
}

class _CardFormPageState extends State<CardFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _storage = FlutterSecureStorage();
  String cardNumber = '';
  String expiry = '';
  String cvv = '';
  String rsaPublicKey = '';
  String signaturePublicKey = '';
  String? signaturePrivateKey;

  late pc.ECPrivateKey? privateKey; // Declare privateKey with late modifier

  @override
  void initState() {
    super.initState();
    _initKeys();
  }

  Future<void> _initKeys() async {
    final response = await http.get(Uri.parse('http://localhost:3000/public-key'));
    if (response.statusCode == 200) {
      final jsonRes = jsonDecode(response.body);
      setState(() {
        rsaPublicKey = jsonRes['publicKey'];
        signaturePublicKey = jsonRes['signaturePublicKey'];
      });
    }

    signaturePrivateKey = await _storage.read(key: 'signaturePrivateKey');

    if (signaturePrivateKey == null) {
      final keyPair = _generateECKeyPair();
      await _storage.write(
        key: 'signaturePrivateKey',
        value: keyPair['privateKey']!,
      );
      await _storage.write(
        key: 'signaturePublicKey',
        value: keyPair['publicKey']!,
      );
      signaturePrivateKey = keyPair['privateKey'];
    }

    // Initialize privateKey using the private key from the storage
    privateKey = _decodePrivateKey(signaturePrivateKey!);
  }

  Map<String, String> _generateECKeyPair() {
    final ecDomain = pc.ECDomainParameters('prime256v1');
    final keyParams = pc.ECKeyGeneratorParameters(ecDomain);
    final random = pc.FortunaRandom();

    final seed = Uint8List(32);
    final rng = Random.secure();
    for (int i = 0; i < seed.length; i++) {
      seed[i] = rng.nextInt(256);
    }
    random.seed(pc.KeyParameter(seed));

    final generator = pc.ECKeyGenerator();
    generator.init(pc.ParametersWithRandom(keyParams, random));

    final pair = generator.generateKeyPair();
    final privateKey = pair.privateKey as pc.ECPrivateKey;
    final publicKey = pair.publicKey as pc.ECPublicKey;

    Uint8List bigIntToBytes(BigInt number) {
      final bytes = number.toRadixString(16).padLeft(64, '0');
      return Uint8List.fromList(List.generate(
        bytes.length ~/ 2,
        (i) => int.parse(bytes.substring(i * 2, i * 2 + 2), radix: 16),
      ));
    }

    final privEncoded = base64Encode(bigIntToBytes(privateKey.d!));
    final pubEncoded = base64Encode(publicKey.Q!.getEncoded(false));

    return {
      'privateKey': privEncoded,
      'publicKey': pubEncoded,
    };
  }

  // Decode the private key from base64 string
  pc.ECPrivateKey _decodePrivateKey(String base64PrivateKey) {
  final privKeyBytes = base64Decode(base64PrivateKey);
  final ecDomain = pc.ECDomainParameters('prime256v1');
  final privBigInt = _bytesToBigInt(privKeyBytes);
  return pc.ECPrivateKey(privBigInt, ecDomain);
}

BigInt _bytesToBigInt(Uint8List bytes) {
  BigInt result = BigInt.zero;
  for (var byte in bytes) {
    result = (result << 8) | BigInt.from(byte);
  }
  return result;
}


  String _signData(String data) {
    if (signaturePrivateKey == null) {
      throw Exception('Private key is not available!');
    }

    final signer = pc.Signer('SHA-256/ECDSA');
    signer.init(
      true,
      pc.PrivateKeyParameter<pc.ECPrivateKey>(privateKey),
    );

    final sig = signer.generateSignature(Uint8List.fromList(utf8.encode(data))) as pc.ECSignature;

    final r = sig.r.toRadixString(16).padLeft(64, '0');
    final s = sig.s.toRadixString(16).padLeft(64, '0');
    return r + s; // Return the concatenated signature as a hexadecimal string
  }

  Future<void> sendEncryptedCard() async {
    final cardJson = jsonEncode({
      "card": cardNumber,
      "expiry": expiry,
      "cvv": cvv,
      "timestamp": DateTime.now().toIso8601String(),
    });

    final signature = _signData(cardJson);

    final aesKey = encrypt.Key.fromSecureRandom(32);
    final iv = encrypt.IV.fromSecureRandom(16);
    final aesEncrypter = encrypt.Encrypter(encrypt.AES(aesKey));
    final encryptedCard = aesEncrypter.encrypt(cardJson, iv: iv);

    final rsa = encrypt.RSAKeyParser().parse(rsaPublicKey) as pc.RSAPublicKey;
    final rsaEncrypter = encrypt.Encrypter(encrypt.RSA(publicKey: rsa));
    final encryptedAesKey = rsaEncrypter.encrypt(aesKey.base64);

    final response = await http.post(
      Uri.parse('http://localhost:3000/submit-card'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "encryptedCard": encryptedCard.base64,
        "encryptedKey": encryptedAesKey.base64,
        "iv": iv.base64,
        "signature": signature,
        "publicKey": await _storage.read(key: 'signaturePublicKey'),
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Başarıyla gönderildi!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gönderim hatası!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kart Giriş Formu")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Kart Numarası"),
              validator: (val) => val!.length < 16 ? "Geçersiz kart numarası" : null,
              onChanged: (val) => cardNumber = val,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Son Kullanma Tarihi"),
              onChanged: (val) => expiry = val,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "CVV"),
              obscureText: true,
              onChanged: (val) => cvv = val,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendEncryptedCard,
              child: Text("Gönder"),
            ),
          ]),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kart Gönderici',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CardFormPage(), // senin widget'ının adı bu
    );
  }
}
