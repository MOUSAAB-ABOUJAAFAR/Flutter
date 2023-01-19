import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mousaab_test/pages/HomePage.dart';
import 'package:mousaab_test/pages/home.dart';
import 'package:mousaab_test/pages/login.dart';


class MainPage extends StatelessWidget {
const MainPage({super.key});
Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebase = await Firebase.initializeApp();
    return firebase;

  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Home();
        }else{
          return LoginPage();
        }

      },
      ),
    );
  }
}