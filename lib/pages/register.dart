import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mousaab_test/pages/login.dart';

class Register extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _Registerpage createState() => new _Registerpage();
}

class _Registerpage extends State<Register> {
  @override
  void initState() {
    datebirthController.text = "";
    super.initState();
  }

  bool showpass = false;
  bool err = false;
  bool showpassconfirm = false;
  List gender = ["Male", "Female"];
  int _check = 1;
  String select = '';
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController passwordConfirmController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController datebirthController = new TextEditingController();
  bool loading = false;

  ///Firbase////////
  Future registerEmailPassword() async {
    EasyLoading.show(status: 'loading...');
    try {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      EasyLoading.dismiss();
      EasyLoading.removeAllCallbacks();
      if (result.user != null) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(result.user?.uid)
            .set({
          'Full_Name': usernameController.text,
          'Email': emailController.text,
          'Phone': phoneController.text,
          'Address': addressController.text,
          'Date_Birth': datebirthController.text,
          'Gendre': _check == 1 ? "Male" : "Female",
        }).then((value) => Navigator.pushNamed(
                  context,
                  '/Home',
                  arguments: {'id': 'DuYt8kkjdUNv3UDwZPM1jI3IQBC2'},
                ));
      }
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  bool confrimPass() {
    if (passwordController.text == passwordConfirmController.text &&
        passwordConfirmController.text != "" &&
        usernameController.text != "" &&
        datebirthController.text != "" &&
        phoneController.text != "" &&
        addressController.text != "" &&
        emailController.text != "") {
      return true;
    } else {
      return false;
    }
  }

  Future Disable() async {
    await new Future.delayed(const Duration(seconds: 5));
    setState(() {
      this.err = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Row add_radio_button(int btnValue, String title) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            activeColor: Colors.green,
            value: btnValue,
            groupValue: _check,
            onChanged: (value) {
              setState(() => {_check = value!});
            },
          ),
          Text(title)
        ],
      );
    }

    final logo = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Hero(
          tag: 'GoViral',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(500),
            child: Image.network(
              "https://scontent.fcmn1-1.fna.fbcdn.net/v/t39.30808-6/301698753_471498834986866_6409286780446686159_n.png?_nc_cat=106&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeG1TJLRafwbrfX7mNW1Q9Ix-aP1CAcQhMv5o_UIBxCEywQMHC1ZHAY8tB4SlYKVY7GcprSoSN2My8nIO4wI8U6b&_nc_ohc=dJbHni1dx7oAX_PynSB&_nc_oc=AQkxctcYJZwYOVy1TkZNgzMn3nYb3hclQHZpZLYxpUmmLAwgTxdFB-2bElbN--5GcX0&_nc_zt=23&_nc_ht=scontent.fcmn1-1.fna&oh=00_AfCJX9_EkVbD1l3U5GK5HXDKmF3xVC2S3qxmk0_KDEXmKA&oe=6385C825",
              width: 60,
              height: 90,
            ),
          )),
    );
    final Text_app = Container(
      child: Center(
        child: Text(
          "Create New Account",
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 38,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
    final username = Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: usernameController,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.perm_identity_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Full Name',
            hintText: 'Enter Full Name'),
      ),
    );
    final phone = Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: phoneController,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Phone',
            hintText: 'Enter Number Phone'),
      ),
    );
    final address = Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: addressController,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.map_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Address',
            hintText: 'Enter Address'),
      ),
    );
    final email = Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: emailController,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Email',
            hintText: 'Enter valid mail id as abc@gmail.com'),
      ),
    );
    final datebirth = Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: datebirthController,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              lastDate: DateTime(2100));
          if (pickedDate != null) {
            print(pickedDate);
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            print(formattedDate);
            setState(() {
              datebirthController.text =
                  formattedDate; //set output date to TextField value.
            });
          } else {}
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Enter Date',
            hintText: 'Enter your Date Birth'),
      ),
    );
    final gender = Container(
      margin: const EdgeInsets.fromLTRB(50, 15, 50, 00),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Gender : ',
              ),
              add_radio_button(1, 'Male'),
              add_radio_button(2, 'Female'),
            ],
          ),
        ],
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
            ), //icon at tail of input
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Password',
            hintText: 'Enter your secure password'),
      ),
    );
    final ConfirmPassword = Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: passwordConfirmController,
        obscureText: showpassconfirm ? false : true,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              iconSize: 40,
              icon: Icon(
                showpassconfirm ? Icons.remove_red_eye : Icons.visibility_off,
                size: 30.0,
              ),
              onPressed: () async {
                setState(() {
                  this.showpassconfirm = !showpassconfirm;
                });
              },
            ), //icon at tail of input
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Confirm Password',
            hintText: 'Enter your Confirm password'),
      ),
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 8.0),
      child: Container(
        child: RawMaterialButton(
          fillColor: Color.fromARGB(255, 6, 40, 44),
          elevation: 0.0,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          onPressed: () async {
            if (confrimPass()) {
              registerEmailPassword();
            } else {
              setState(() {
                this.err = true;
              });
              Disable();
            }
          },
          child: Text(
            "Sign in",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
    final erreurmessage = Padding(
      padding: const EdgeInsets.all(5.0),
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
    final haveAccount = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already Have An Account ?",
          style: TextStyle(fontSize: 15),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 17),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: const Text(
            'Sign-up',
            style: TextStyle(color: Colors.lightBlue),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 209, 237, 191),
      appBar: PreferredSize(
        preferredSize: Size(0, 0), //width and height
        // The size the AppBar would prefer if there were no other constraints.
        child: Container(),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 15.0),
            Text_app,
            SizedBox(height: 10.0),
            username,
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 8.0),
            phone,
            SizedBox(height: 8.0),
            address,
            SizedBox(height: 8.0),
            datebirth,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 8.0),
            ConfirmPassword,
            SizedBox(height: 8.0),
            gender,
            loginButton,
            SizedBox(height: 8.0),
            err ? erreurmessage : Container(),
            haveAccount
          ],
        ),
      ),
    );
  }
}
