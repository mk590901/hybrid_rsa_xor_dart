import 'crypto_utils.dart';
import 'xor_cipher.dart';

class XorHelper {
//  final XorCipher cipher = XorCipher();

  String? encrypt(String text, String key) {
    String? result;
    try {
      result = XorCipher.encrypt(text, key);
    }
    catch (exception) {
      print ("Encrypt.exception-> $exception");
    }
    return result;
  }

  String? decrypt(String? text, String key) {
    String? result;
    if (text == null) {
      return result;
    }
    try {
      result = XorCipher.decrypt(text, key);
    }
    catch (exception) {
      print ("Decrypt.exception-> $exception");
    }
    return result;
  }

  String key () {
    return generateRandomString(32); //'12345678901234567890123456789012';
  }
}
