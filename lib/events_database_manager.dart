import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class EventsDatabaseManager {
  static final EventsDatabaseManager _instance = EventsDatabaseManager._internal();

  factory EventsDatabaseManager() {
    return _instance;
  }

  EventsDatabaseManager._internal();

  static late Database _database;

  Future<Database> get database async {
    if (_database.isOpen) {
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'events.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE events (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        date DATE NOT NULL,
        time TIME NOT NULL
      )
      ''',
    );
  }

  Future<List<Map<String, dynamic>>> getEvents() async {
    final db = await database;
    return await db.query('events');
  }

  Future<int> addEvent(Map<String, dynamic> event) async {
    final db = await database;
    return await db.insert('events', event);
  }

  Future<int> updateEvent(Map<String, dynamic> event) async {
    final db = await database;
    return await db.update(
      'events',
      event,
      where: 'id = ?',
      whereArgs: [event['id']],
    );
  }

  Future<int> deleteEvent(int id) async {
    final db = await database;
    return await db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}