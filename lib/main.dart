import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mousaab_test/pages/home.dart';
import 'package:mousaab_test/pages/login.dart';
import 'package:mousaab_test/pages/main_page.dart';

import 'package:mousaab_test/pages/profile.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: EasyLoading.init(),
       debugShowCheckedModeBanner: false,
       color: Colors.amberAccent,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
    
      ),
      home: MainPage(),
      routes: {
    '/login': (context) =>  LoginPage(),
    '/profile': (context) =>  Profile(),
    '/Home': (context) =>  Home(),
  }, 
    );
  }
}
