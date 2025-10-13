import 'dart:typed_data';
import 'dart:convert';
import 'rsa_helper.dart';
import 'rsa_encryptor.dart';
import 'rsa_decryptor.dart';
import 'crypto_utils.dart';
import 'xor_helper.dart';
import 'xor_client.dart';
import 'xor_server.dart';
import 'xor_packet.dart';
import 'primes_generator.dart';

// Convert BigInt to Uint8List of exactly 8 bytes (64 bits, big-endian)
Uint8List bigIntTo8Bytes(BigInt bigInt) {
  // Initialize 8-byte buffer
  final bytes = Uint8List(8);

  // Handle negative numbers using two's complement
  BigInt value = bigInt;
  if (value.isNegative) {
    // Convert to two's complement for 64-bit representation
    value = value & ((BigInt.one << 64) - BigInt.one); // Mask to 64 bits
  }

  // Extract the least significant 64 bits (8 bytes)
  for (int i = 7; i >= 0; i--) {
    bytes[i] = (value & BigInt.from(0xFF)).toInt();
    value = value >> 8;
  }

  return bytes;
}

// Convert List<BigInt> to Uint8List (each BigInt to 8 bytes)
Uint8List bigIntListToUint8List(List<BigInt> bigIntList) {
  final bytesList = bigIntList.map((bigInt) => bigIntTo8Bytes(bigInt)).toList();
  final totalLength = bigIntList.length * 8;
  final result = Uint8List(totalLength);
  for (int i = 0; i < bigIntList.length; i++) {
    result.setRange(i * 8, (i + 1) * 8, bytesList[i]);
  }
  return result;
}

// Convert 8-byte Uint8List to BigInt (big-endian)
BigInt bytes8ToBigInt(Uint8List bytes) {
  if (bytes.length != 8) {
    throw ArgumentError('Input must be exactly 8 bytes');
  }
  BigInt result = BigInt.zero;
  bool isNegative = (bytes[0] & 0x80) != 0;
  for (int i = 0; i < 8; i++) {
    result = (result << 8) | BigInt.from(bytes[i]);
  }
  if (isNegative) {
    result = result - (BigInt.one << 64);
  }
  return result;
}

// Convert Uint8List to List<BigInt> (assuming 8-byte chunks)
List<BigInt> uint8ListToBigIntList(Uint8List uint8List) {
  if (uint8List.length % 8 != 0) {
    throw ArgumentError('Uint8List length must be a multiple of 8');
  }
  final bigIntList = <BigInt>[];
  for (int i = 0; i < uint8List.length; i += 8) {
    bigIntList.add(bytes8ToBigInt(Uint8List.sublistView(uint8List, i, i + 8)));
  }
  return bigIntList;
}

// Uint8List to Base64
String uint8ListToBase64(Uint8List uint8List) {
  return base64.encode(uint8List);
}

// Base64 to Uint8List
Uint8List base64ToUint8List(String base64String) {
  try {
    return Uint8List.fromList(base64.decode(base64String));
  } catch (e) {
    throw FormatException('Invalid Base64 string: $e');
  }
}

void testRSA() {
  // Sample using
  RSAHelper rsaHelper = RSAHelper();

  RSAEncryptor encryptor = RSAEncryptor();
  encryptor.setKey(rsaHelper.publicKey());

  RSADecryptor decryptor = RSADecryptor();
  decryptor.setKey(rsaHelper.privateKey());

  String message   = 'Welcome to RSA'; //generateRandomString(32);

  print('Source message: $message');

  // Encryption
  List<BigInt> encrypted = encryptor.encrypt(message);
  print('BigInt encrypted message: $encrypted');
  Uint8List encryptedUint8 = bigIntListToUint8List(encrypted);
  print('Uint8 encrypted message: $encryptedUint8');
  String base64str = uint8ListToBase64(encryptedUint8);
  print('base64 encrypted message: $base64str');

  // Decryption
  Uint8List decryptedUint8 = base64ToUint8List(base64str) ;
  print('Uint8 decrypted message: $decryptedUint8');
  List<BigInt> decryptedBigIntList = uint8ListToBigIntList(decryptedUint8);
  print('BigInt decrypted message: $decryptedBigIntList');

  String decrypted = decryptor.decrypt(decryptedBigIntList);
  print('decrypted message: $decrypted');
}

void testRSAPublic() {
  RSAHelper rsaHelper = RSAHelper();
  print ('RSAPublicKey->[${rsaHelper.publicKey().toString()}]');
  String jsonString = rsaHelper.publicKey().toJsonString();
  print ('json->$jsonString');
  RSAPublicKey publicKey = RSAPublicKey.fromJsonString(jsonString);
  print ('RSAPublicKey.fromJsonString->[${publicKey.toString()}]');
}

void testXorHelper() {
  XorHelper xorHelper = XorHelper();
  String sourceText = "The XOR Encryption algorithm is a very effective yet easy to implement method of symmetric encryption. Due to its effectiveness and simplicity, the XOR Encryption is an extremely common component used in more complex encryption algorithms used nowadays. The XOR encryption algorithm is an example of symmetric encryption where the same key is used to both encrypt and decrypt a message.";
  String key = xorHelper.key();
  String? cipherText = xorHelper.encrypt(sourceText,key);
  print ("cipherText->\n$cipherText");
  String? decryptedText = xorHelper.decrypt(cipherText,key);
  print ("decryptedText->\n$decryptedText");
}

void testXorClientServer() {

  String sourceText = "The XOR Encryption algorithm is a very effective yet easy to implement method of symmetric encryption. Due to its effectiveness and simplicity, the XOR Encryption is an extremely common component used in more complex encryption algorithms used nowadays. The XOR encryption algorithm is an example of symmetric encryption where the same key is used to both encrypt and decrypt a message.";

  String jsonPUKey = "{\"id\":\"1234\",\"modulus\":4051973,\"exponent\":65537}";
  RSAPublicKey publicKey = RSAPublicKey.fromJsonString(jsonPUKey);
  print ("publicKey->[${publicKey.toString()}]");

  XorClient xorClient = XorClient();
  xorClient.setKey(publicKey);
  XorPacket packet = xorClient.encrypt(sourceText);
  print ("packet->\n${packet.toJsonString()}");

//  Restore
  String jsonPRKey = "{\"id\":\"1234\",\"modulus\":4051973,\"exponent\":2497193,\"fp\":1999,\"sp\":2027}";
  RSAPrivateKey privateKey = RSAPrivateKey.fromJsonString(jsonPRKey);
  print ("privateKey->[${privateKey.toStringFull()}]");

  XorServer xorServer = XorServer();
  xorServer.setKey(privateKey);
  String? restoreText = xorServer.decrypt(packet);
  print ("restoreText->\n[$restoreText]");

}

void testXorClient() {

  String sourceText = "The XOR Encryption algorithm";

  String jsonPUKey = "{\"id\":\"810adcb7-1fe2-2783-b1e6-9ba9a4a38ea5\",\"modulus\":4051973,\"exponent\":65537}";
  RSAPublicKey publicKey = RSAPublicKey.fromJsonString(jsonPUKey);
  print ("publicKey->[${publicKey.toString()}]");

  XorClient xorClient = XorClient();
  xorClient.setKey(publicKey);
  XorPacket packet = xorClient.encrypt(sourceText);
  print ("packet->\n${packet.toJsonString()}");

}

void testDartServerToitClient() {
  print ("******* test Dart Server -> Toit Client *******");

  RSAHelper rsaHelper = RSAHelper();
  print ("public->[${rsaHelper.publicKey().toString()}] private->[${rsaHelper.privateKey().toStringFull()}]");

  RSAPublicKey publicKey = rsaHelper.publicKey();
  String jsonPbkString = publicKey.toJsonString();
  print ("PUBLIC  json->[$jsonPbkString]");

  RSAPrivateKey privateKey = rsaHelper.privateKey();
  String jsonPrkString = privateKey.toJsonString();
  print ("PRIVATE json->[$jsonPrkString]");

  String sourceText = "The XOR Encryption algorithm is a very effective yet easy to implement method of symmetric encryption. Due to its effectiveness and simplicity, the XOR Encryption is an extremely common component used in more complex encryption algorithms used nowadays. The XOR encryption algorithm is an example of symmetric encryption where the same key is used to both encrypt and decrypt a message.";

  XorClient xorClient = XorClient();
  xorClient.setKey(publicKey);
  XorPacket packet = xorClient.encrypt(sourceText);
  print ("packet->\n${packet.toJsonString()}");

  XorServer xorServer = XorServer();
  xorServer.setKey(privateKey);
  String? restoreText = xorServer.decrypt(packet);
  print ("restoreText->\n[$restoreText]");


}

void testRestoreToitPacket() {
  print ("test Restore Toit Packet");

  String privateKeyJson = '{"id":"64295ecc-8d4a-49ad-baf9-d685da815b47","modulus":4051973,"exponent":2497193,"fp":1999,"sp":2027}';
  RSAPrivateKey privateKey = RSAPrivateKey.fromJsonString(privateKeyJson);
  print ("PRIVATE key->[${privateKey.toStringFull()}]");

  String packetToitJson = '{"encrypted_key":["1258541","1012384","1046396","1625468","2219939","1169986","691187","3827649","3876797","2227773","1403681","3251762","2041119","2227773","847309","3525653","2029737","847309","2245548","3870663","3870663","1350053","826471","1144420","3917639","3641382","277333","2245548","1340869","3008309","2993555","1144420"],"id":"64295ecc-8d4a-49ad-baf9-d685da815b47","encrypted_text":"BT0rXxI5MEESZDQAVGRZFyFQQBkDK0NnDE1OX1pDMTMpKiYfRy8hVBsxKBsOIRwOLkhQGAQ8Ui4HShEVQ0I1LiMkJBMJJTcaEjUuGw4lUAosX1A="}';
  XorServer xorServer = XorServer();
  xorServer.setKey(privateKey);
  XorPacket packetToit = XorPacket.fromJsonString(packetToitJson);
  String? restoreToitText = xorServer.decrypt(packetToit);
  print ("restoreToitText->\n[$restoreToitText]");


}




