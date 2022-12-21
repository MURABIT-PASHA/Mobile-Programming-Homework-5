import 'package:sqflite/sqflite.dart';
import 'package:homework_5/event.dart';
class EventDatabaseManager {
  static const String tableName = 'events';
  static const String columnId = 'id';
  static const String columnEventDate = 'eventDate';
  static const String columnEventId = 'eventId';
  static const String columnEventName = 'eventName';
  var _database;

  Future<void> init() async {
    // Open the database and store the reference to it in _database
    _database = await openDatabase(
      // Set the path to the database file
      'events.db',
      // When the database is first created, run the `onCreate` function
      onCreate: (db, version) {
        return db.execute(
          // Create a table to store events
          'CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, $columnEventDate TEXT, $columnEventId INTEGER, $columnEventName TEXT)',
        );
      },
      // Set the version of the database. This allows you to make changes to the
      // structure of the database and increment the version number, which will
      // trigger the `onUpgrade` function the next time the database is opened
      version: 1,
    );
  }

  Future<void> close() async {
    // Close the database
    await _database.close();
  }

  Future<int> addEvent(Event event) async {
    // Insert a new event into the database
    return await _database.insert(
      tableName,
      event.toMap(),
      // Set the `conflictAlgorithm` to replace any existing event with the same ID
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteEvent(int id) async {
    // Delete the event with the given ID from the database
    await _database.delete(
      tableName,
      // Use the `where` clause to delete the event with the given ID
      where: '$columnId = ?',
      // Pass the ID as a list of arguments
      whereArgs: [id],
    );
  }

  Future<void> updateEvent(Event event) async {
    // Update the event in the database
    await _database.update(
      tableName,
      event.toMap(),
      // Use the `where` clause to update the event with the given ID
      where: '$columnId = ?',
      // Pass the ID as a list of arguments
      whereArgs: [event.eventId],
    );
  }

  Future<List<Event>> getAllEvents() async {
    // Get a list of all events in the database
    final List<Map<String, dynamic>> maps = await _database.query(tableName);

    // Convert the list of maps into a list of events
    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }
}
