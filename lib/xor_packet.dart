import 'dart:convert';

class XorPacket {
  final List<BigInt>  encryptedKey;
  final String        encryptedKeyId;
  final String        encryptedText;
  final String        sink;
  XorPacket(this.sink, this.encryptedKey, this.encryptedText, this.encryptedKeyId);

  String toJsonString() {
    final Map<String, dynamic> jsonMap = {
      'encrypted_key':  encryptedKey.map((bigInt) => bigInt.toString()).toList(),
      'id':             encryptedKeyId,
      'sink':           encryptedKeyId,
      'encrypted_text': encryptedText,
    };
    return jsonEncode(jsonMap);
  }

  XorPacket.fromJsonString(String jsonString)
      : this._fromJsonMap(jsonDecode(jsonString));

  XorPacket._fromJsonMap(Map<String, dynamic> decoded)
      : encryptedKey    = (decoded['encrypted_key'] as List)
      .map((str) => BigInt.parse(str as String))
      .toList(),
        encryptedKeyId  = decoded['id'] as String,
        sink            = decoded['sink'] as String? ?? '?sink',
        encryptedText   = decoded['encrypted_text'] as String;

  // XorPacket.fromJsonString(String jsonString) :
  //       encryptedKey    = (jsonDecode(jsonString)['encrypted_key'] as List)
  //           .map((str) => BigInt.parse(str as String))
  //           .toList(),
  //       encryptedKeyId  = jsonDecode(jsonString)['id'],
  //       sink            = jsonDecode(jsonString)['sink']?? '?sink',
  //       encryptedText   = jsonDecode(jsonString)['encrypted_text'];
}
