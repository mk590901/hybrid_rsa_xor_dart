import 'crypto_utils.dart';

class RSAEncryptor {
  late RSAPublicKey publicKey;

  void setKey(RSAPublicKey publicKey) {
    this.publicKey = publicKey;
  }

  List<BigInt> encrypt(String message) {
    List<BigInt> cipher = [];
    for (int i = 0; i < message.length; i++) {
      BigInt m = BigInt.from(message.codeUnitAt(i));
      cipher.add(m.modPow(publicKey.exponent, publicKey.modulus));
    }
    return cipher;
  }
}