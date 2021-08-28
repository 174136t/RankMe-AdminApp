import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:rankme_admin/HomePages/home.dart';
import 'package:rankme_admin/SubPages/mcq_view_2.dart';

class MCQViewQues extends StatefulWidget {
  final String mcqPprId;
  final String subId;
  const MCQViewQues({Key key, this.mcqPprId, this.subId}) : super(key: key);

  @override
  _MCQViewQuesState createState() => _MCQViewQuesState();
}

class _MCQViewQuesState extends State<MCQViewQues> {
  List mcqQuestions = List();
  List mcqQueAns = List();
  List mapList = List();
  List addsData = List();
  final Map<String, int> qAndAList = {};

  String mcqQuesId;
  String ansOne, ansTwo, ansThree, ansFour, correctAns;
  String addPath;
  int groupVal = 0;
  String selectedNoOne,
      selectedNoTwo,
      selectedNoThree,
      selectedNoFour,
      selectedNoFive,
      selectedFinal;
  int pageNo;
  int endTime;
  int transTime;
  int qNumber;
  int quesAmt;
  int correct = 0;
  int wrong = 0;
  double total = 0.0;
  int strtEndT;
  bool isClosed = true;
  //Getting questions
  getMcqQues(mcqPprId) async {
    print("Get quuuus called");
    // FirebaseUser user = await FirebaseAuth.instance.currentUser();

    String pprId = mcqPprId;

    var url = 'http://appadmin.rankme.lk/getMcqPprs.php';
    // var url = 'http://rankme.lk/appadmin/get_new_mcq_answer.php';
    final response = await http.post(Uri.encodeFull(url), headers: {
      "Accept": "application/json"
    }, body: {
      "mcqPprId": pprId,
    });
    print(response.body);
    if (response.body.toString() != "Error") {
      String jsonDataString = response.body;
      var data = jsonDecode(jsonDataString);

      if (this.mounted) {
        setState(() {
          mcqQuestions = json.decode(jsonDataString.toString());
          print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
          print(mcqQuestions[0]);
          print(mcqQuestions.length);
          print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
//          print(mcqDetails);
          mcqQuesId = mcqQuestions[0]['id'];
          correctAns = mcqQuestions[0]['answer'];
          for (var i = 0; i < mcqQuestions.length; i++) {
            mapList.add("0");
          }
          print(mapList.toString());
        });
      }
      // getUserData();
      // return new Row(children: list);

    }
  }

  getAdds(ppr, dis) async {
    print("Get Adds Called");
    print(ppr + "***********************" + dis);

    // FirebaseUser user = await FirebaseAuth.instance.currentUser();

    String mcqPpr = ppr;
    String district = dis;

    print(mcqPpr);
    print("DIS*********************" + mcqPpr);
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

      // if (this.mounted) {
      setState(() {
        addsData = json.decode(jsonDataString.toString());
        addPath = addsData[0]['img'];
        // print(addPath);
      });
      //}
    }
  }

  validateAns(ans) {
    setState(() {
      isClosed = false;
    });
    // transTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;

    // var restTime = (endTime - transTime);
    // print(transTime);
    // print(strtEndT);
    // print(restTime);
    // print((endTime * 1000* 60) - transTime);

    if (ans != null) {
      int corAns = int.parse(mcqQuestions[0]['answer']);
      quesAmt = mcqQuestions.length;
      assert(corAns is int);
      int selAns = int.parse(ans);
      assert(selAns is int);
      print(ans);
      print(corAns);
      if (selAns == corAns) {
        print("Question " + mcqQuestions[0]['no'] + " Correct");
        correct = correct + 1;
      } else {
        print("Question " + mcqQuestions[0]['no'] + " wrong");
        wrong = wrong + 1;
      }
      setState(() {
        total = (correct / quesAmt) * 100;
        qAndAList["$pageNo"] = selAns;
      });

      mapList[0] = ans;
      print(mapList);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MCQView2(
                    quesList: mcqQuestions,
                    pageNo: pageNo,
                    correct: correct,
                    tot: total,
                    ansList: qAndAList,
                    mcqId: widget.mcqPprId,
                    subId: widget.subId,
                    // time: timeLeft,
                    // iniTime: strtEndT,
                    // setEnd: pprTime,
                    mapped: mapList,
                    // total_time: widget.total_time,
                  )));
      // pageController.animateToPage(
      //     current_index +1 ,
      //     duration: const Duration(milliseconds: 400),
      //     curve: Curves.easeInOut,
      //   );
    } else if (ans == null) {
      setState(() {
        qAndAList["$pageNo"] = 0;
      });

      // mapList[0] = 0;

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MCQView2(
                    quesList: mcqQuestions,
                    pageNo: pageNo,
                    correct: correct,
                    tot: total,
                    ansList: qAndAList,
                    mcqId: widget.mcqPprId,
                    subId: widget.subId,
                    // time: timeLeft,
                    // iniTime: strtEndT,
                    // setEnd: pprTime,
                    mapped: mapList,
                    // total_time: widget.total_time,
                  )));
      // pageController.animateToPage(
      //       current_index +1 ,
      //       duration: const Duration(milliseconds: 400),
      //       curve: Curves.easeInOut,
      //     );
    }
  }

  @override
  void initState() {
    super.initState();
    getMcqQues(widget.mcqPprId);
    pageNo = 0;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _allow = false;
    return WillPopScope(
      onWillPop: () async => false,
      child:
          // loading
          //     ? Scaffold(
          //         body: Container(
          //           color: Colors.blueAccent,
          //           height: size.height * 1,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Container(
          //                 child: Center(
          //                   child: JumpingDotsProgressIndicator(
          //                     fontSize: size.height * 0.1,
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //               ),
          //               Container(
          //                 // color: Colors.white,
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     Center(
          //                       child: Text("Loading",
          //                           style: GoogleFonts.montserrat(
          //                               fontSize: size.width * 0.06,
          //                               fontWeight: FontWeight.w600,
          //                               color: Colors.white)),
          //                     ),
          //                   ],
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //       )
          //     :
          SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   title: Text("Quiz Starting"),
          // ),
          body: mcqQuestions.length == 0
              ? Container(
                  color: Colors.indigo[100],
                  height: size.height * 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Center(
                          child: SpinKitThreeBounce(
                            color: Colors.blueAccent,
                            size: size.height * 0.1,
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.white,
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
                )
              : Container(
                  child: Stack(
                    children: [
                      Image.asset(
                        "images/Guest_Screen.png",
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
                                Icon(
                                  Icons.timer,
                                  color: Colors.blue[600],
                                  size: size.height * 0.03,
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                // Countdown(
                                //   controller: controller,
                                //   seconds: endTime,
                                //   build: (_, double time) {
                                //     final now =
                                //         Duration(seconds: time.toInt());
                                //     // print("${_printDuration(now)}");
                                //     timeLeft = time.toInt();

                                //     var t = time / 60;
                                //     return Text(
                                //       _printDuration(now),
                                //       style: GoogleFonts.montserrat(
                                //           fontSize: size.height * 0.03,
                                //           fontWeight: FontWeight.w600,
                                //           color: Colors.red),
                                //     );
                                //   },
                                //   interval: Duration(milliseconds: 100),
                                //   onFinished: () {
                                //     print('Timer is done!');
                                //     validateAnsFinalTime(selectedFinal);
                                //   },
                                // ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: size.height * 0.02,
                          // ),
                          Container(
                            height: size.height * 0.57,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Html(
                                          data: mcqQuestions[0]['text'],
                                          style: {
                                            "body": Style(
                                              fontSize: FontSize.large,
                                              textAlign: TextAlign.justify,
                                              // fontSize: FontSize(18.0),
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          },
                                          // defaultTextStyle: TextStyle(
                                          //   // height: 1.9,
                                          //   fontSize: size.height * 0.02,
                                          //   color: Colors.black,
                                          //   decoration:
                                          //       TextDecoration.none,
                                          // ),
                                        ),
                                        // Text(
                                        //   mcqQuestions[0]['text'],
                                        //   style: TextStyle(fontWeight: FontWeight.w800),
                                        // ),
                                        mcqQuestions[0]['image'] != null
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: new BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          "http://appadmin.rankme.lk/dashboard/dist/" +
                                                              mcqQuestions[0]
                                                                  ['image']),
                                                      fit: BoxFit.contain,
                                                    ),
                                                    color: Colors.transparent,
                                                  ),
                                                  // height:
                                                  //     size.height * 0.2,
                                                  width: size.width * 0.9,
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
                                              color: Colors.white,
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
                                                data: mcqQuestions[0]
                                                    ['ans_one'],
                                                style: {
                                                  "body": Style(
                                                    fontSize: FontSize.medium,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    // fontSize: FontSize(18.0),
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                },
                                                // defaultTextStyle:
                                                //     TextStyle(
                                                //   fontSize:
                                                //       size.height * 0.018,
                                                //   color: Colors.black,
                                                //   decoration:
                                                //       TextDecoration.none,
                                                // ),
                                              ),
                                              leading: Radio(
                                                value: 1,
                                                groupValue: groupVal,
                                                onChanged: (int value) {
                                                  setState(() {
                                                    groupVal = value;
                                                    selectedFinal =
                                                        mcqQuestions[0]
                                                            ['ans_one_no'];
                                                  });
                                                },
                                              ),
                                              subtitle: mcqQuestions[0]
                                                          ['ans_one_img'] !=
                                                      null
                                                  ? ((!(mcqQuestions[0]
                                                              ['ans_one_img'])
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
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      "http://appadmin.rankme.lk/dashboard/dist/" +
                                                                          mcqQuestions[0]
                                                                              [
                                                                              'ans_one_img']),
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              // height: size
                                                              //         .height *
                                                              //     0.15,
                                                              // width: size.width * 0.1,
                                                            ),
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (_) {
                                                                return DetailScreen(
                                                                  img: mcqQuestions[
                                                                          0][
                                                                      'ans_one_img'],
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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8, bottom: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
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
                                                data: mcqQuestions[0]
                                                    ['ans_two'],
                                                style: {
                                                  "body": Style(
                                                    fontSize: FontSize.medium,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    // fontSize: FontSize(18.0),
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                },
                                                // defaultTextStyle:
                                                //     TextStyle(
                                                //   fontSize:
                                                //       size.height * 0.018,
                                                //   color: Colors.black,
                                                //   decoration:
                                                //       TextDecoration.none,
                                                // ),
                                              ),
                                              leading: Radio(
                                                value: 2,
                                                groupValue: groupVal,
                                                onChanged: (int value) {
                                                  setState(() {
                                                    groupVal = value;
                                                    selectedFinal =
                                                        mcqQuestions[0]
                                                            ['ans_two_no'];
                                                  });
                                                },
                                              ),
                                              subtitle: mcqQuestions[0]
                                                          ['ans_two_img'] !=
                                                      null
                                                  ? ((!(mcqQuestions[0]
                                                              ['ans_two_img'])
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
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      "http://appadmin.rankme.lk/dashboard/dist/" +
                                                                          mcqQuestions[0]
                                                                              [
                                                                              'ans_two_img']),
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                                color: Colors
                                                                    .transparent,
                                                              ),

                                                              // height: size
                                                              //         .height *
                                                              //     0.15,
                                                              // width: size.width * 0.5,
                                                            ),
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (_) {
                                                                return DetailScreen(
                                                                  img: mcqQuestions[
                                                                          0][
                                                                      'ans_two_img'],
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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8, bottom: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
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
                                                data: mcqQuestions[0]
                                                    ['ans_three'],
                                                style: {
                                                  "body": Style(
                                                    fontSize: FontSize.medium,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    // fontSize: FontSize(18.0),
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                },
                                                // defaultTextStyle:
                                                //     TextStyle(
                                                //   fontSize:
                                                //       size.height * 0.018,
                                                //   color: Colors.black,
                                                //   decoration:
                                                //       TextDecoration.none,
                                                // ),
                                              ),
                                              leading: Radio(
                                                value: 3,
                                                groupValue: groupVal,
                                                onChanged: (int value) {
                                                  setState(() {
                                                    groupVal = value;
                                                    selectedFinal =
                                                        mcqQuestions[0]
                                                            ['ans_three_no'];
                                                  });
                                                },
                                              ),
                                              subtitle: mcqQuestions[0]
                                                          ['ans_three_img'] !=
                                                      null
                                                  ? ((!(mcqQuestions[0]
                                                              ['ans_three_img'])
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
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      "http://appadmin.rankme.lk/dashboard/dist/" +
                                                                          mcqQuestions[0]
                                                                              [
                                                                              'ans_three_img']),
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                                color: Colors
                                                                    .transparent,
                                                              ),
                                                              // height: size
                                                              //         .height *
                                                              //     0.15,
                                                              // width: size.width * 0.1,
                                                            ),
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (_) {
                                                                return DetailScreen(
                                                                  img: mcqQuestions[
                                                                          0][
                                                                      'ans_three_img'],
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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8, bottom: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
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
                                                data: mcqQuestions[0]
                                                    ['ans_four'],
                                                // defaultTextStyle:
                                                //     TextStyle(
                                                //   fontSize:
                                                //       size.height * 0.018,
                                                //   color: Colors.black,
                                                //   decoration:
                                                //       TextDecoration.none,
                                                // ),
                                                style: {
                                                  "body": Style(
                                                    fontSize: FontSize.medium,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    // fontSize: FontSize(18.0),
                                                    // fontWeight: FontWeight.bold,
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
                                                        mcqQuestions[0]
                                                            ['ans_four_no'];
                                                  });
                                                },
                                              ),
                                              subtitle: mcqQuestions[0]
                                                          ['ans_four_img'] !=
                                                      null
                                                  ? ((!(mcqQuestions[0]
                                                              ['ans_four_img'])
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
                                                                // border: Border.all(
                                                                //     color: Colors
                                                                //         .black),
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      "http://appadmin.rankme.lk/dashboard/dist/" +
                                                                          mcqQuestions[0]
                                                                              [
                                                                              'ans_four_img']),
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                                color: Colors
                                                                    .transparent,
                                                              ),
                                                              // height: size
                                                              //         .height *
                                                              //     0.15,
                                                              // width: size.width * 0.1,
                                                            ),
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (_) {
                                                                return DetailScreen(
                                                                  img: mcqQuestions[
                                                                          0][
                                                                      'ans_four_img'],
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
                                        ),
                                        (!(mcqQuestions[0]['ans_five']).isEmpty)
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    right: 8,
                                                    bottom: 8),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    // border: Border.all(
                                                    //     color: Colors.black),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey[300],
                                                        offset:
                                                            Offset(0.0, 5.0),
                                                        blurRadius: 6.0,
                                                      )
                                                    ],
                                                  ),
                                                  child: ListTile(
                                                    title: Html(
                                                      data: mcqQuestions[0]
                                                          ['ans_five'],
                                                      // defaultTextStyle:
                                                      //     TextStyle(
                                                      //   fontSize:
                                                      //       size.height *
                                                      //           0.018,
                                                      //   color:
                                                      //       Colors.black,
                                                      //   decoration:
                                                      //       TextDecoration
                                                      //           .none,
                                                      // ),
                                                      style: {
                                                        "body": Style(
                                                          fontSize:
                                                              FontSize.medium,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          // fontSize: FontSize(18.0),
                                                          // fontWeight: FontWeight.bold,
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
                                                              mcqQuestions[0][
                                                                  'ans_five_no'];
                                                        });
                                                      },
                                                    ),
                                                    subtitle: mcqQuestions[0][
                                                                'ans_five_img'] !=
                                                            null
                                                        ? ((!(mcqQuestions[0][
                                                                    'ans_five_img'])
                                                                .isEmpty)
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    GestureDetector(
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        new BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.black),
                                                                      image:
                                                                          DecorationImage(
                                                                        image: NetworkImage("http://appadmin.rankme.lk/dashboard/dist/" +
                                                                            mcqQuestions[0]['ans_five_img']),
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                      color: Colors
                                                                          .transparent,
                                                                    ),
                                                                    // height:
                                                                    //     size.height * 0.15,
                                                                    // width:
                                                                    //     size.width * 0.1,
                                                                  ),
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(builder:
                                                                            (_) {
                                                                      return DetailScreen(
                                                                        img: mcqQuestions[0]
                                                                            [
                                                                            'ans_five_img'],
                                                                      );
                                                                    }));
                                                                  },
                                                                ),
                                                              )
                                                            : Container(
                                                                width: 0,
                                                                height: 0))
                                                        : Container(
                                                            width: 0,
                                                            height: 0),
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
                            //  margin: EdgeInsets.all(20.0),
                            height: size.height * 0.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                GestureDetector(
                                  onTap: null,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
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
                                  // child: PageView.builder(
                                  //   itemCount: mcqQuestions.length,
                                  //   controller: pageController,
                                  //   onPageChanged: _onPageViewChange,
                                  //   itemBuilder: (BuildContext context, int itemIndex,) {
                                  //     return GestureDetector(
                                  //       child: Container(
                                  //           width: 60.0,
                                  //           child: Text((itemIndex+1).toString())),
                                  //       onTap: (){
                                  //         print(Text((itemIndex+1).toString()));
                                  //
                                  //
                                  //         if(pageNo < itemIndex)
                                  //         {
                                  //
                                  //           validateAnsSpec(selectedFinal, itemIndex);
                                  //
                                  //
                                  //         }
                                  //
                                  //         // validateAns(selectedFinal);
                                  //       },
                                  //     );
                                  //   },
                                  // ),

                                  child: Center(
                                    child: ListView(
                                      // controller: pageController,
                                      // This next line does the trick.
                                      scrollDirection: Axis.horizontal,

                                      children: List.generate(mapList.length,
                                          (itemIndex) {
                                        return GestureDetector(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: mapList[itemIndex] == "0"
                                                    ? Container()
                                                    : pageNo == itemIndex
                                                        ? Icon(
                                                            Icons.mode_edit,
                                                            color: Colors
                                                                .redAccent,
                                                            size: size.height *
                                                                0.03,
                                                          )
                                                        : Icon(
                                                            Icons.check_circle,
                                                            color: Colors.green,
                                                            size: size.height *
                                                                0.03,
                                                          ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    width: size.width * 0.14,
                                                    height: size.height * 0.05,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        border: Border.all(
                                                            color: Colors.black,
                                                            width: 2)),
                                                    child: Center(
                                                        child: Text(
                                                      (itemIndex + 1)
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ))),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            print(Text(
                                                (itemIndex + 1).toString()));

                                            // if (pageNo < itemIndex) {
                                            //   validateAnsSpec(
                                            //       selectedFinal,
                                            //       itemIndex);
                                            // }

                                            // validateAns(selectedFinal);
                                          },
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    validateAns(selectedFinal);

                                    // print(qAndAList.length);
                                    // Navigator.push(context, MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         AnsBody(
                                    //           quesList: mcqQuestions,
                                    //           pageNo: pageNo + 1,
                                    //           correct: correct,
                                    //           tot: total,
                                    //           ansList: qAndAList,
                                    //           mcqId: mcqPprId,
                                    //           subId : widget.subId,
                                    //           time : 300,
                                    //           iniTime: strtEndT,
                                    //           setEnd : widget.mcqTime,
                                    //
                                    //         )
                                    // ));
                                    // pageController.animateToPage(
                                    //   current_index +1 ,
                                    //   duration: const Duration(milliseconds: 400),
                                    //   curve: Curves.easeInOut,
                                    // );

                                    setState(() {
                                      // pgNo = current_index + 1;
                                    });
                                    /* Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                        AnsBody(
                          quesList: widget.quesList,
                          pageNo: current_index + 1,
                          correct: corPrev,
                          ansList: finQAndAList,
                          mcqId: widget.mcqId,
                          subId: widget.subId,
                          time : restTime,
                          iniTime: widget.iniTime,
                          setEnd : widget.setEnd,

                        )
                        ));*/
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
                                        image: DecorationImage(
                                          image: NetworkImage(addPath),
                                          fit: BoxFit.fill,
                                        ),
                                        color: Colors.transparent,
                                      ),
                                      height: size.height * 0.15,
                                      width: size.width * 0.95,
                                    )
                                  : SizedBox(
                                      height: 0.1,
                                    ))
                              : SizedBox(
                                  height: 0.1,
                                ),
                          // Text(addPath ),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
