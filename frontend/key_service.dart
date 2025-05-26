import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class KeyService {
  // Ed25519 (dijital imza) ve X25519 (anahtar değişimi) algoritmaları
  final edAlgorithm = Ed25519();
  final xAlgorithm = X25519();

  final storage = const FlutterSecureStorage();
  final keyStorageKey = 'ed25519_private_key';

  late SimpleKeyPair ed25519KeyPair;
  late SimplePublicKey ed25519PublicKey;

  late SimpleKeyPair x25519KeyPair;
  late SimplePublicKey x25519ServerPublicKey;
  late SecretKey sharedAesKey;

  static const List<int> _ed25519Header = [
    0x30, 0x2a,
    0x30, 0x05,
    0x06, 0x03, 0x2b, 0x65, 0x70,
    0x03, 0x21, 0x00
  ];

  /// --- Ed25519 işlemleri ---

  Future<void> generateAndSaveEd25519KeyPair() async {
    ed25519KeyPair = await edAlgorithm.newKeyPair();
    final extracted = await ed25519KeyPair.extract();
    final privateKeyBytes = base64Encode(extracted.bytes);
    await storage.write(key: keyStorageKey, value: privateKeyBytes);
    ed25519PublicKey = await ed25519KeyPair.extractPublicKey();
  }

  Future<bool> loadSavedEd25519KeyPair() async {
    final stored = await storage.read(key: keyStorageKey);
    if (stored == null) return false;

    final privateBytes = base64Decode(stored);
    final extracted = await (await edAlgorithm.newKeyPairFromSeed(privateBytes)).extract();
    ed25519PublicKey = extracted.publicKey;

    ed25519KeyPair = SimpleKeyPairData(
      privateBytes,
      publicKey: ed25519PublicKey,
      type: KeyPairType.ed25519,
    );

    return true;
  }

  Future<String> signData(Uint8List rawBytes) async {
    final signature = await edAlgorithm.sign(
      rawBytes,
      keyPair: ed25519KeyPair,
    );
    return base64Encode(signature.bytes);
  }

  Future<String> getEd25519PublicKeyBase64() async {
    final raw = ed25519PublicKey.bytes;
    final fullKey = Uint8List.fromList(_ed25519Header + raw);
    return base64Encode(fullKey);
  }

  Future<void> clearEd25519Key() async {
    await storage.delete(key: keyStorageKey);
  }

  /// --- X25519 işlemleri (AES key üretmek için) ---

  Future<SecretKey> performKeyExchangeWithServer(String serverUrl) async {
    x25519KeyPair = await xAlgorithm.newKeyPair();
    final clientPubKey = await x25519KeyPair.extractPublicKey();

    // Client public key'i base64 ile gönder
    final res = await http.post(
      Uri.parse('$serverUrl/api/cards/request-aes-key'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'clientPublicKey': base64Encode(clientPubKey.bytes),
      }),
    );

    if (res.statusCode != 200) {
      throw Exception("Sunucu AES anahtarı gönderemedi: ${res.body}");
    }

    final json = jsonDecode(res.body);
    final serverPubKeyBase64 = json['serverPublicKey'];

    x25519ServerPublicKey = SimplePublicKey(
      base64Decode(serverPubKeyBase64),
      type: KeyPairType.x25519,
    );

    // Ortak sır (shared secret) üret → AES key
    final sharedSecret = await xAlgorithm.sharedSecretKey(
      keyPair: x25519KeyPair,
      remotePublicKey: x25519ServerPublicKey,
    );

    // Düzeltme: Doğrudan sharedSecret'ı kullan
    sharedAesKey = sharedSecret;
    return sharedAesKey;
  }

  Future<String> getClientX25519PublicKeyBase64() async {
    final pub = await x25519KeyPair.extractPublicKey();
    return base64Encode(pub.bytes);
  }
}
