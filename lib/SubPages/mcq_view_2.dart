import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rankme_admin/HomePages/home.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MCQView2 extends StatefulWidget {
  final int pageNo;
  final List<dynamic> quesList;
  final List<dynamic> mapped;
  final int correct;
  final double tot;
  final Map ansList;
  final String mcqId;
  final String subId;

  const MCQView2(
      {Key key,
      this.pageNo,
      this.quesList,
      this.mapped,
      this.correct,
      this.tot,
      this.ansList,
      this.mcqId,
      this.subId})
      : super(key: key);

  @override
  _MCQView2State createState() => _MCQView2State();
}

class _MCQView2State extends State<MCQView2> {
  bool ansOneB;
  bool ansTwoB;
  bool ansThreeB;
  bool ansFourB;
  bool ansFiveB;
  int endTime;
  List userData = List();
  List addsData = List();
  String udId;
  String addPath;
  String userDisId;
  int qNumber;
  int pgNo;
  String qNo, ansNo;
  String selectedFinal;
  double total;
  int corPrev, quesAmt;
  Map<String, int> finQAndAList = {};
  int strtEndT, transTime;
  bool isClosed = true;
  int timeLeft;
  bool pauseloading = false;
  int t;
  bool time_started = true;
  // CountdownController controller = CountdownController();
  final _items = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.pink,
    Colors.red,
    Colors.amber,
    Colors.brown,
    Colors.yellow,
    Colors.blue,
  ];
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  final _boxHeight = 150.0;
  int current_index;
  bool loading = false;
  int groupVal = 0;
  final scrollDirection = Axis.horizontal;
  ScrollController _controller;
  AutoScrollController autocontroller;

  @override
  void initState() {
    // TODO: implement initState

    double initialOffset = 1;
    _controller = ScrollController(initialScrollOffset: initialOffset);

    super.initState();

    autocontroller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
    List map = widget.mapped;
    print(map);
    print("Map Ans Called");
    // print(widget.mapped[widget.pageNo]);

    pgNo = widget.pageNo;

    print(pgNo);
    print('mmmmmmmmmmmmmm');
    print(widget.quesList[pgNo]['text']);

    corPrev = widget.correct;
    finQAndAList = widget.ansList;
    // pgNo = widget.pageNo;
    current_index = pgNo;
    strtEndT = DateTime.now().millisecondsSinceEpoch + 1000 * 60;

    print("*************************************");
    // print(widget.time);

    setState(() {
      // t = widget.time;
      // endTime = widget.iniTime + t;
      _currentPageNotifier.value = widget.pageNo;
    });

    // print(widget.time);
    // getUserData();

    if (map[pgNo] != 0) {
      setState(() {
        _currentPageNotifier.value = 0;
        print((map[pgNo]).runtimeType);
        var myInt = int.parse(map[pgNo]);
        assert(myInt is int);
        groupVal = myInt;
      });
    }
  }

  mapAns() {}

  // getUserData() async {
  //   print("getUser called");
  //   // FirebaseUser user = await FirebaseAuth.instance.currentUser();

  //   // String phoneNo = user.phoneNumber;
  //   // String phoneFinal = phoneNo.replaceAll("+94", "");

  //   print(widget.mcqId);
  //   print(userDisId);

  //   var url = 'http://appadmin.rankme.lk/getUserData.php';
  //   final response = await http.post(Uri.encodeFull(url), headers: {
  //     "Accept": "application/json"
  //   }, body: {
  //     "phoneNo": phoneFinal,
  //   });
  //   if (response.body.toString() != "Error") {
  //     String jsonDataString = response.body;
  //     var data = jsonDecode(jsonDataString);

  //     // if (this.mounted) {
  //     setState(() {
  //       userData = json.decode(jsonDataString.toString());
  //       udId = userData[0]['id'];
  //       userDisId = userData[0]['district_id'];
  //     });
  //     getAdds(widget.mcqId, userDisId);
  //     //}
  //   }
  // }

  getAdds(ppr, dis) async {
    // FirebaseUser user = await FirebaseAuth.instance.currentUser();

    String mcqPpr = ppr;
    String district = dis;

    var url = 'http://appadmin.rankme.lk/getAdds.php';
    final response = await http.post(Uri.encodeFull(url), headers: {
      "Accept": "application/json"
    }, body: {
      "ppr": mcqPpr,
      "district": district,
    });
    if (response.body.toString() != "Error") {
      String jsonDataString = response.body;
      var data = jsonDecode(jsonDataString);

      if (this.mounted) {
        setState(() {
          addsData = json.decode(jsonDataString.toString());
          addPath = addsData[0]['img'];
        });

        // print("*************" + addPath);
      }
    }
  }

  validateAns(ans) {
    setState(() {
      isClosed = false;
    });

    transTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;

    var restTime = (endTime - transTime);

    if (ans != null) {
      int corAns = int.parse(widget.quesList[pgNo]['answer']);
      quesAmt = widget.quesList.length;
      assert(corAns is int);
      int selAns = int.parse(ans);
      assert(selAns is int);
      print(ans);
      print(corAns);
      if (selAns == corAns) {
        print("Question " + widget.quesList[pgNo]['no'] + " Correct");
        corPrev = corPrev + 1;
      } else {
        print("Question " + widget.quesList[pgNo]['no'] + " wrong");
      }
      setState(() {
        total = (corPrev / quesAmt) * 100;
        finQAndAList["$pgNo"] = selAns;
      });

      widget.mapped[pgNo] = ans;
      print(widget.quesList);
      print(pgNo + 1);
      print(corPrev);
      print(finQAndAList);
      print(widget.mcqId);
      print(widget.subId);
      print(restTime);
      // print(widget.iniTime);
      // print(widget.setEnd);
      print(widget.mapped);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MCQView2(
                    quesList: widget.quesList,
                    pageNo: pgNo + 1,
                    correct: corPrev,
                    ansList: finQAndAList,
                    mcqId: widget.mcqId,
                    subId: widget.subId,
                    // time: timeLeft,
                    // iniTime: widget.iniTime,
                    // setEnd: widget.setEnd,
                    mapped: widget.mapped,
                    // total_time: widget.total_time,
                  )));
      // pageController.animateToPage(
      //     current_index +1 ,
      //     duration: const Duration(milliseconds: 400),
      //     curve: Curves.easeInOut,
      //   );
    } else if (ans == null) {
      // widget.mapped[pgNo] = 0;
      setState(() {
        finQAndAList["$pgNo"] = 0;
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MCQView2(
                    quesList: widget.quesList,
                    pageNo: pgNo + 1,
                    correct: corPrev,
                    ansList: finQAndAList,
                    mcqId: widget.mcqId,
                    subId: widget.subId,
                    // time: timeLeft,
                    // iniTime: widget.iniTime,
                    // setEnd: widget.setEnd,
                    mapped: widget.mapped,
                    // total_time: widget.total_time,
                  )));
    }
  }

  validateAnsSpec(ans, pg) {
    setState(() {
      isClosed = false;
    });

    print("************AND***************" + ans);

    transTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;

    // var restTime = (endTime - transTime);

    if (ans != "0") {
      int corAns = int.parse(widget.quesList[pgNo]['answer']);
      quesAmt = widget.quesList.length;
      assert(corAns is int);
      int selAns = int.parse(ans);
      assert(selAns is int);
      print(ans);
      print(corAns);
      if (selAns == corAns) {
        print("Question " + widget.quesList[pgNo]['no'] + " Correct");
        corPrev = corPrev + 1;
      } else {
        print("Question " + widget.quesList[pgNo]['no'] + " wrong");
      }
      setState(() {
        total = (corPrev / quesAmt) * 100;
        finQAndAList["$pgNo"] = selAns;
      });

      widget.mapped[pgNo] = ans;

      setState(() {
        pgNo = pg;
      });
      List map = widget.mapped;
      setState(() {
        pgNo = pg;
        finQAndAList = finQAndAList;
        corPrev = corPrev;
        current_index = pg;
        strtEndT = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
        t = timeLeft;
        // endTime = widget.iniTime + timeLeft;
        _currentPageNotifier.value = pg;
      });

      if (map[pgNo] != 0) {
        setState(() {
          _currentPageNotifier.value = 0;

          //print((map[pgNo]).runtimeType);

          var myInt = int.parse(map[pgNo]);
          assert(myInt is int);
          groupVal = myInt;
        });
      }

      setState(() {
        selectedFinal = null;
      });
    } else {
      // widget.mapped[pgNo] = 0;
      setState(() {
        finQAndAList["$pgNo"] = 0;
      });

      setState(() {
        pgNo = pg;
        finQAndAList = finQAndAList;
        corPrev = corPrev;
        current_index = pg;
        strtEndT = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
        t = timeLeft;
        // endTime = widget.iniTime + timeLeft;
        _currentPageNotifier.value = pg;
      });

      List map = widget.mapped;

      if (map[pgNo] != 0) {
        setState(() {
          _currentPageNotifier.value = 0;
          print((map[pgNo]).runtimeType);
          var myInt = int.parse(map[pgNo]);
          assert(myInt is int);
          groupVal = myInt;
        });
      }

      setState(() {
        selectedFinal = null;
      });
    }
  }

  ValueNotifier<int> _networklHasErrorNotifier = ValueNotifier(0);
  ValueNotifier<int> _networklHasErrorNotifier2 = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    mapAns();

    bool _allow = false;
    Size size = MediaQuery.of(context).size;

    String _printDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Container(
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
                      height: size.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            offset: Offset(0.0, 5.0),
                            blurRadius: 6.0,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No time Limit.Enjoy!!!',style: TextStyle(fontWeight: FontWeight.bold),),
                          // Icon(
                          //   Icons.timer,
                          //   color: Colors.blue[600],
                          //   size: size.height * 0.03,
                          // ),
                          // SizedBox(
                          //   width: size.width * 0.03,
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      height: size.height * 0.57,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Html(
                                    data: widget.quesList[pgNo]['text'],
                                    style: {
                                      "body": Style(
                                        fontSize: FontSize.large,
                                        textAlign: TextAlign.justify,
                                      ),
                                    },
                                  ),
                                  widget.quesList[pgNo]['image'] != null
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (_) {
                                                  return DetailScreen(
                                                    img: widget.quesList[pgNo]
                                                        ['image'],
                                                  );
                                                }));
                                              },
                                              child: Container(
                                                decoration: new BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  color: Colors.transparent,
                                                ),
                                                width: size.width * 0.9,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        widget.quesList[pgNo]
                                                            ['image'],
                                                    fit: BoxFit.contain,
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                downloadProgress) =>
                                                            Center(
                                                      child: CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            GestureDetector(
                                                      child: Center(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(Icons.refresh),
                                                          // Text("Tap to refresh")
                                                        ],
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(width: 0, height: 0),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Container(
                              child: ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: widget.quesList[pgNo]['answer'] != '1'?Colors.white:Colors.green,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300],
                                            offset: Offset(0.0, 5.0),
                                            blurRadius: 6.0,
                                          )
                                        ],
                                      ),
                                      child: ListTile(
                                        title: Html(
                                          data: widget.quesList[pgNo]
                                              ['ans_one'],
                                          style: {
                                            "body": Style(
                                              color: widget.quesList[pgNo]['answer'] == '1'?Colors.white:Colors.black,
                                              fontSize: FontSize.medium,
                                              textAlign: TextAlign.justify,
                                            ),
                                          },
                                        ),
                                        leading: Radio(
                                          value: 1,
                                          groupValue: groupVal,
                                          onChanged: (int value) {
                                            setState(() {
                                              groupVal = value;

                                              setState(() {
                                                selectedFinal =
                                                    widget.quesList[pgNo]
                                                        ['ans_one_no'];
                                              });
                                            });
                                          },
                                        ),
                                        subtitle: widget.quesList[pgNo]
                                                    ['ans_one_img'] !=
                                                null
                                            ? ((!(widget.quesList[pgNo]
                                                        ['ans_one_img'])
                                                    .isEmpty)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                      child: Container(
                                                          decoration:
                                                              new BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            color: Colors.white,
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: widget
                                                                          .quesList[
                                                                      pgNo][
                                                                  'ans_one_img'],
                                                              fit: BoxFit
                                                                  .contain,
                                                              progressIndicatorBuilder:
                                                                  (context, url,
                                                                          downloadProgress) =>
                                                                      Center(
                                                                child: CircularProgressIndicator(
                                                                    value: downloadProgress
                                                                        .progress),
                                                              ),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  GestureDetector(
                                                                child: Center(
                                                                    child:
                                                                        Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(Icons
                                                                        .refresh),
                                                                    // Text("Tap to refresh")
                                                                  ],
                                                                )),
                                                              ),
                                                            ),
                                                          )),
                                                      onTap: () {
                                                        print(widget
                                                                .quesList[pgNo]
                                                            ['ans_one_img']);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (_) {
                                                          return DetailScreen(
                                                            img: widget.quesList[
                                                                    pgNo]
                                                                ['ans_one_img'],
                                                          );
                                                        }));
                                                      },
                                                    ),
                                                  )
                                                : Container(
                                                    width: 0, height: 0))
                                            : Container(width: 0, height: 0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: widget.quesList[pgNo]['answer'] != '2'?Colors.white:Colors.green,
                                        borderRadius: BorderRadius.circular(15),
                                        // border:
                                        //     Border.all(color: Colors.black),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300],
                                            offset: Offset(0.0, 5.0),
                                            blurRadius: 6.0,
                                          )
                                        ],
                                      ),
                                      child: ListTile(
                                        title: Html(
                                          data: widget.quesList[pgNo]
                                              ['ans_two'],
                                          style: {
                                            "body": Style(
                                              color: widget.quesList[pgNo]['answer'] == '2'?Colors.white:Colors.black,
                                              fontSize: FontSize.medium,
                                              textAlign: TextAlign.justify,
                                            ),
                                          },
                                        ),
                                        leading: Radio(
                                          value: 2,
                                          groupValue: groupVal,
                                          onChanged: (int value) {
                                            setState(() {
                                              groupVal = value;
                                              selectedFinal = widget
                                                  .quesList[pgNo]['ans_two_no'];
                                            });
                                          },
                                        ),
                                        subtitle: widget.quesList[pgNo]
                                                    ['ans_two_img'] !=
                                                null
                                            ? ((!(widget.quesList[pgNo]
                                                        ['ans_two_img'])
                                                    .isEmpty)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                      child: Container(
                                                        decoration:
                                                            new BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: widget
                                                                        .quesList[
                                                                    pgNo]
                                                                ['ans_two_img'],
                                                            fit: BoxFit.contain,
                                                            progressIndicatorBuilder:
                                                                (context, url,
                                                                        downloadProgress) =>
                                                                    Center(
                                                              child: CircularProgressIndicator(
                                                                  value: downloadProgress
                                                                      .progress),
                                                            ),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                GestureDetector(
                                                              child: Center(
                                                                  child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(Icons
                                                                      .refresh),
                                                                  // Text("Tap to refresh")
                                                                ],
                                                              )),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        print(widget
                                                                .quesList[pgNo]
                                                            ['ans_two_img']);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (_) {
                                                          return DetailScreen(
                                                            img: widget.quesList[
                                                                    pgNo]
                                                                ['ans_two_img'],
                                                          );
                                                        }));
                                                      },
                                                    ),
                                                  )
                                                : Container(
                                                    width: 0, height: 0))
                                            : Container(width: 0, height: 0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: widget.quesList[pgNo]['answer'] != '3'?Colors.white:Colors.green,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300],
                                            offset: Offset(0.0, 5.0),
                                            blurRadius: 6.0,
                                          )
                                        ],
                                      ),
                                      child: ListTile(
                                        title: Html(
                                          data: widget.quesList[pgNo]
                                              ['ans_three'],
                                          style: {
                                            "body": Style(
                                              color: widget.quesList[pgNo]['answer'] == '3'?Colors.white:Colors.black,
                                              fontSize: FontSize.medium,
                                              textAlign: TextAlign.justify,
                                            ),
                                          },
                                        ),
                                        leading: Radio(
                                          value: 3,
                                          groupValue: groupVal,
                                          onChanged: (int value) {
                                            setState(() {
                                              groupVal = value;
                                              selectedFinal =
                                                  widget.quesList[pgNo]
                                                      ['ans_three_no'];
                                            });
                                          },
                                        ),
                                        subtitle: widget.quesList[pgNo]
                                                    ['ans_three_img'] !=
                                                null
                                            ? ((!(widget.quesList[pgNo]
                                                        ['ans_three_img'])
                                                    .isEmpty)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                      child: Container(
                                                        decoration:
                                                            new BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: widget
                                                                        .quesList[
                                                                    pgNo][
                                                                'ans_three_img'],
                                                            fit: BoxFit.contain,
                                                            progressIndicatorBuilder:
                                                                (context, url,
                                                                        downloadProgress) =>
                                                                    Center(
                                                              child: CircularProgressIndicator(
                                                                  value: downloadProgress
                                                                      .progress),
                                                            ),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                GestureDetector(
                                                              child: Center(
                                                                  child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(Icons
                                                                      .refresh),
                                                                  // Text("Tap to refresh")
                                                                ],
                                                              )),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (_) {
                                                          return DetailScreen(
                                                            img: widget.quesList[
                                                                    pgNo][
                                                                'ans_three_img'],
                                                          );
                                                        }));
                                                      },
                                                    ),
                                                  )
                                                : Container(
                                                    width: 0, height: 0))
                                            : Container(width: 0, height: 0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: widget.quesList[pgNo]['answer'] != '4'?Colors.white:Colors.green,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300],
                                            offset: Offset(0.0, 5.0),
                                            blurRadius: 6.0,
                                          )
                                        ],
                                      ),
                                      child: ListTile(
                                        title: Html(
                                          data: widget.quesList[pgNo]
                                              ['ans_four'],
                                          style: {
                                            "body": Style(
                                              color: widget.quesList[pgNo]['answer'] == '4'?Colors.white:Colors.black,
                                              fontSize: FontSize.medium,
                                              textAlign: TextAlign.justify,
                                            ),
                                          },
                                        ),
                                        leading: Radio(
                                          value: 4,
                                          groupValue: groupVal,
                                          onChanged: (int value) {
                                            setState(() {
                                              groupVal = value;
                                              selectedFinal =
                                                  widget.quesList[pgNo]
                                                      ['ans_four_no'];
                                            });
                                          },
                                        ),
                                        subtitle: widget.quesList[pgNo]
                                                    ['ans_four_img'] !=
                                                null
                                            ? ((!(widget.quesList[pgNo]
                                                        ['ans_four_img'])
                                                    .isEmpty)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                      child: Container(
                                                        decoration:
                                                            new BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: widget
                                                                        .quesList[
                                                                    pgNo][
                                                                'ans_four_img'],
                                                            fit: BoxFit.contain,
                                                            progressIndicatorBuilder:
                                                                (context, url,
                                                                        downloadProgress) =>
                                                                    Center(
                                                              child: CircularProgressIndicator(
                                                                  value: downloadProgress
                                                                      .progress),
                                                            ),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                GestureDetector(
                                                              child: Center(
                                                                  child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(Icons
                                                                      .refresh),
                                                                  // Text("Tap to refresh")
                                                                ],
                                                              )),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (_) {
                                                          return DetailScreen(
                                                            img: widget.quesList[
                                                                    pgNo][
                                                                'ans_four_img'],
                                                          );
                                                        }));
                                                      },
                                                    ),
                                                  )
                                                : Container(
                                                    width: 0, height: 0))
                                            : Container(width: 0, height: 0),
                                      ),
                                    ),
                                  ),
                                  (!(widget.quesList[pgNo]['ans_five']).isEmpty)
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8, bottom: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: widget.quesList[pgNo]['answer'] != '5'?Colors.white:Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              // border: Border.all(
                                              //     color: Colors.black),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[300],
                                                  offset: Offset(0.0, 5.0),
                                                  blurRadius: 6.0,
                                                )
                                              ],
                                            ),
                                            child: ListTile(
                                              title: Html(
                                                data: widget.quesList[pgNo]
                                                    ['ans_five'],
                                                style: {
                                                  "body": Style(
                                                    color: widget.quesList[pgNo]['answer'] == '5'?Colors.white:Colors.black,
                                                    fontSize: FontSize.medium,
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                },
                                              ),
                                              leading: Radio(
                                                value: 5,
                                                groupValue: groupVal,
                                                onChanged: (int value) {
                                                  setState(() {
                                                    groupVal = value;
                                                    selectedFinal =
                                                        widget.quesList[pgNo]
                                                            ['ans_five_no'];
                                                  });
                                                },
                                              ),
                                              subtitle: widget.quesList[pgNo]
                                                          ['ans_five_img'] !=
                                                      null
                                                  ? ((!(widget.quesList[pgNo]
                                                              ['ans_five_img'])
                                                          .isEmpty)
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              GestureDetector(
                                                            child: Container(
                                                              decoration:
                                                                  new BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black),
                                                                color: Colors
                                                                    .transparent,
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: widget
                                                                              .quesList[
                                                                          pgNo][
                                                                      'ans_five_img'],
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  progressIndicatorBuilder:
                                                                      (context,
                                                                              url,
                                                                              downloadProgress) =>
                                                                          Center(
                                                                    child: CircularProgressIndicator(
                                                                        value: downloadProgress
                                                                            .progress),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      GestureDetector(
                                                                    child: Center(
                                                                        child: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Icon(Icons
                                                                            .refresh),
                                                                      ],
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (_) {
                                                                return DetailScreen(
                                                                  img: widget.quesList[
                                                                          pgNo][
                                                                      'ans_five_img'],
                                                                );
                                                              }));
                                                            },
                                                          ),
                                                        )
                                                      : Container(
                                                          width: 0, height: 0))
                                                  : Container(
                                                      width: 0, height: 0),
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          height: 1.0,
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (pgNo == 0) {
                              } else {
                                int no = pgNo - 1;
                                var dicvalue = pgNo <= 10 && pgNo >= 0
                                    ? 2
                                    : pgNo <= 20 && pgNo >= 10
                                        ? 4
                                        : pgNo <= 30 && pgNo >= 20
                                            ? 5
                                            : pgNo <= 40 && pgNo >= 30
                                                ? 5
                                                : 6;
                                setState(() {
                                  double doubleVar = pgNo.toDouble();
                                  double val = (size.width * 0.19) *
                                      (doubleVar - dicvalue);
                                  _controller.jumpTo(val);
                                });

                                await autocontroller.scrollToIndex(no,
                                    preferPosition: AutoScrollPosition.begin);
                                autocontroller.highlight(no);

                                validateAnsSpec(selectedFinal ?? "0", no);
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        pgNo == 0 ? Colors.grey : Colors.blue,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10))),
                                padding: EdgeInsets.all(12.0),
                                child: Icon(Icons.chevron_left,
                                    color: Colors.white)),
                          ),
                          Container(
                            height: size.height * 0.1,
                            width: size.width * 0.7,
                            padding: EdgeInsets.all(2.0),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              controller: _controller,
                              children: List.generate(widget.mapped.length,
                                  (itemIndex) {
                                return Container(
                                  //key: ValueKey(itemIndex),
                                  //controller: autocontroller,
                                  // index: itemIndex + 1,
                                  child: GestureDetector(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: pgNo == itemIndex
                                              ? Icon(
                                                  Icons.mode_edit,
                                                  color: Colors.redAccent,
                                                  size: size.height * 0.03,
                                                )
                                              : widget.mapped[itemIndex] == "0"
                                                  ? Container()
                                                  : Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green,
                                                      size: size.height * 0.03,
                                                    ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              width: size.width * 0.14,
                                              height: size.height * 0.05,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 2)),
                                              child: Center(
                                                  child: Text(
                                                (itemIndex + 1).toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ))),
                                        ),
                                      ],
                                    ),
                                    onTap: () async {
                                      validateAnsSpec(
                                          selectedFinal ?? "0", itemIndex);
                                    },
                                  ),
                                );
                              }),
                            ),
                          ),
                          (pgNo == (widget.quesList.length - 1))
                              ? GestureDetector(
                                  onTap: null,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      padding: EdgeInsets.all(12.0),
                                      child: Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.white,
                                      )))
                              : GestureDetector(
                                  onTap: () async {
                                    print(pgNo);
//pgNo<10 && pgNo >0 ? 1:pgNo<20 && pgNo >10 ?2:pgNo<30 && pgNo >20?3:pgNo<40 && pgNo >30 ?4:5
                                    setState(() {
                                      double doubleVar = pgNo.toDouble();

                                      var dicvalue = pgNo <= 10 && pgNo >= 0
                                          ? 1
                                          : pgNo <= 20 && pgNo >= 10
                                              ? 2
                                              : pgNo <= 30 && pgNo >= 20
                                                  ? 3
                                                  : pgNo <= 40 && pgNo >= 30
                                                      ? 4
                                                      : 5;

                                      print(dicvalue);

                                      double val = (size.width * 0.20) *
                                          (doubleVar - dicvalue);

                                      _controller.jumpTo(val);
                                    });
                                    validateAnsSpec(
                                        selectedFinal ?? "0", pgNo + 1);
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      padding: EdgeInsets.all(12.0),
                                      child: Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.white,
                                      )),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    addPath != null
                        ? (((addPath.isNotEmpty))
                            ? Container(
                                decoration: new BoxDecoration(
                                  // image: DecorationImage(
                                  //   image: NetworkImage(addPath),
                                  //   fit: BoxFit.fill,
                                  // ),
                                  color: Colors.blue,
                                ),
                                height: size.height * 0.15,
                                width: size.width * 0.95,
                              )
                            :  Container(
                                decoration: new BoxDecoration(
                                  // image: DecorationImage(
                                  //   image: NetworkImage(addPath),
                                  //   fit: BoxFit.fill,
                                  // ),
                                  color: Colors.blue,
                                ),
                                height: size.height * 0.15,
                                width: size.width * 0.95,
                              ))
                        :  Container(
                                decoration: new BoxDecoration(
                                  // image: DecorationImage(
                                  //   image: NetworkImage(addPath),
                                  //   fit: BoxFit.fill,
                                  // ),
                                  color: Colors.blue,
                                ),
                                height: size.height * 0.15,
                                width: size.width * 0.95,
                              ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomSheet: Container(
              height: size.height * 0.07,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Container(
                      height: size.height * 0.055,
                      width: size.width * 0.45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue[800]),
                      child: Center(
                        child: Text(
                          'Exit',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String img;

  DetailScreen({this.img});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
            child: Hero(
          tag: 'imageHero',
          child: PhotoView(
            imageProvider: NetworkImage(
              img,
            ),
          ),
        )
            //   ZoomableWidget(
            // maxScale: 5.0,
            // minScale: 0.5,
            // multiFingersPan: false,
            // autoCenter: true,
            // child: Image(image: AdvancedNetworkImage(img)),
            // // onZoomChanged: (double value) => print(value),
            // )),
            ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class Ans {
  String ind;
  int val;

  Ans(this.ind, this.val);

  @override
  String toString() {
    return '{ ${this.ind}, ${this.val} }';
  }
}
