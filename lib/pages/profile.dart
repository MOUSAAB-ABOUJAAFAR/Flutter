import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mousaab_test/pages/main_page.dart';

class Profile extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _Profile createState() => new _Profile();
}

class _Profile extends State<Profile> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  @override
  initState() {
    super.initState();
    EasyLoading.dismiss();
    EasyLoading.removeAllCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    Future Signout() async {
      await FirebaseAuth.instance.signOut();
    }

    final users = FirebaseFirestore.instance
        .collection("Users")
        .doc(arguments['id'])
        .get();

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 250, 230, 230),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            children: [
              Spacer(),
              FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 250, 230, 230),
                onPressed: () {
                  Signout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                },
                child: Icon(Icons.logout),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: Color.fromARGB(255, 250, 230, 230),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                'Profile',
                style: TextStyle(
                    color: Color.fromARGB(255, 180, 165, 165), fontSize: 25.0),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: FutureBuilder<DocumentSnapshot>(
          future: users,
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
                          ),
                          Positioned(
                            right: -5,
                            bottom: 0,
                            child: SizedBox(
                              height: 35,
                              width: 35,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(color: Colors.white),
                                  ),
                                  primary: Colors.white,
                                  backgroundColor: Color(0xFFF5F6F9),
                                ),
                                onPressed: () {},
                                child: Icon(Icons.camera_alt_rounded,
                                    color: Colors.black, size: 20.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Datafech(data, 'Full Name', 'Full_Name'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Datafech(data, 'Email', 'Email'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Datafech(data, 'Phone', 'Phone'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Datafech(data, 'Address', 'Address'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Datafech(data, 'Gender', 'Gendre'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Datafech(data, 'Date Birth', 'Date_Birth'),
                  ),
                ],
              );
            }

            return Center(
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Loading...",
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 37,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                      ),
                    )));
          },
        )));
  }

  Padding Datafech(Map<String, dynamic> data, String settings, String params) {
    return Padding(
      padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0, bottom: 1.0),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: null,
        child: Row(
          children: [
            SizedBox(width: 10),
            Expanded(
              child: Text(
                '${settings} :  ${data != null ? data[params] : ''}',
                style: TextStyle(
                    color: Color.fromARGB(255, 180, 165, 165), fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
