import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(SecureWalletApp());
}

class SecureWalletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Sabit AES anahtarı
  final String aesKey = "12345678901234567890123456789012"; // 32 karakter uzunluğunda

  String encryptDataAES(String data) {
    final key = encrypt.Key.fromUtf8(aesKey);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  Future<void> sendTokenToServer(String encryptedData) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/store_token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'data': encryptedData}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Ödeme Bilgileri Güvenli Şekilde Saklandı")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sunucu hatası: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bağlantı hatası: $e")),
      );
    }
  }

  void processPayment() {
    if (_formKey.currentState!.validate()) {
      String cardInfo = "${_cardNumberController.text}|${_expiryDateController.text}|${_cvvController.text}";
      String encryptedData = encryptDataAES(cardInfo);
      sendTokenToServer(encryptedData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Güvenli Ödeme")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _cardNumberController,
                decoration: InputDecoration(labelText: "Kart Numarası"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.length == 16 ? null : "Geçerli bir kart numarası girin",
              ),
              TextFormField(
                controller: _expiryDateController,
                decoration: InputDecoration(labelText: "Son Kullanma Tarihi (MM/YY)"),
                keyboardType: TextInputType.datetime,
                validator: (value) => RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(value!) ? null : "Geçerli bir tarih girin",
              ),
              TextFormField(
                controller: _cvvController,
                decoration: InputDecoration(labelText: "CVV"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.length == 3 ? null : "Geçerli bir CVV girin",
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: processPayment, child: Text("Ödemeyi Kaydet")),
            ],
          ),
        ),
      ),
    );
  }
}
