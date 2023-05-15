import 'package:moqbel/database/controller/db_controller.dart';
import 'package:moqbel/database/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class UserProvider extends ChangeNotifier {
  UserController userController = UserController();

  Future<bool> login({required String email, required String password}) async {
    return await userController.login(email: email, password: password);
  }

  Future<bool> create(user) async {
    int newRowId = await userController.create(user);
    return newRowId != 0;
  }

  Future<bool> delete(int id) async {
    return await userController.delete(id);
  }

  Future<bool> update(user) async {
    return await userController.update(user);
  }
}
