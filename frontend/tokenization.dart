import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51R0kQrQAJX5ewLgAq5Ur1tm5L3t2DWxGpZdN4tT6WsyOUgGSYy3kM10OIt1U11BOR7WDiwmrW5aIOtvjhvazoZ9K008uCXNEIx'; // Stripe Publishable Key
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stripe Payment Test',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment() async {
    try {
      // Backend'den payment_intent al
      final response = await http.post(
        Uri.parse('https://your-backend.com/create-payment-intent'), // Backend URL
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'amount': '1000', // Ödeme miktarı (1000 = 10.00 EUR)
          'currency': 'eur',
        }),
      );

      paymentIntent = json.decode(response.body);

      // Stripe ödeme sayfasını aç
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: 'Test Merchant',
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      print('Ödeme Başarılı!');
    } catch (e) {
      print('Ödeme Hatası: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stripe Payment Test')),
      body: Center(
        child: ElevatedButton(
          onPressed: makePayment,
          child: Text('Pay Now'),
        ),
      ),
    );
  }
}
