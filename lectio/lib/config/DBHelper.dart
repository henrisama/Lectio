// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper instance = DBHelper._();

  static Database? _database;

  Future<Database> get database async => _database ??= await _init();

  _init() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'lectio_db.db'),
      version: 1,
      readOnly: false,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    await db.execute("PRAGMA foreign_keys = ON;");
    await db.execute(_createUser());
    await db.execute(_createReading());
  }

  String _createUser() {
    return '''
      CREATE TABLE IF NOT EXISTS User(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          born TEXT NOT NULL,
          sex CHECK(sex IN ('M','F')),
          username TEXT NOT NULL UNIQUE,
          password TEXT NOT NULL,
          photo BLOB
        );
    ''';
  }

  String _createReading() {
    return '''
      CREATE TABLE IF NOT EXISTS Reading(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          author TEXT NOT NULL,
          status CHECK(status IN ('read','reading','to read')),
          date_opening TEXT NOT NULL,
          date_closing TEXT NOT NULL,
          reader INTEGER NOT NULL,
          FOREIGN KEY (reader) REFERENCES User(id)
            ON DELETE CASCADE ON UPDATE CASCADE
        );
    ''';
  }
}
