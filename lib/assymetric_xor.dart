import 'custom_rsa.dart';
import 'xor_cipher.dart';
import 'primes_generator.dart';
import 'disposable_object.dart';
import 'short_uuid.dart';

String run() {
  testXorCipher();
  testXorHelper();
  testXorClientServer();
  testXorClient();
  testDartServerToitClient();
  testRestoreToitPacket();
  testPrimes();
  testDeserialization();
  restoreToitPacket();
  testDisposableObject();
  testShortUuid();

  return "ok";
}
