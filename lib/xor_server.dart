import 'rsa_decryptor.dart';
import 'crypto_utils.dart';
import 'xor_helper.dart';
import 'xor_packet.dart';

class XorServer {
  final RSADecryptor decryptor = RSADecryptor();
  final XorHelper xorHelper = XorHelper();

  void setKey(RSAPrivateKey privateKey) {
    decryptor.setKey(privateKey);
  }

  String? decrypt(XorPacket dataPacket) {
    String decryptedKey = decryptor.decrypt(dataPacket.encryptedKey);
    print('decrypted decryptedKey: $decryptedKey');
    return xorHelper.decrypt(dataPacket.encryptedText, decryptedKey);
  }
}