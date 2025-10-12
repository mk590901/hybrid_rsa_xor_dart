import 'custom_rsa.dart';
import 'xor_cipher.dart';

String run() {
  testXorCipher();
  testXorHelper();
  testXorClientServer();
  return "ok";
}
