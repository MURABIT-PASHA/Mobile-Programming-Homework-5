import 'package:homework_5/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabaseManager {
  static final UserDatabaseManager _instance = UserDatabaseManager._internal();

  factory UserDatabaseManager() {
    return _instance;
  }

  UserDatabaseManager._internal();

  static late Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'users.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE users (
        turkishId TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        surname TEXT NOT NULL,
        password TEXT NOT NULL,
        dob DATE NOT NULL,
        maritalStatus TEXT NOT NULL,
        interests TEXT NOT NULL,
        hasDriverLicense INTEGER NOT NULL
      )
      ''',
    );
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<void> addUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUser(User user) async {
    final db = await database;
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(String turkishId) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'turkish_id = ?',
      whereArgs: [turkishId],
    );
  }

  Future<User?> getUser({
    required String turkishId,
    required String password,
  }) async {
    final db = await database;
    final results = await db.query(
      'users',
      where: 'turkish_id = ? AND password = ?',
      whereArgs: [turkishId, password],
    );
    if (results.isEmpty) {
      return null;
    }
    return User.fromMap(results.first);
  }




}
