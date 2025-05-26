import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeyService {
  final algorithm = Ed25519();
  final storage = const FlutterSecureStorage();
  final keyStorageKey = 'ed25519_private_key';

  late SimpleKeyPair keyPair;
  late SimplePublicKey publicKey;

  static const List<int> _ed25519Header = [
    0x30, 0x2a,
    0x30, 0x05,
    0x06, 0x03, 0x2b, 0x65, 0x70,
    0x03, 0x21, 0x00
  ];

  Future<void> generateAndSaveKeyPair() async {
    keyPair = await algorithm.newKeyPair();
    final extracted = await keyPair.extract();
    final privateKeyBytes = base64Encode(extracted.bytes);
    await storage.write(key: keyStorageKey, value: privateKeyBytes);
    publicKey = await keyPair.extractPublicKey();
  }

  Future<bool> loadSavedKeyPair() async {
    final stored = await storage.read(key: keyStorageKey);
    if (stored == null) return false;

    final privateBytes = base64Decode(stored);
    final extracted = await (await algorithm.newKeyPairFromSeed(privateBytes)).extract();
    publicKey = extracted.publicKey;

    keyPair = SimpleKeyPairData(
      privateBytes,
      publicKey: publicKey,
      type: KeyPairType.ed25519,
    );

    return true;
  }

  /// Artık ham veriyi (Uint8List) imzalayan versiyon
  Future<String> signData(Uint8List rawBytes) async {
    final signature = await algorithm.sign(
      rawBytes,
      keyPair: keyPair,
    );
    return base64Encode(signature.bytes);
  }

  Future<String> getPublicKeyBase64() async {
    final raw = publicKey.bytes;
    final fullKey = Uint8List.fromList(_ed25519Header + raw);
    return base64Encode(fullKey);
  }

  Future<void> clearKey() async {
    await storage.delete(key: keyStorageKey);
  }
}
