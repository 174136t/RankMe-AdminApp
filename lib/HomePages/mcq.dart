import 'dart:convert';
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rankme_admin/Animation/fade_animation.dart';
import 'package:rankme_admin/HomePages/drawer_container.dart';
import 'package:rankme_admin/SubPages/mcq_sub_list.dart';

class McqPage extends StatefulWidget {
  const McqPage({Key key}) : super(key: key);

  @override
  _McqPageState createState() => _McqPageState();
}

class _McqPageState extends State<McqPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List subList = [];
  bool loading = true;
  // SharedPreferences prefs;

  // initPreferences() async {
  //   prefs = await SharedPreferences.getInstance();
  // }
  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new Theme(
        data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.grey[100],
            backgroundColor: Colors.white),
        child: AlertDialog(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.only(
                  topRight: Radius.circular(35),
                  bottomLeft: Radius.circular(35))),
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit from this App?'),
          actions: <Widget>[
            new FlatButton(
              color: Colors.red[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                // side: BorderSide(color: Colors.indigo)
              ),
              onPressed: () => exit(0),
              child: new Text('Yes'),
            ),
            // ignore: deprecated_member_use
            new FlatButton(
              color: Colors.red[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                //side: BorderSide(color: Colors.indigo)
              ),
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
          ],
        ),
      ),
    );
  }

//Getting Stream Data
  Future geStreamData() async {
    var url = 'http://appadmin.rankme.lk/getStream.php';
    http.Response response = await http.get(url);
    String jsonDataString = response.body;
    var data = jsonDecode(jsonDataString);
    print(jsonDataString.toString());
    // setState(() {
    //   streamList = json.decode(jsonDataString);
    // });
    if (this.mounted) {
      setState(() {
        subList = json.decode(jsonDataString.toString());
        print(subList);
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // initPreferences();
    super.initState();
    geStreamData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _drawerKey,
        body: subList.length == 0 || loading
            ? Container(
                color: Colors.white,
                height: size.height * 1,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/Guest_Screen.png",
                      height: size.height,
                      width: size.width,
                      fit: BoxFit.fill,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: size.height * 0.01),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              loading
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          right: 16, top: 5, bottom: 2),
                                      width: size.width * 0.08,
                                      height: size.width * 0.08,
                                    )
                                  : myDrawer(context),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'MCQ Papers',
                                    style: TextStyle(
                                        fontSize: size.width * 0.06,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: 16, top: 5, bottom: 2),
                                width: size.width * 0.08,
                                height: size.width * 0.08,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.4,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: SpinKitChasingDots(
                            color: Colors.blue[700],
                            size: 50.0,
                          )),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text("Loading",
                                    style: GoogleFonts.montserrat(
                                        fontSize: size.width * 0.06,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            : Scaffold(
                body: Container(
                  height: size.height * 1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/Guest_Screen.png",
                        height: size.height,
                        width: size.width,
                        fit: BoxFit.fill,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: size.height * 0.01),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  myDrawer(context),
                                  Center(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        'MCQ Papers',
                                        style: TextStyle(
                                            fontSize: size.width * 0.06,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 16, top: 5, bottom: 2),
                                    width: size.width * 0.08,
                                    height: size.width * 0.08,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            FadeAnimation(
                              1.2,
                              Center(
                                  child: new Image(
                                      image: AssetImage('assets/login1.png'),
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15)),
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            FadeAnimation(
                              1.4,
                              Column(
                                children: subList
                                    .map((list) => Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              // String subjectId = list['id'];
                                              // String user =
                                              //     list['user_data_id'];
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MCQSubList(
                                                            sub: list['id'],
                                                          
                                                          )));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.blue,
                                                      width: 2),
                                                  color: Colors.blue[100]),
                                              height: size.height * 0.07,
                                              width: size.width * 0.9,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .library_books_outlined,
                                                    size: size.width * 0.06,
                                                    color: Colors.blue[700],
                                                  ),
                                                  Container(
                                                    width: size.width * 0.7,
                                                    child: Text(
                                                      list['stream'],
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.width * 0.04,
                                                          color:
                                                              Colors.blue[700],
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: size.width * 0.06,
                                                    color: Colors.blue[700],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        backgroundColor: Colors.white,
      ),
//      onWillPop: () {
//        return Future.value(_allow); // if true allow back else block it
//      },
    );
  }
}
