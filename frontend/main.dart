import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

import 'key_service.dart';

void main() {
  runApp(MaterialApp(home: CardFormPage()));
}

class CardFormPage extends StatefulWidget {
  @override
  _CardFormPageState createState() => _CardFormPageState();
}

class _CardFormPageState extends State<CardFormPage> {
  final _formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiry = '';
  String cvv = '';

  final keyService = KeyService();
  bool isKeyReady = false;

  final iv = encrypt.IV.fromUtf8("1234567890123456"); // 16 byte IV CBC için

  @override
  void initState() {
    super.initState();
    initKeys();
  }

  Future<void> initKeys() async {
    bool loaded = await keyService.loadSavedEd25519KeyPair();
    if (!loaded) await keyService.generateAndSaveEd25519KeyPair();

    // AES anahtarını X25519 ile sunucudan al
    await keyService.performKeyExchangeWithServer("http://localhost:5000");

    setState(() => isKeyReady = true);
  }

  Future<void> sendEncryptedCard() async {
  if (!_formKey.currentState!.validate() || !isKeyReady) return;

  final cardJson = jsonEncode({
    "card": cardNumber,
    "expiry": expiry,
    "cvv": cvv,
  });

  final aesRaw = await keyService.sharedAesKey.extractBytes();
  final aesKey = encrypt.Key(Uint8List.fromList(aesRaw.sublist(0, 32)));

  final encrypter = encrypt.Encrypter(encrypt.AES(aesKey, mode: encrypt.AESMode.cbc));
  final encrypted = encrypter.encrypt(cardJson, iv: iv);

  final encryptedBytes = encrypted.bytes;
  final signature = await keyService.signData(Uint8List.fromList(encryptedBytes));
  final publicKeyBase64 = await keyService.getEd25519PublicKeyBase64();
  final clientPublicKey = await keyService.getClientX25519PublicKeyBase64();

  final body = jsonEncode({
    "encryptedCard": base64Encode(encryptedBytes),
    "iv": iv.base64,
    "signature": signature,
    "publicKey": publicKeyBase64,
    "clientPublicKey": clientPublicKey,
  });

  final response = await http.post(
    Uri.parse('http://localhost:5000/api/cards/submit-card-ed25519'),
    headers: {'Content-Type': 'application/json'},
    body: body,
  );

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("Sunucu Yanıtı"),
      content: Text(response.body),
    ),
  );
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
              validator: (value) => value!.isEmpty ? 'Lütfen kart numarası girin' : null,
              onChanged: (val) => cardNumber = val,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Son Kullanma (MM/YY)"),
              validator: (value) => value!.isEmpty ? 'Lütfen son kullanma tarihi girin' : null,
              onChanged: (val) => expiry = val,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "CVV"),
              obscureText: true,
              validator: (value) => value!.isEmpty ? 'Lütfen CVV girin' : null,
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
