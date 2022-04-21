// ignore_for_file: avoid_print

library flutter_application_1;

import 'dart:isolate';

import 'package:encrypt/encrypt.dart';

class EncryptData {
//for AES Algorithms

  static Encrypted? encrypted;
  static var decrypted;

  static encryptAES(List<dynamic> data) async {
    SendPort sendPort = data[0];
    String plainText = data[1];

    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    encrypted = encrypter.encrypt(plainText, iv: iv);

    Isolate.exit(sendPort, encrypted);
  }

  static decryptAES(List<dynamic> data) {
    SendPort sendPort = data[0];
    Encrypted? encrypted = data[1];

    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    decrypted = encrypter.decrypt(encrypted!, iv: iv);

    Future.delayed(
        Duration(seconds: 5),
        () => {
              Isolate.exit(sendPort, decrypted),
            });

    // OR without delay:
    // Isolate.exit(sendPort, decrypted);
  }
}
