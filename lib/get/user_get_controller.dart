import 'package:moqbel/database/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserGetController extends GetxController {
  UserController userController = UserController();


  static UserGetController get to => Get.find();

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

  Future<bool> updateUser(user) async {
    return await userController.update(user);
  }
}
