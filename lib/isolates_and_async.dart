// ignore_for_file: avoid_print

library flutter_application_1;

import 'dart:isolate';

import 'package:encrypt/encrypt.dart';

class EncryptData {
//for AES Algorithms

  static Encrypted? _encrypted;
  static var _decrypted;

  static Future<Encrypted> encryptInBackground(String message) async {
    final receivePort = ReceivePort();
    Isolate.spawn(EncryptData._encryptAES, [receivePort.sendPort, message]);
    return await receivePort.first;
  }

  static Future<String> decryptInBackground(Encrypted encrypted) async {
    final receivePort = ReceivePort();
    Isolate.spawn(EncryptData._decryptAES, [receivePort.sendPort, encrypted]);
    return await receivePort.first;
  }

  static _encryptAES(List<dynamic> data) async {
    SendPort sendPort = data[0];
    String plainText = data[1];

    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    _encrypted = encrypter.encrypt(plainText, iv: iv);

    Isolate.exit(sendPort, _encrypted);
  }

  static _decryptAES(List<dynamic> data) {
    SendPort sendPort = data[0];
    Encrypted? encrypted = data[1];

    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    _decrypted = encrypter.decrypt(encrypted!, iv: iv);

    Future.delayed(
        Duration(seconds: 5),
        () => {
              Isolate.exit(sendPort, _decrypted),
            });

    // OR without delay:
    // Isolate.exit(sendPort, decrypted);
  }
}
