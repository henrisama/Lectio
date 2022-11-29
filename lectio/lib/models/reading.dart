// ignore_for_file: non_constant_identifier_names

import 'package:lectio/config/DBHelper.dart';
import 'package:sqflite/sqflite.dart';

class Reading {
  int? _id;
  String? _title;
  String? _author;
  String? _status;
  String? _date_opening;
  String? _date_closing;
  int? _reader;

  Reading(this._id, this._title, this._author, this._status, this._date_opening,
      this._date_closing, this._reader);

  Reading.fromMap(Map map) {
    _id = map['id'];
    _title = map['title'];
    _author = map['author'];
    _status = map['status'];
    _date_opening = map['date_opening'];
    _date_closing = map['date_closing'];
    _reader = map['reader'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'title': _title,
      'author': _author,
      'status': _status,
      'date_opening': _date_opening,
      'date_closing': _date_closing,
      'reader': _reader,
    };
  }

  @override
  String toString() {
    return '''Dog{
      id: $_id,
      title: $_title, 
      author: $_author, 
      status: $_status, 
      date_opening: $_date_opening,
      date_closing: $_date_closing,
      reader: $_reader}''';
  }

  static Future<List<Reading>> getReadingsByUserId(int userId) async {
    Database db = await DBHelper.instance.database;
    List<Map> raw =
        await db.rawQuery('SELECT * FROM Reading WHERE reader = ?', [userId]);

    if (raw.isNotEmpty) {
      List<Reading> readings = [];

      for (var element in raw) {
        readings.add(Reading.fromMap(element));
      }

      return readings;
    } else {
      return [];
    }
  }

  Future<int> create() async {
    Database db = await DBHelper.instance.database;
    int result = await db.insert('Reading', toMap());
    return result;
  }

  Future<int> update() async {
    Database db = await DBHelper.instance.database;
    int result =
        await db.update('Reading', toMap(), where: 'id = ?', whereArgs: [_id]);
    return result;
  }

  Future<int> delete() async {
    Database db = await DBHelper.instance.database;
    int result = await db.delete('Reading', where: 'id = ?', whereArgs: [_id]);
    return result;
  }
}
