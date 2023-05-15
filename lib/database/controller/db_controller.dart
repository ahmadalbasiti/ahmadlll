import 'dart:io';

 import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbController {
  static final DbController _instance = DbController._();

  factory DbController() {
    return _instance;
  }

  DbController._();

  late Database _database;
 Database get database => _database;
  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,'db.sql');
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      db.execute('CREATE TABLE users ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'name TEXT,'
          'email TEXT,'
          'password TEXT,'
          ')');
      db.execute('CREATE TABLE note('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'title TEXT,'
          'details TEXT,'
          'user_id INTEGER,'
          'FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE'
          ')');
    });
  }
}
