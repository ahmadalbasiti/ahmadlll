import 'package:moqbel/database/controller/db_controller.dart';
import 'package:moqbel/database/controller/db_opration.dart';
import 'package:moqbel/storge/pref.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user.dart';

class UserController implements DBControllerOperation<User> {
  Database database = DbController().database;

  Future<bool>login({required String email,required String password})async{
    List<Map<String,dynamic>>maps= await database.query('user',where: 'email=? and password=?',whereArgs: [email,password]);
    if(maps.isNotEmpty){
      User user=User.fromMap(maps.first);
      PrefController().save(user);
    }
    return maps.isNotEmpty;
  }
  @override
  Future<int> create(User user) async {
    int newRowId = await database.insert('user', user.toMap());
    return newRowId;
  }

  @override
  Future<bool> delete(int id) async {
    int countOfDeleteRow =
        await database.delete('user', where: 'id = ?', whereArgs: [id]);
    return countOfDeleteRow == 1;
  }

  @override
  Future<List<User>> read() async {
    List<Map<String, dynamic>> row =
        await database.query('user', columns: ['id', 'name']);
    return row
        .map((Map<String, dynamic> rowMap) => User.fromMap(rowMap))
        .toList();
  }

  @override
  Future<User?> show(int id)async {
    List<Map<String,dynamic>> row = await database.query('user',where: 'id = ? ',whereArgs: [id]);
    if(row.isNotEmpty){
      return User.fromMap(row.first);
    }
  }

  @override
  Future<bool> update(user) async {
    int countOfUpdateRow = await database
        .update('user', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
    return countOfUpdateRow == 1;
  }
}
