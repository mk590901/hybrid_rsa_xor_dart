import 'crypto_utils.dart';

class RSADecryptor {
  late RSAPrivateKey privateKey;

  void setKey(RSAPrivateKey privateKey) {
    this.privateKey = privateKey;
  }

  String decrypt(List<BigInt> cipher) {
    StringBuffer plaintext = StringBuffer();
    for (BigInt c in cipher) {
      BigInt m = c.modPow(privateKey.exponent, privateKey.modulus);
      plaintext.writeCharCode(m.toInt());
    }
    return plaintext.toString();
  }

}