// ignore_for_file: avoid_print

import 'package:encrypt/encrypt.dart';
import 'isolates_and_async.dart';
import 'dart:isolate';

void main() async {
  // 1st way: (actually it is not the way, just we await for the first call)
  // Encrypted encrypted = await encryptInBackground("wha's up");
  // decryptInBackground(encrypted).then((decrypted) => {print(decrypted)});

  // 2nd way:
  encryptInBackground("hii").then((encrypted) => {
        decryptInBackground(encrypted).then((decrypted) => {
              print(decrypted),
            })
      });

  // some routine, to show that the isolate is working
  for (int i = 1; i <= 10; i++) {
    await Future.delayed(Duration(seconds: 1), () => {print(i)});
  }
}

Future<Encrypted> encryptInBackground(String message) async {
  final receivePort = ReceivePort();
  Isolate.spawn(EncryptData.encryptAES, [receivePort.sendPort, message]);
  return await receivePort.first;
}

Future<String> decryptInBackground(Encrypted encrypted) async {
  final receivePort = ReceivePort();
  Isolate.spawn(EncryptData.decryptAES, [receivePort.sendPort, encrypted]);
  return await receivePort.first;
}
