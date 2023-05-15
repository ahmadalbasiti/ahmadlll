import 'package:flutter/material.dart';

import '../storge/pref.dart';

class LunchScreen extends StatefulWidget {
  const LunchScreen({Key? key}) : super(key: key);

  @override
  State<LunchScreen> createState() => _LunchScreenState();
}

class _LunchScreenState extends State<LunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 3), () {
      // String route = PrefController().loggedIn?'/login_screen':'/notes_screen';
      Navigator.pushReplacementNamed(context, '/login_screen');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Lunch Screen',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
