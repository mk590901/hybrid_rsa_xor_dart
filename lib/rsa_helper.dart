import 'dart:math';
import 'package:uuid/uuid.dart';
import 'crypto_utils.dart';

class RSAHelper {
  final int p = 1999;  // Prime number
  final int q = 2027;  // Prime number
  late RSAKeyPair keyPair;

  RSAHelper () {
    keyPair = generateKeyPair(p, q);
  }

  RSAPublicKey publicKey() {
    return keyPair.publicKey;
  }

  RSAPrivateKey privateKey() {
    return keyPair.privateKey;
  }

  RSAKeyPair generateKeyPair(int p, int q) {
    if (!isPrime(p) || !isPrime(q)) {
      throw Exception('p and q must be prime');
    }

    BigInt n = BigInt.from(p) * BigInt.from(q);
    BigInt phi = BigInt.from((p - 1) * (q - 1));

    // Choosing e (usually 65537, as it is simple and efficient)
    BigInt e = BigInt.from(65537);
    if (gcd(e, phi) != BigInt.one) {
      throw Exception('e and phi must be coprime');
    }

    // Calculate d (the modular inverse of e with respect to phi)
    BigInt d = e.modInverse(phi);

    // Creating keys with enabled modulus
    String keyId = Uuid().v4.toString();
    RSAPublicKey publicKey = RSAPublicKey(n, e, keyId);
    RSAPrivateKey privateKey = RSAPrivateKey(n, d, BigInt.from(p), BigInt.from(q), keyId);

    return RSAKeyPair(publicKey, privateKey);
  }

  // Checking if a number is prime (simplified)
  bool isPrime(int n) {
    if (n < 2) {
      return false;
    }
    for (int i = 2; i <= sqrt(n).toInt(); i++) {
      if (n % i == 0) {
        return false;
      }
    }
    return true;
  }

  // Finding the GCD (to check mutual primality)
  BigInt gcd(BigInt a, BigInt b) {
    while (b != BigInt.zero) {
      var temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }
}