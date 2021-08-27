// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:rankme_admin/Animation/fade_animation.dart';
// import 'package:rankme_admin/OnBoarding_Screens/login.dart';
// import 'package:rankme_admin/constant.dart';

// class SignupPage extends StatefulWidget {
//   @override
//   _SignupPageState createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//    String username;
//    String email;
//    String password;
//    String confirmPassword;
//    bool _success;
//    String _userEmail;

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final _formKey = GlobalKey<FormState>();

//   TextEditingController usernameController = TextEditingController();
//   TextEditingController lastnameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   bool _obscureText = true;
//   void _toggle() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       key: _scaffoldKey,
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Colors.white,
//       // appBar: AppBar(
//       //   elevation: 0,
//       //   brightness: Brightness.light,
//       //   backgroundColor: Colors.white,
//       //   leading: IconButton(
//       //     onPressed: () {
//       //       Navigator.pop(context);
//       //     },
//       //     icon: Icon(Icons.arrow_back_ios,
//       //       size: 20,
//       //       color: Colors.black,),

//       //   ),
//       // ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Image.asset(
//               "assets/splashback.png",
//               height: size.height,
//               width: size.width,
//               fit: BoxFit.fill,
//             ),
//             SingleChildScrollView(
//               child: Container(
//                 // padding: EdgeInsets.symmetric(horizontal: 40),
//                 // height: MediaQuery.of(context).size.height,
//                 width: double.infinity,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         // width: size.width*20,

//                         alignment: Alignment.topLeft,
//                         child: Container(
//                           // color: Colors.white,
//                           decoration: BoxDecoration(
//                               gradient: skyBlueGradient,
//                               borderRadius: BorderRadius.circular(10)),
//                           child: IconButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             icon: Icon(
//                               Icons.arrow_back_ios,
//                               size: 20,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: size.height * 0.02,
//                     ),
//                     Container(
//                       width: size.width * 0.90,
//                       //  height: ,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(30),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey[300],
//                             offset: Offset(0.0, 1.0), //(x,y)
//                             blurRadius: 6.0,
//                           ),
//                         ],
//                       ),
//                       child: SingleChildScrollView(
//                         child: FadeAnimation(
//                           1.2,
//                           SingleChildScrollView(
//                             child: Column(
//                               children: <Widget>[
//                                 Container(
//                                   height:
//                                       MediaQuery.of(context).size.height / 6,
//                                   decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                           image:
//                                               AssetImage("assets/login.png"))),
//                                 ),
//                                 Text(
//                                   "Sign up",
//                                   style: TextStyle(
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: size.height * 0.01,
//                                 ),
//                                 Text(
//                                   "Create an account, It's free ",
//                                   style: TextStyle(
//                                       fontSize: 15, color: Colors.grey[700]),
//                                 ),
//                                 SizedBox(
//                                   height: size.height * 0.03,
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 40),
//                                   child: Form(
//                                     key: _formKey,
//                                     child: Column(
//                                       children: <Widget>[
//                                         emailField(),
//                                         passwordField(),
//                                         confirmPasswordField()
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: size.height * 0.03,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     if (_formKey.currentState.validate() &&
//                                         passwordController.text ==
//                                             confirmPasswordController.text) {
//                                       _register();
//                                     }
//                                     // Navigator.push(
//                                     //     context,
//                                     //     MaterialPageRoute(
//                                     //         builder: (context) => HomeMainScreen()));
//                                   },
//                                   child: Container(
//                                     width: size.width * 0.80,
//                                     height: 60,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(50),
//                                         gradient: skyBlueGradient),
//                                     child: Center(
//                                       child: Text(
//                                         "Sign up",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 18),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: size.height * 0.02,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: <Widget>[
//                                     Text("Already have an account?"),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     LoginPage()));
//                                       },
//                                       child: Text(
//                                         " Login",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 18),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: size.height * 0.02,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _register() async {
//     print(emailController.text);
//       print(passwordController.text);
//     try {
//       print(emailController.text);
//       print(passwordController.text);
//       final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       ))
//           .user;
//       if (user != null) {
//         await Firestore.instance
//             .collection('users')
//             .document(user.uid)
//             .setData({
//           'email': emailController.text,
//           'password': passwordController.text,
//         });
//         showWarningDialog(context);
//         setState(() {
//           _success = true;
//           _userEmail = user.email;
//         });
//       }
//     } catch (ex) {
//       print(ex.toString());
//       showErrorDialog(context);
//       setState(() {
//         _success = true;
//       });
//     }
//   }

//   Widget emailField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Email',
//           style: TextStyle(
//               fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
//         ),
//         SizedBox(
//           height: 8,
//         ),
//         Container(
//             child: TextFormField(
//           style: TextStyle(color: Colors.black),
//           controller: emailController,
//           autofocus: false,
//           decoration: InputDecoration(
//             fillColor: Colors.white.withOpacity(0.2),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             errorStyle: TextStyle(color: Colors.red),
//             filled: true,
//           ),
//           keyboardType: TextInputType.emailAddress,
//           validator: (value) {
//             if (value.isEmpty ||
//                 !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
//                     .hasMatch(value)) {
//               return 'Please enter a valid email';
//             }
//           },
//           onSaved: (String value) {
//             this.email = value;
//           },
//         )),
//       ],
//     );
//   }

//   Widget passwordField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: 10,
//         ),
//         Text(
//           'Password',
//           style: TextStyle(
//               fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
//         ),
//         SizedBox(
//           height: 8,
//         ),
//         Container(
//             child: TextFormField(
//           style: TextStyle(color: Colors.black),
//           controller: passwordController,
//           autofocus: false,
//           obscureText: _obscureText,
//           decoration: InputDecoration(
//             fillColor: Colors.white.withOpacity(0.2),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             suffixIcon: GestureDetector(
//               onTap: _toggle,
//               child: Padding(
//                 padding: EdgeInsets.all(0.0),
//                 child: _obscureText == true
//                     ? Icon(
//                         Icons.visibility_off,
//                         color: Colors.white,
//                       )
//                     : Icon(Icons.visibility, color: Colors.white),
//               ),
//             ),
//             errorStyle: TextStyle(color: Colors.red),
//             filled: true,
//           ),
//           validator: (value) {
//             if (value.isEmpty || value.length < 6) {
//               return 'Minimum password length is 6';
//             }
//           },
//           onSaved: (String value) {
//             this.password = value;
//           },
//         )),
//       ],
//     );
//   }

//   Widget confirmPasswordField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: 10,
//         ),
//         Text(
//           'Confirm Password',
//           style: TextStyle(
//               fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
//         ),
//         SizedBox(
//           height: 8,
//         ),
//         Container(
//             child: TextFormField(
//           style: TextStyle(color: Colors.black),
//           controller: confirmPasswordController,
//           autofocus: false,
//           obscureText: _obscureText,
//           decoration: InputDecoration(
//             fillColor: Colors.white.withOpacity(0.2),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             suffixIcon: GestureDetector(
//               onTap: _toggle,
//               child: Padding(
//                 padding: EdgeInsets.all(0.0),
//                 child: _obscureText == true
//                     ? Icon(
//                         Icons.visibility_off,
//                         color: Colors.black,
//                       )
//                     : Icon(
//                         Icons.visibility,
//                         color: Colors.black,
//                       ),
//               ),
//             ),
//             errorStyle: TextStyle(color: Colors.red),
//             filled: true,
//           ),
//           validator: (value) {
//             if (value.isEmpty || passwordController.text != value) {
//               return 'Passwords doesn\'t match';
//             }
//           },
//           // onSaved: (String value) {
//           //   this.confirmPassword = value;
//           // },
//         )),
//       ],
//     );
//   }

//   showWarningDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => Container(
//         // width: SizeConfig.widthMultiplier * 90,
//         child: new AlertDialog(
//           // contentPadding: EdgeInsets.all(13),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(5))),
//           title: Center(
//             child: Text(
//               'Successfully Registered!',style: TextStyle(color: Colors.white),
//             ),
//           ),
//           actions: <Widget>[
//             Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [Colors.green, Colors.green, Colors.green]),
//                       borderRadius: BorderRadius.circular(5.0)),
//                   width: MediaQuery.of(context).size.width * 0.90,
//                   // height: SizeConfig.heightMultiplier*10,
//                   child: FlatButton(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                       // side: BorderSide(color: Colors.indigo)
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Ok',
//                             style: TextStyle(color: Colors.black, fontSize: 20),
//                           ),
//                         ],
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => LoginPage(),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   showErrorDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => Container(
//         // width: SizeConfig.widthMultiplier * 90,
//         child: new AlertDialog(
//           // contentPadding: EdgeInsets.all(13),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(5))),
//           title: Center(
//             child: Text(
//               'Something went wrong!',
//             ),
//           ),
//           actions: <Widget>[
//             Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [Colors.red, Colors.red]),
//                       borderRadius: BorderRadius.circular(5.0)),
//                   width: MediaQuery.of(context).size.width * 0.90,
//                   // height: SizeConfig.heightMultiplier*10,
//                   child: FlatButton(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                       // side: BorderSide(color: Colors.indigo)
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Ok',
//                             style: TextStyle(color: Colors.white, fontSize: 20),
//                           ),
//                         ],
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
