import 'custom_rsa.dart';
import 'xor_cipher.dart';
import 'primes_generator.dart';

String run() {
  testXorCipher();
  testXorHelper();
  testXorClientServer();
  testXorClient();
  testDartServerToitClient();
  testRestoreToitPacket();
  testPrimes();
  testDeserialization();
  return "ok";
}
