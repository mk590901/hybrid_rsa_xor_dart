import 'dart:convert';
import 'dart:typed_data';

class XorCipher {
  // Encrypts or decrypts the input using the provided key
  static Uint8List _process(Uint8List input, Uint8List key) {
    final output = Uint8List(input.length);
    for (int i = 0; i < input.length; i++) {
      // XOR each byte of input with the corresponding byte of the key
      output[i] = input[i] ^ key[i % key.length];
    }
    return output;
  }

  // Encrypts the plaintext string using the key
  static String encrypt(String plaintext, String key) {
    // Convert plaintext and key to bytes
    final plainBytes = utf8.encode(plaintext);
    final keyBytes = utf8.encode(key);

    // Ensure key is not empty
    if (keyBytes.isEmpty) {
      throw Exception('Key cannot be empty');
    }

    // Process encryption
    final encryptedBytes = _process(Uint8List.fromList(plainBytes), Uint8List.fromList(keyBytes));

    // Encode to base64 for readable output
    return base64.encode(encryptedBytes);
  }

  // Decrypts the base64-encoded ciphertext using the key
  static String decrypt(String ciphertext, String key) {
    // Decode base64 ciphertext
    final cipherBytes = base64.decode(ciphertext);
    final keyBytes = utf8.encode(key);

    // Ensure key is not empty
    if (keyBytes.isEmpty) {
      throw Exception('Key cannot be empty');
    }

    // Process decryption (same as encryption due to XOR properties)
    final decryptedBytes = _process(Uint8List.fromList(cipherBytes), Uint8List.fromList(keyBytes));

    // Convert back to string
    return utf8.decode(decryptedBytes);
  }
}

void testXorCipher() {
  // Example usage
  String plaintext = "The XOR Encryption algorithm is a very effective yet easy to implement method of symmetric encryption. Due to its effectiveness and simplicity, the XOR Encryption is an extremely common component used in more complex encryption algorithms used nowadays. The XOR encryption algorithm is an example of symmetric encryption where the same key is used to both encrypt and decrypt a message.";
  const key = '12345678901234567890123456789012';

  try {
    // Encrypt
    final encrypted = XorCipher.encrypt(plaintext, key);
    print('Encrypted (base64):\n$encrypted');

    // Decrypt
    final decrypted = XorCipher.decrypt(encrypted, key);
    print('Decrypted:\n$decrypted');
  } catch (e) {
    print('Error: $e');
  }
}
