// ignore_for_file: avoid_print

import 'package:flutter_application_1/consts.dart';

import 'isolates_and_async.dart';
import 'chat.dart';

import 'dart:io';

void main() {
  // File encrFile = File('C:\\Users\\Elvin\\Desktop\\encrFile.txt');
  // File decrFile = File('C:\\Users\\Elvin\\Desktop\\decrFile.txt');

  // operateMessage("hello", encrFile, decrFile);
  // operateMessage("hey", encrFile, decrFile);

  // print("bruh");

  Chat.start(Consts.AES);
}

// void operateMessage(String message, File encrFile, File decrFile) {
//   EncryptDecryptData.encryptInBackground(message).then((encrypted) => {
//         encrFile.writeAsStringSync(encrypted.base64 + '\n',
//             mode: FileMode.append), // appending file

//         EncryptDecryptData.decryptInBackground(encrypted).then((decrypted) => {
//               decrFile.writeAsStringSync(decrypted + '\n',
//                   mode: FileMode.append), // appending file
//             })
//       });
// }
