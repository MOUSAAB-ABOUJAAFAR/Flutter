import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _Home createState() => new _Home();
}

class _Home extends State<Home> {
  bool btnplus = false;
  int _selectedIndex = 0;
  User? user;
  String? _userName;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setuser(String index) {
    setState(() {
      _userName = index;
    });
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String id = FirebaseAuth.instance.currentUser!.uid;
    print(id);
    TextEditingController Searchcontroller = new TextEditingController();
    final List<String> Imagedata = <String>[
      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      'https://images.unsplash.com/photo-1546961329-78bef0414d7c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      'https://www.woolha.com/media/2020/03/eevee.png',
      'https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHVzZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
    ];

    final List<bool> connect = <bool>[true, true, false, false, false];

    var Header = Padding(
      padding: const EdgeInsets.only(
        top: 25.0,
        left: 25.0,
        right: 25.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Task for to day:",
              style: GoogleFonts.lato(
                fontSize: 37,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 20.0,
                ),
                SizedBox(width: 10.0),
                Text(
                  "5 available",
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            child: TextField(
              controller: Searchcontroller,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)))),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Last Connections",
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    TextButton(
                        child: Text(
                          'See all ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 180, 165, 165),
                              fontSize: 18.0),
                        ),
                        onPressed: () {
                          print(Imagedata.length);
                        })
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 200, // <-- you should put some value here
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: btnplus == false ? 5 : Imagedata.length,
                          itemBuilder: (context, index) {
                            return Column(children: [
                              index != 4 || btnplus == true
                                  ? Padding(
                                      padding: index != 0
                                          ? const EdgeInsets.all(10.0)
                                          : EdgeInsets.only(
                                              top: 10.0, right: 10.0),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            child: CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                    Imagedata[index])),
                                          ),
                                          Positioned(
                                            top: -35,
                                            right: -4,
                                            child: connect[index]
                                                ? Text(
                                                    ".",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 50.0,
                                                    ),
                                                  )
                                                : Text(''),
                                          ),
                                        ],
                                      ))
                                  : Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            Color.fromARGB(255, 235, 223, 230),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Color.fromARGB(
                                                255, 180, 165, 165),
                                            textStyle:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              this.btnplus = !this.btnplus;
                                            });

                                            print(btnplus);
                                          },
                                          child: const Text('+5'),
                                        ),
                                      ),
                                    ),
                            ]);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
    var container = Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Active projects",
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                TextButton(
                    child: Text(
                      'See all ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 180, 165, 165),
                          fontSize: 18.0),
                    ),
                    onPressed: () {
                      print(Imagedata.length);
                    })
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    15), //set border radius more than 50% of height and width to make circle
              ),
              child: ListTile(
                title: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Mousaab",
                          style: TextStyle(
                              color: Color.fromARGB(255, 180, 165, 165),
                              fontSize: 15.0)),
                      Text('4h',
                          style: TextStyle(
                              color: Color.fromARGB(255, 180, 165, 165),
                              fontSize: 15.0))
                    ],
                  ),
                ),
                subtitle: Container(
                  child: (Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Blog and social posts',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          )),
                      Row(
                        children: [
                          Icon(Icons.error_outline_sharp),
                          SizedBox(width: 8.0),
                          Text("Deadline is to day ",
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          SizedBox(height: 50.0),
                        ],
                      )
                    ],
                  )),
                ),
                isThreeLine: true,
              ),
            ),
          )
        ],
      ),
    );
    var bar_app = AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Color.fromARGB(255, 250, 230, 230),
        title: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      height: 50,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/profile',
                            arguments: {'id': auth.currentUser!.uid},
                          );
                        EasyLoading.show(status: 'loading...');

                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
                        ),
                      ),
                    ),
                    FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("Users")
                            .doc(id)
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            if (snapshot.hasError)
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            else
                              return Text(
                                'Hi, ${snapshot.data?['Full_Name']}',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 180, 165, 165),
                                    fontSize: 15.0),
                              ); 
                          }
                        }),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    size: 30.0,
                  ),
                  tooltip: 'Notification',
                  onPressed: null,
                ),
              ],
            ),
          ),
        ));
    var bottom_bar = SizedBox(
      height: 70,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Color.fromARGB(255, 192, 179, 179),
        selectedItemColor: Color.fromARGB(255, 82, 80, 80),
        onTap: _onItemTapped,
      ),
    );
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 250, 230, 230),
        bottomNavigationBar: bottom_bar,
        appBar: bar_app,
        body: SingleChildScrollView(
            child: Column(
          children: [Header, container],
        )));
  }
}
