import 'rsa_encryptor.dart';
import 'crypto_utils.dart';
import 'xor_helper.dart';
import 'xor_packet.dart';

class XorClient {
  final RSAEncryptor encryptor = RSAEncryptor();
  final XorHelper xorHelper = XorHelper();

  void setKey(RSAPublicKey publicKey) {
    encryptor.setKey(publicKey);
  }

  XorPacket encrypt(String sink, String text) {
    final String key = xorHelper.key();
    List<BigInt> encryptedKey = encryptor.encrypt(key);
    return XorPacket(sink, encryptedKey, xorHelper.encrypt(text, key)?? "", encryptor.publicKey.keyId);
  }

}