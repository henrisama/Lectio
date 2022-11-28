import 'package:flutter/foundation.dart';
import 'package:lectio/config/DBHelper.dart';
import 'package:sqflite/sqflite.dart';

class User {
  int? _id;
  String? _name;
  String? _born;
  String? _sex;
  String? _username;
  String? _password;
  Uint8List? _photo;

  User(this._id, this._name, this._born, this._sex, this._photo, this._username,
      this._password);

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
    return '''Dog{
      id: $_id,
      name: $_name, 
      born: $_born, 
      sex: $_sex, 
      username: $_username,
      password: $_password}
      photo: $_photo,''';
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
