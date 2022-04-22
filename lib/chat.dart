import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:encrypt/encrypt.dart';

import 'consts.dart';
import 'isolates_and_async.dart';

class Chat {
  static File? _allMessages;
  static File? _encryptedValues;

  static void _createFiles() {
    File("C:\\Users\\Elvin\\Desktop\\tempFile.txt").create();
    File("C:\\Users\\Elvin\\Desktop\\encrFile.txt").create();

    _allMessages = File("C:\\Users\\Elvin\\Desktop\\tempFile.txt");
    _encryptedValues = File("C:\\Users\\Elvin\\Desktop\\encrFile.txt");
  }

  static void start() {
    String? _message;

    _welcoming();
    _createFiles();

    while (_message != Consts.CLOSE) {
      _message = stdin.readLineSync(encoding: utf8);

      switch (_message) {
        case Consts.BACKUP:
          Isolate.spawn(_backup, [_allMessages!, _encryptedValues!]);
          break;

        case Consts.RESTORE:
          Isolate.spawn(_restore, _encryptedValues!);
          break;

        case Consts.CLOSE:
          _close();
          break;

        default:
          if (_message != null && _message.length >= 2) {
            _store(_message);
          }
      }
    }
  }

  static void _welcoming() {
    print("Hello, dear user.\n" +
        "> In order to save messages, type \"-backup\"\n" +
        "> In order to see saved messages, type \"-restore\"\n" +
        "> In order to exit program, type \"-close\"");
  }

  static void _close() {
    print("You typed: -close");
    _deleteFile([_allMessages, _encryptedValues]);
    print("All data is deleted!");
  }

  static void _backup(List<dynamic> args) async {
    File file = args[0];
    File encrFile = args[1];
    bool isFirstTime = true;

    print("You typed: -backup");

    if (!file.existsSync()) {
      print("There is not any messages out there!");
      return;
    }

    for (String line in file.readAsLinesSync()) {
      Encrypted value = await EncryptData.encryptInBackground(line);

      if (isFirstTime) {
        encrFile.writeAsStringSync(value.base64 + '\n');
        isFirstTime = false;
      } else {
        encrFile.writeAsStringSync(value.base64 + '\n', mode: FileMode.append);
      }
    }

    print("Data is saved!");
  }

  static void _restore(File encrValues) async {
    print("You typed: -restore");

    if (!encrValues.existsSync()) {
      print("There is not any saved messages out there!");
      return;
    }

    print("Save messages are:");
    for (String line in encrValues.readAsLinesSync()) {
      String value =
          await EncryptData.decryptInBackground(Encrypted.from64(line));
      print(value);
    }
  }

  static void _store(String message) {
    _allMessages!.writeAsStringSync(message + "\n", mode: FileMode.append);
  }

  static Future<void> _deleteFile(List<File?> files) async {
    for (File? file in files) {
      if (await file!.exists()) {
        await file.delete();
      }
    }
  }
}
