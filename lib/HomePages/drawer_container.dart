import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rankme_admin/OnBoarding_Screens/Welcome.dart';
import 'package:rankme_admin/OnBoarding_Screens/login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share/share.dart';

Widget leading() {
  return Icon(
    Icons.share_outlined,
    color: Colors.black,
  );
}

Widget notLeading() {
  return CircularProgressIndicator(
    backgroundColor: Colors.blue,
  );
}

bool isLoading = false;

Widget myDrawer(BuildContext context) {
  print("called");

  Size size = MediaQuery.of(context).size;

  Future<Null> urlFileShare() async {
    final RenderBox box = context.findRenderObject();
    if (Platform.isAndroid) {
      var url = 'https://i.ibb.co/kMJsqP6/share.jpg';
      // 'https://yt3.ggpht.com/ytc/AAUvwngFR_-7HkVuLI3Tq8Nna0jesm9_NHtM_LCUTmOq=s88-c-k-c0x00ffffff-no-rj';
      // 'https://ibb.co/zRzzws2';
      // 'https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg';
      var response = await get(Uri.parse(url));
      print(response.body);

      final documentDirectory = (await getExternalStorageDirectory()).path;
      File imgFile = new File('$documentDirectory/share.jpg');
      imgFile.writeAsBytesSync(response.bodyBytes);

      Share.shareFile(File('$documentDirectory/share.jpg'),
          subject: 'Hello, join with RankMe!',
          text: 'Hello, join with RankMe!\nhttps://www.facebook.com/app.rankme',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } else {
      Share.share('https://www.facebook.com/app.rankme',
          subject: 'Hello, join with RankMe!',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  return Container(
    child: GestureDetector(
      onTap: () {
        showModalBottomSheet<dynamic>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            useRootNavigator: true,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext bc) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: new Wrap(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Image(
                            image: AssetImage('assets/boy.png'),
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * 0.2),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: ListTile(
                        title: Text(
                          "Share App",
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios, color: Colors.black),
                        leading: Icon(
                          Icons.share_outlined,
                          color: Colors.black,
                        ),
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Center(
                                  child: CircularProgressIndicator(
                                      backgroundColor: Colors.blue,
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.amber[800])),
                                );
                              });
                          await urlFileShare();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: ListTile(
                        title: Text(
                          "Log out",
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios, color: Colors.black),
                        leading: Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        onTap: () async {
                          Alert(
                            context: context,
                            type: AlertType.error,
                            title: "Are you want to logout?",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () async {
                                  // _showWarningDialog(context);\
                                  Navigator.pop(context);
                                  await FirebaseAuth.instance.signOut();

                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => WelcomePage()),
                                      (Route<dynamic> route) => false);
                                },
                                width: 120,
                              ),
                              DialogButton(
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                                color: Colors.red,
                              )
                            ],
                          ).show();
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                  ],
                ),
              );
            });
      },
      child: Container(
          margin: EdgeInsets.only(left: 16, top: 5),
          width: size.width * 0.08,
          height: size.width * 0.08,
          //  padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(0.0, 5.0),
                  blurRadius: 6.0,
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Center(
            child: Icon(
              Icons.menu,
              color: Colors.cyan[800],
              size: size.width * 0.07,
            ),
          )),
    ),
  );
}
