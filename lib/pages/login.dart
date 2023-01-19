import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mousaab_test/pages/home.dart';
import 'package:mousaab_test/pages/main_page.dart';
import 'package:mousaab_test/pages/register.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showpass = false;
  bool erreur_ = false;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool CheackData() {
    if (passwordController.text != "" && emailController.text != "") {
      return true;
    } else {
      return false;
    }
  }

  Future Disable() async {
    await new Future.delayed(const Duration(seconds: 5));
    setState(() {
      this.erreur_ = false;
    });
  }

//////Firebase Login ///////////////
  Future LoginEmailPassword() async {
    EasyLoading.show(status: 'loading...');
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) => {
                Navigator.pushNamed(
                  context,
                  '/Home',
                  arguments: {'id': FirebaseAuth.instance.currentUser!.uid},
                )
              });
      EasyLoading.dismiss();
      EasyLoading.removeAllCallbacks();
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
        tag: 'GoViral',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(500),
          child: Image.network(
            "https://scontent.fcmn1-1.fna.fbcdn.net/v/t39.30808-6/301698753_471498834986866_6409286780446686159_n.png?_nc_cat=106&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeG1TJLRafwbrfX7mNW1Q9Ix-aP1CAcQhMv5o_UIBxCEywQMHC1ZHAY8tB4SlYKVY7GcprSoSN2My8nIO4wI8U6b&_nc_ohc=dJbHni1dx7oAX_PynSB&_nc_oc=AQkxctcYJZwYOVy1TkZNgzMn3nYb3hclQHZpZLYxpUmmLAwgTxdFB-2bElbN--5GcX0&_nc_zt=23&_nc_ht=scontent.fcmn1-1.fna&oh=00_AfCJX9_EkVbD1l3U5GK5HXDKmF3xVC2S3qxmk0_KDEXmKA&oe=6385C825",
            width: 60,
            height: 90,
          ),
        ));
    final Text_app = Container(
      child: Center(
        child: Text(
          "Login to your Account",
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 37,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
    final email = Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: emailController,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.perm_identity_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Email',
            hintText: 'Enter valid mail id as abc@gmail.com'),
      ),
    );

    final password = Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: passwordController,
        obscureText: showpass ? false : true,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              iconSize: 40,
              icon: Icon(
                showpass ? Icons.remove_red_eye : Icons.visibility_off,
                size: 30.0,
              ),
              onPressed: () async {
                setState(() {
                  this.showpass = !showpass;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Password',
            hintText: 'Enter your secure password'),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        child: RawMaterialButton(
          fillColor: Color.fromARGB(255, 6, 40, 44),
          elevation: 0.0,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          onPressed: () async {
            if (CheackData()) {
              LoginEmailPassword();
            } else {
              setState(() {
                this.erreur_ = true;
              });
              Disable();
            }
          },
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );

    final Signbutton = Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: Container(
        child: RawMaterialButton(
          fillColor: Color.fromARGB(255, 255, 208, 189),
          elevation: 0.0,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Register()),
            );
          },
          child: Text(
            "Sign In",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );
    final erreurmessage = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        width: 50,
        color: Colors.red,
        child: Center(
            child: Text(
          "Password or email not Confirmed !!",
          style: TextStyle(
              color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
        )),
      ),
    );
    final forgotLabel = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 17),
            ),
            onPressed: null,
            child: const Text(
              'Forget Your Password ?',
              style: TextStyle(color: Colors.lightBlue),
            ),
          ),
        ]);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 209, 237, 191),
      appBar: PreferredSize(
        preferredSize: Size(0, 0),
        child: Container(),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 10.0),
            Text_app,
            SizedBox(height: 10.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            SizedBox(height: 5.0),
            Signbutton,
            erreur_ ? erreurmessage : Container(),
            SizedBox(height: 5.0),
            forgotLabel
          ],
        ),
      ),
    );
  }
}
