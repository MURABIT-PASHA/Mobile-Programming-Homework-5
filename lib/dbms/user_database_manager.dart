import 'package:homework_5/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabaseManager {
  static final UserDatabaseManager _instance = UserDatabaseManager._internal();
  factory UserDatabaseManager() => _instance;
  UserDatabaseManager._internal();
  static var _database;

  Future<void> init() async {
    if (_database != null) {
      return;
    }

    try {
      String path = join(await getDatabasesPath(), 'users.db');
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            '''
              CREATE TABLE users (
                turkishId TEXT PRIMARY KEY,
                name TEXT NOT NULL,
                surname TEXT NOT NULL,
                password TEXT NOT NULL,
                dateOfBirth TEXT NOT NULL,
                maritalStatus TEXT NOT NULL,
                interests TEXT NOT NULL,
                hasDriverLicense INTEGER NOT NULL
              )
            ''',
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = _database;
    return await db.query('users');
  }

  Future<void> addUser(User user) async {
    final db = await _database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUser(User user) async {
    final db = await _database;
    await db.update(
      'users',
      user.toMap(),
      where: 'turkishId = ?',
      whereArgs: [user.turkishId],
    );
  }

  Future<int> deleteUser(String turkishId) async {
    final db = await _database;
    return await db.delete(
      'users',
      where: 'turkishId = ?',
      whereArgs: [turkishId],
    );
  }

  Future<User?> getUser({
    required String turkishId,
    required String password,
  }) async {
    printAllRows();
    final db = await _database;
    final results = await db.query(
      'users',
      where: 'turkishId = ? AND password = ?',
      whereArgs: [turkishId, password],
    );
    if (results.isEmpty) {
      return null;
    }
    return User.fromMap(results.first);
  }
  Future<void> printAllRows() async {
    List<Map<String, dynamic>> rows = await _database.rawQuery('SELECT * FROM users');
    for (Map<String, dynamic> row in rows) {
      print(row);
    }
  }
}
