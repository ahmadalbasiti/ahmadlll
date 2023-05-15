import 'package:moqbel/database/controller/db_controller.dart';
import 'package:moqbel/screen/app/note_screen.dart';
import 'package:moqbel/screen/app/notes_screen.dart';
import 'package:moqbel/screen/auth/register_screen.dart';
import 'package:moqbel/storge/pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen/auth/login.dart';
import 'screen/lunch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbController().initDatabase();
  await PrefController().initPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/lunch_screen',
        routes: {
          '/lunch_screen': (context) => const LunchScreen(),
          '/login_screen': (context) => const LoginScreen(),
          '/register_screen': (context) => const RegisterScreen(),
          '/note_screen': (context) => const NoteScreen(),
          '/notes_screen': (context) => const NotesScreen(),
        });
  }
}

/*
MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
        ChangeNotifierProvider<NoteProvider>(create: (context)=>NoteProvider()),
      ],
      child:
 */
