// ignore_for_file: avoid_print

import 'isolates_and_async.dart';

import 'dart:io';

void main() async {
  File encrFile = File('C:\\Users\\Elvin\\Desktop\\encrFile.txt');
  File decrFile = File('C:\\Users\\Elvin\\Desktop\\decrFile.txt');

  operateMessage("hello", encrFile, decrFile);
  operateMessage("hey", encrFile, decrFile);

  print("bruh");
}

void operateMessage(String message, File encrFile, File decrFile) {
  EncryptData.encryptInBackground(message).then((encrypted) => {
        encrFile.writeAsStringSync(encrypted.base64 + '\n',
            mode: FileMode.append), // appending file

        EncryptData.decryptInBackground(encrypted).then((decrypted) => {
              decrFile.writeAsStringSync(decrypted + '\n',
                  mode: FileMode.append), // appending file
            })
      });
}

void filing() {
  File myFile = File('C:\\Users\\Elvin\\Desktop\\myFile.txt');

  myFile.writeAsStringSync("hello,");

  myFile.writeAsStringSync("\nhi man", mode: FileMode.append);
}
