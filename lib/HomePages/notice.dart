import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rankme_admin/Animation/fade_animation.dart';
import 'package:rankme_admin/HomePages/drawer_container.dart';
import 'package:rankme_admin/SubPages/notice_body.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  List noticeList = List();
  List userData = List();
  String fName;
  String lName;
  String profile;
  String stream;
  String district;
  String image;
  String address;
  String scl, id;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  // SharedPreferences prefs;
  bool loading = true;
  // initPreferences() async {
  //   prefs = await SharedPreferences.getInstance();
  // }

  //Getting dynamic subjects
  getNotices() async {
    print("GetSUb called");
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    // String phoneNo = user.phoneNumber;
    // String phoneFinal = phoneNo.replaceAll("+94", "");

    // var url = 'http://appadmin.rankme.lk/getNotices.php';
    var url = 'http://rankme.lk/appadmin/get_all_notices_new.php';
    http.Response response = await http.get(url);
    response = await http.post(Uri.encodeFull(url), headers: {
      "Accept": "application/json"
    }, 
    // body: {
    //   "phoneNo": '763529962',
    // }
    );

    if (response.body.toString() != "Error") {
      String jsonDataString = response.body;
      var data = jsonDecode(jsonDataString);

      if (this.mounted) {
        setState(() {
          noticeList = json.decode(jsonDataString.toString());
          print(noticeList);
          loading = false;
        });
      }
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // initPreferences();
    getNotices();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget slider() {
    Size size = MediaQuery.of(context).size;
    return Container(
      //width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: size.height * 0.25,
          aspectRatio: 16 / 9,
          viewportFraction: 0.9,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          //  onPageChanged: callbackFunction,
          scrollDirection: Axis.horizontal,
        ),
        items: <Widget>[
          SingleChildScrollView(
            child: Container(
                // width: size.width * 0.8,
                height: size.height * 0.2,
                margin: EdgeInsets.all(5),
                // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // border: Border.all(color: Colors.black),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],

                      offset: Offset(0.0, 5.0), //(x,y)

                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    'http://appadmin.rankme.lk/dashboard/img/image/notice/4.jpg',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: SpinKitWave(
                          color: Colors.amber[800],
                          size: size.height * 0.05,
                        ),
                      );
                    },
                  ),
                )),
          ),
          SingleChildScrollView(
            child: Container(
                height: size.height * 0.2,
                // width: size.width * 0.8,
                margin: EdgeInsets.all(5),
                // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  // border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],

                      offset: Offset(0.0, 5.0), //(x,y)

                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    'http://appadmin.rankme.lk/dashboard/img/image/notice/5.jpg',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: SpinKitWave(
                          color: Colors.amber[800],
                          size: size.height * 0.05,
                        ),
                      );
                    },
                  ),
                )),
          ),
          SingleChildScrollView(
            child: Container(
                // width: size.width * 0.8,
                height: size.height * 0.2,
                margin: EdgeInsets.all(5),
                // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  // border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],

                      offset: Offset(0.0, 5.0), //(x,y)

                      blurRadius: 6.0,
                    ),
                  ],
                  // image: DecorationImage(
                  //   image: NetworkImage(
                  //       'http://appadmin.rankme.lk/dashboard/img/image/notice/6.jpg'),
                  //   fit: BoxFit.fill,
                  // )
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    'http://appadmin.rankme.lk/dashboard/img/image/notice/6.jpg',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: SpinKitWave(
                          color: Colors.amber[800],
                          size: size.height * 0.05,
                          // value: loadingProgress.expectedTotalBytes != null
                          //     ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                          //     : null,
                        ),
                      );
                    },
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() {
    // DateTime now = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _allow = false;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _drawerKey,
        body: loading
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
                                    'Notices',
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
                            color: Colors.amber[800],
                            size: 50.0,
                          )),
                        ),
                        Container(
                          // color: Colors.indigo[100],
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
            : Container(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/Guest_Screen.png",
                      height: size.height,
                      width: size.width,
                      fit: BoxFit.fill,
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: size.height * 0.01),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              myDrawer(context),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Notices',
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
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[300],
                                        offset: Offset(0.0, 5.0),
                                        blurRadius: 6.0,
                                      )
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: Center(
                                  child: Icon(
                                    Icons.notifications_active,
                                    color: Colors.amber[800],
                                    size: size.width * 0.07,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        FadeAnimation(1.2, slider()),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        noticeList.length == 0
                            ? Container(
                                child: Center(
                                  child: Text("No Notices"),
                                ),
                              )
                            : Expanded(
                                child: FadeAnimation(
                                  1.2,
                                  Container(
                                      // height: size.height,
                                      color: Colors.white,
                                      child: ListView(
                                        children: noticeList.reversed
                                            .map((list) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    NoticeBody(
                                                                      title: list[
                                                                          'title'],
                                                                      image: list[
                                                                          'image'],
                                                                      text: list[
                                                                          'text'],
                                                                    ))),
                                                    child: Container(
                                                      color: Colors.white,
                                                      width: size.width * 0.85,
                                                      child: SizedBox(
                                                        height:
                                                            size.height * 0.12,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: list['image'] !=
                                                                      null
                                                                  ? Container(
                                                                      decoration:
                                                                          new BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(15)),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              list['image'],
                                                                          imageBuilder: (context, imageProvider1) =>
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              image: DecorationImage(
                                                                                image: imageProvider1,
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                                              Center(
                                                                            child:
                                                                                CircularProgressIndicator(value: downloadProgress.progress),
                                                                          ),
                                                                          errorWidget: (context, url, error) => Center(
                                                                              child: Image.asset(
                                                                            "assets/boy.png",
                                                                            filterQuality:
                                                                                FilterQuality.high,
                                                                            fit:
                                                                                BoxFit.fitHeight,
                                                                          )),
                                                                        ),
                                                                      ),
                                                                      height: double
                                                                          .infinity,
                                                                      width: size
                                                                              .width *
                                                                          0.4,
                                                                    )
                                                                  : Container(
                                                                      decoration:
                                                                          new BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                        color: Colors
                                                                            .amber[800],
                                                                      ),
                                                                      height: double
                                                                          .infinity,
                                                                      width:
                                                                          size.width *
                                                                              6,
                                                                    ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.05,
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    new Text(
                                                                      list[
                                                                          'title'],
                                                                      // 'fedsaf gagg ga g rgrg gggg ddef ninnniu uiu uhb ububu fdd',
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize: size.width *
                                                                              0.04,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Colors.black),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          3,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      )),
                                ),
                              ),
                      ],
                    ),
                  ],
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
