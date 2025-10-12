import 'dart:math';
import 'dart:typed_data';
import 'dart:convert';

class RSAPrivateKey {
  final BigInt modulus;   // n
  final BigInt exponent;  // d
  final BigInt p;         // First prime
  final BigInt q;         // Second prime
  final String keyId;
  RSAPrivateKey(this.modulus, this.exponent, this.p, this.q, this.keyId);

  @override
  String toString() {
    return '[$keyId],${modulus.toString()},${exponent.toString()}';
  }

  String toStringFull() {
    return '[$keyId],${modulus.toString()},${exponent.toString()},${p.toString()},${q.toString()}';
  }

  String toJsonString() {
    return '{"id":"$keyId","modulus":"${modulus.toString()}","exponent":"${exponent.toString()}","fp":"${p.toString()}","sp":"${q.toString()}"}';
  }

  factory RSAPrivateKey.fromJsonString(String jsonString) {
    // Parse JSON string to Map
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    // Create Person instance from Map
    int m = jsonMap['modulus'];
    int e = jsonMap['exponent'];
    int p = jsonMap['fp'];
    int q = jsonMap['sp'];
    String id = jsonMap['id'];
    return RSAPrivateKey(BigInt.from(m), BigInt.from(e), BigInt.from(p), BigInt.from(q), id
    );
  }
}

class RSAPublicKey {
  final BigInt modulus;   //  n
  final BigInt exponent;  //  e
  final String keyId;
  RSAPublicKey(this.modulus, this.exponent, this.keyId);

  // Convert RSAPublicKey to JSON string
  String toJsonString() {
    return '{"id":"$keyId","modulus":"${modulus.toString()}","exponent":"${exponent.toString()}"}';
  }

  // Constructor to create RSAPublicKey from JSON string
  // RSAPublicKey.fromJsonString(String jsonString) :
  //       modulus = BigInt.parse(RegExp(r'"modulus":\s*"([^"]+)"').firstMatch(jsonString)!.group(1)!),
  //       exponent = BigInt.parse(RegExp(r'"exponent":\s*"([^"]+)"').firstMatch(jsonString)!.group(1)!);

  factory RSAPublicKey.fromJsonString(String jsonString) {
    // Parse JSON string to Map
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    // Create Person instance from Map
    int m = jsonMap['modulus'];
    int e = jsonMap['exponent'];
    String id = jsonMap['id'];
    return RSAPublicKey(BigInt.from(m), BigInt.from(e), id
    );
  }


  //  toString
  @override
  String toString() {
    return '[$keyId],${modulus.toString()},${exponent.toString()}';
  }

}

// Generating a key pair
class RSAKeyPair {
  final RSAPublicKey publicKey;
  final RSAPrivateKey privateKey;
  RSAKeyPair(this.publicKey, this.privateKey);
}

String generateRandomString(int length) {
  const String chars = '~`!@#\$%^&*()_-=+<>?/,."{}[]|abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
          (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ),
  );
}
/*
class HybridPacket {
  final List<BigInt> encryptedKey;
  final List<BigInt> encryptedNonce;
  final Uint8List encryptedText;

  HybridPacket(this.encryptedKey, this.encryptedNonce, this.encryptedText);

  String toJsonString() {
    final Map<String, dynamic> jsonMap = {
      'encryptedKey': encryptedKey.map((bigInt) => bigInt.toInt()).toList(),
      'encryptedNonce': encryptedNonce.map((bigInt) => bigInt.toInt()).toList(),
      'encryptedText': base64Encode(encryptedText),
    };
    return jsonEncode(jsonMap);
  }

  factory HybridPacket.fromJsonString(String jsonString) {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    final List<dynamic> keyList = jsonMap['encryptedKey'] as List<dynamic>;
    final List<BigInt> parsedKey = keyList.map((num) => BigInt.from(num as int)).toList();

    final List<dynamic> nonceList = jsonMap['encryptedNonce'] as List<dynamic>;
    final List<BigInt> parsedNonce = nonceList.map((num) => BigInt.from(num as int)).toList();

    final String base64Text = jsonMap['encryptedText'] as String;
    final Uint8List parsedText = base64Decode(base64Text);

    return HybridPacket(parsedKey, parsedNonce, parsedText);
  }

  @override
  String toString() => 'HybridPacket(encryptedKey: $encryptedKey, encryptedNonce: $encryptedNonce, encryptedText: $encryptedText)';
}

 */

class HybridPacket {
  final List<BigInt> encryptedKey;
  final List<BigInt> encryptedNonce;
  final Uint8List   encryptedText;
  HybridPacket(this.encryptedKey, this.encryptedNonce, this.encryptedText);

  String toJsonString() {
    final Map<String, dynamic> jsonMap = {
      'encryptedKey': encryptedKey.map((bigInt) => bigInt.toString()).toList(),
      'encryptedNonce': encryptedNonce.map((bigInt) => bigInt.toString()).toList(),
      'encryptedText': base64Encode(encryptedText),
    };
    return jsonEncode(jsonMap);
  }

  HybridPacket.fromJsonString(String jsonString) :
        encryptedKey = (jsonDecode(jsonString)['encryptedKey'] as List)
            .map((str) => BigInt.parse(str as String))
            .toList(),
        encryptedNonce = (jsonDecode(jsonString)['encryptedNonce'] as List)
            .map((str) => BigInt.parse(str as String))
            .toList(),
        encryptedText = base64Decode(jsonDecode(jsonString)['encryptedText'] as String);
}
