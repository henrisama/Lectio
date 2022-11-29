import 'package:flutter/foundation.dart';
import 'package:lectio/config/DBHelper.dart';
import 'package:sqflite/sqflite.dart';

class User {
  late int _id;
  String? _name;
  String? _born;
  String? _sex;
  String? _username;
  String? _password;
  Uint8List? _photo;

  User();

  User.fromMap(Map map) {
    _id = map['id'];
    _name = map['name'];
    _born = map['born'];
    _sex = map['sex'];
    _username = map['username'];
    _password = map['password'];
    _photo = map['photo'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'born': _born,
      'sex': _sex,
      'username': _username,
      'password': _password,
      'photo': _photo,
    };
  }

  @override
  String toString() {
    return '''User{
      id: $_id,
      name: $_name, 
      born: $_born, 
      sex: $_sex, 
      username: $_username,
      password: $_password}
      photo: $_photo,''';
  }

  int? get getId => _id;

  void setName(String name) {
    _name = name;
  }

  void setBorn(String born) {
    _born = born;
  }

  void setUsername(String username) {
    _username = username;
  }

  void setPassword(String password) {
    _password = password;
  }

  static Future<User?> getUserById(int id) async {
    Database db = await DBHelper.instance.database;
    List<Map> raw = await db.rawQuery('SELECT * FROM User WHERE id = ?', [id]);

    if (raw.isNotEmpty) {
      return User.fromMap(raw.first);
    } else {
      return null;
    }
  }

  static Future<User?> getUserByUsername(String username) async {
    Database db = await DBHelper.instance.database;
    List<Map> raw =
        await db.query('User', where: '"username" = ?', whereArgs: [username]);

    if (raw.isNotEmpty) {
      return User.fromMap(raw.first);
    } else {
      return null;
    }
  }

  int comparePassword(String password) {
    return _password == password ? 1 : 0;
  }

  Future<int> create() async {
    Database db = await DBHelper.instance.database;
    int result = await db.insert('User', toMap());
    return result;
  }

  Future<int> update() async {
    Database db = await DBHelper.instance.database;
    int result =
        await db.update('User', toMap(), where: 'id = ?', whereArgs: [_id]);
    return result;
  }

  Future<int> delete() async {
    Database db = await DBHelper.instance.database;
    int result = await db.delete('User', where: 'id = ?', whereArgs: [_id]);
    return result;
  }
}
