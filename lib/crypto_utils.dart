import 'dart:math';
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
    return '{"id":"$keyId","modulus":${modulus.toString()},"exponent":${exponent.toString()},"fp":${p.toString()},"sp":${q.toString()}}';
  }

  factory RSAPrivateKey.fromJsonString(String jsonString) {
    // Parse JSON string to Map
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    // Create RSAPrivateKey instance from Map
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
    return '{"id":"$keyId","modulus":${modulus.toString()},"exponent":${exponent.toString()}}';
  }

  factory RSAPublicKey.fromJsonString(String jsonString) {
    // Parse JSON string to Map
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    // Create RSAPublicKey instance from Map
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
