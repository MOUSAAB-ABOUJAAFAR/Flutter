import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});
    Future Signout() async {
    await FirebaseAuth.instance.signOut();
   
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Center(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("You Are login" , style: TextStyle(fontSize: 40.0),),
           RawMaterialButton(
          fillColor: Color.fromARGB(255,6,40,44),
          elevation: 0.0,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          onPressed: (){
            Signout();
          },
          child: Text("Sign out",style: TextStyle(color: Colors.white , fontSize:  20.0 , fontStyle: FontStyle.italic),),
        ),
           
        ],
      )),
    );
  }
}