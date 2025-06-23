import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/auth/auth.dart';
import 'package:the_wall/auth/login_or_register.dart';
import 'package:the_wall/firebase_options.dart';
import 'package:the_wall/screens/home_screen.dart';
import 'package:the_wall/screens/login_screen.dart';
import 'package:the_wall/screens/profile_screen.dart';
import 'package:the_wall/screens/register_screen.dart';
import 'package:the_wall/screens/users_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      routes: {
        '/login_register': (context) => const LoginOrRegister(),
        '/home_screen': (context) => HomeScreen(),
        '/profile_screen': (context) => ProfileScreen(),
        '/users_screen': (context) => const UsersScreen(),
      },
    );
  }
}
