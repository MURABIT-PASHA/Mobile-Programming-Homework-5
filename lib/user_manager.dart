import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserManager {
  Future<List<String>> readUsers() async {
    List<String> userList = [];
    final file = await _localFile;
    var sinkR = file.openRead();
    if (await file.exists()) {
      try {
        await sinkR
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .forEach((line) {
          userList.add(line);
        });
        return userList;
      } catch (e) {
        return userList;
      }
    } else {
      return userList;
    }
  }

  Future<bool> controlUser(String username, String password) async {
    bool returnType = false;
    final file = await _localFile;
    var sinkR = file.openRead();
    if (await file.exists()) {
      try {
        await sinkR
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .forEach((line) {
          var user = line.toString().split(",");
          if (user[0] == username && user[1] == password) {
            returnType = true;
          }
        });
        return returnType;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> findUser(String username) async {
    bool returnType = false;
    final file = await _localFile;
    var sinkR = file.openRead();
    if (await file.exists()) {
      try {
        await sinkR
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .forEach((line) {
          var user = line.toString().split(",");
          if (user[0] == username) {
            returnType = true;
          }
        });
        return returnType;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> addUser(String username, String password, String name) async {
    if (!await findUser(username) && !(await readUsers() == [])) {
      final file = await _localFile;
      var sinkW = file.openWrite(mode: FileMode.append);
      sinkW.write("$username,$password,$name\n");
      sinkW.close();
      return true;
    } else if (!await findUser(username) && (await readUsers() == [])){
      final file = await _localFile;
      var sinkW = file.openWrite(mode: FileMode.write);
      sinkW.write("$username,$password,$name\n");
      sinkW.close();
      return true;
    }else{
      return false;
    }
  }

  Future<String> getUserName(String username, String password) async {
    String name = "";
    final file = await _localFile;
    var sinkR = file.openRead();
    if (await file.exists()) {
      try {
        await sinkR
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .forEach((line) {
          var user = line.toString().split(",");
          if (user[0] == username && user[1] == password) {
            name = user[2];
          }
        });
        return name;
      } catch (e) {
        return name;
      }
    } else {
      return name;
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/users.txt');
  }
}
