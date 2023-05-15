import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
enum PrefKey{
  email,
  name,
  id,
  logIn
}
class PrefController {
  static final PrefController _instance = PrefController._();
  late SharedPreferences _sharedPreferences;
  factory PrefController(){
    return _instance;
  }
  PrefController._();
 Future<void>initPref()async{
   _sharedPreferences = await SharedPreferences.getInstance();
 }
 Future<void>save(User user)async{
 await _sharedPreferences.setString(PrefKey.email.toString(), user.email);
 await _sharedPreferences.setString(PrefKey.name.toString(), user.name);
 await _sharedPreferences.setString(PrefKey.id.toString(), user.id);
 await _sharedPreferences.setBool(PrefKey.logIn.toString(), true);
 }
 bool get loggedIn => _sharedPreferences.getBool(PrefKey.logIn.toString())??false;
 int get userId => _sharedPreferences.getInt(PrefKey.id.toString())??0;
Future<bool>clear()async=>await _sharedPreferences.clear();

T? getValue<T>({required String key}){
  return _sharedPreferences.get(key)as T?;
}
}


