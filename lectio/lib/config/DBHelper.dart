import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper instance = DBHelper._();

  static Database? _database;

  Future<Database> get database async => _database ??= await _init();

  _init() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'lectio.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    await db.execute('''
        PRAGMA foreign_keys = ON;

        CREATE TABLE IF EXISTS User(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          born TEXT NOT NULL,
          sex ENUM('M' OR 'F'),
          username TEXT NOT NULL,
          password TEXT NOT NULL,
          photo BLOB
        );

        CREATE TABLE IF EXISTS Reading(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          author TEXT NOT NULL,
          status ENUM('read','reading','to read')
          date_opening TEXT NOT NULL,
          date_closing TEXT NOT NULL,
          reader INTEGER NOT NULL
        );

        ALTER TABLE Readou ADD FOREIGN KEY (reader) REFERENCES User(id);
      ''');
  }
}
