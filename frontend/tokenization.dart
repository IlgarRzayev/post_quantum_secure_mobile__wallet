import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/asymmetric/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  String rsaPublicKey = '';

  @override
  void initState() {
    super.initState();
    fetchPublicKey();
  }

  Future<void> fetchPublicKey() async {
    final response = await http.get(Uri.parse('http://localhost:3000/public-key'));
    if (response.statusCode == 200) {
      final jsonRes = jsonDecode(response.body);
      setState(() {
        rsaPublicKey = jsonRes['publicKey'];
      });
    }
  }

  Future<void> sendEncryptedCard() async {
    final cardJson = jsonEncode({
      "card": cardNumber,
      "expiry": expiry,
      "cvv": cvv,
    });

    final key = encrypt.Key.fromSecureRandom(32);
    final iv = encrypt.IV.fromLength(16);
    final aesEncrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encryptedCard = aesEncrypter.encrypt(cardJson, iv: iv);

    final parser = encrypt.RSAKeyParser();
    final publicKey = parser.parse(rsaPublicKey) as RSAPublicKey;
    final rsaEncrypter = encrypt.Encrypter(encrypt.RSA(publicKey: publicKey));
    final encryptedKey = rsaEncrypter.encrypt(key.base64);


    final body = jsonEncode({
      "encryptedCard": encryptedCard.base64,
      "encryptedKey": encryptedKey.base64,
      "iv": iv.base64,
    });

    final response = await http.post(
      Uri.parse('http://localhost:3000/submit-card'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text('Sunucu yanıtı:\n${response.body}'),
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
              onChanged: (val) => cardNumber = val,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Son Kullanma (MM/YY)"),
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
