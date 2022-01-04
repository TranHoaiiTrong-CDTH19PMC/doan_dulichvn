import 'package:flutter/material.dart';
import 'package:travel_app_flutter/screens/home_screen.dart';
import 'package:travel_app_flutter/screens/sign_in.dart';
import 'package:travel_app_flutter/screens/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SignIn(),
        Screen.routeName: (context) => HomeScreen(),
        UpScreen.routeName: (context) => SignUp(),
      },
    );
  }
}
