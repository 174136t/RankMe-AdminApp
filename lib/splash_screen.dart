// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:rankme_admin/HomePages/home.dart';
import 'package:rankme_admin/OnBoarding_Screens/Welcome.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

Widget logo() {
  return Center(child: Image(image: AssetImage('assets/png_logo.png')));
}

Widget text() {
  return Center(
      child: RichText(
          text: TextSpan(
              text: 'R',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
        TextSpan(
            text: 'a',
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18)),
        TextSpan(
            text: 'n',
            style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        TextSpan(
            text: 'k ',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18)),
        TextSpan(
            text: 'M',
            style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        TextSpan(
            text: 'E',
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18)),
      ]))
      // Text(
      //   "Nexeyo Solutions\u2122 2020",
      //   style: TextStyle(
      //       fontSize: 20, color: Colors.black, fontStyle: FontStyle.normal),
      // ),
      );
}

class _SplashScreenState extends State<SplashScreen> {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseUser user;
  String uid;

  @override
  void initState() {
    super.initState();
    // getCurrentUser();
    // _getUserName();

    /// Initialize data, then navigator to Home screen.
    initData().then((value) {
      // print('val' + value.toString());
      // print(token);
      navigateToHomeScreen();
    });
  }

  // void getCurrentUser() async {
  //   FirebaseUser _user = await _firebaseAuth.currentUser();
  //   setState(() {
  //     user = _user;
  //     uid = _user.uid;
  //   });
  // }

  // Future<void> _getUserName() async {
  //   Firestore.instance
  //       .collection('users')
  //       .document((await FirebaseAuth.instance.currentUser()).uid)
  //       .get()
  //       .then((value) {
  //     // setState(() {
  //     print(value.data['userType']);

  //     // _userName = value.data['UserName'].toString();
  //     // });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
        child: Container(
      color: Colors.white,
      //  decoration: BoxDecoration(
      //         gradient: purpleGradient,

      //       ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // SizedBox(
          //   height: size.height * 0.2,
          // ),
          logo(),
          // SizedBox(
          //   height: size.height * 0.15,
          // ),
          // // text(),
        ],
      ),
    ));
  }

  /// NEW CODE.
  /// We can do long run task here.
  /// In this example, we just simply delay 3 seconds, nothing complicated.
  Future<bool> initData() async {
    bool done;
    await Future.delayed(Duration(seconds: 2));

    done = true;
    return done;
  }

  /// NEW CODE.
  /// Navigate to Home screen.
  void navigateToHomeScreen() {
    /// Push home screen and replace (close/exit) splash screen.
    // _read();
    print('in nav');

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }
}
