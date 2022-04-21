// ignore_for_file: avoid_print

import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'isolates_and_async.dart';
import 'dart:isolate';

void main() async {
  print("Code is executing");

  EncryptData.encryptInBackground("hii").then((encrypted) => {
        EncryptData.decryptInBackground(encrypted)
            .then((decrypted) => {print(decrypted)})
      });

  print("Start counting");
  // some routine, to show that the isolate is working
  for (int i = 1; i <= 10; i++) {
    await Future.delayed(Duration(seconds: 1), () => {print(i)});
  }
}

void filing() {
  File myFile = File('C:\\Users\\Elvin\\Desktop\\myFile.txt');
  myFile.writeAsStringSync("hello,");
  myFile.writeAsStringSync("hi man", mode: FileMode.append);
}
