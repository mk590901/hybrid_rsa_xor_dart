import 'package:uuid/uuid.dart';

String shortUuid({int length = 4}) {
  return const Uuid().v4().substring(0,length < 4 ? 4 : length > 5 ? 5 : length);
}

void testShortUuid() {
  for (int i = 0; i < 16; i++) {
    print("[${shortUuid()}]");
  }
}

