import 'custom_rsa.dart';
import 'xor_cipher.dart';
import 'primes_generator.dart';

String run() {
  // testXorCipher();
  // testXorHelper();
  // testXorClientServer();
  // testXorClient();
  for (int i = 0; i < 16; i++) {
    print ("******* ${i+1} *******");
    testDartServerToitClient();
  }
  // testRestoreToitPacket();
  // testPrimes();
  return "ok";
}
