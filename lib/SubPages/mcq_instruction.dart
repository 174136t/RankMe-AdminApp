import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rankme_admin/SubPages/mcq_view_2.dart';
import 'package:rankme_admin/SubPages/mcq_view_ques_and_ans.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MCQInstruction extends StatefulWidget {
  final String mqPaperId;
  final String mqPaperName;
  final String mqPaperQs;
  final String mqPaperTime;
  final String mqPaperInst;
  final String subname;
  final String subid;
  final String streamId;
  const MCQInstruction(
      {Key key,
      this.mqPaperId,
      this.mqPaperName,
      this.mqPaperQs,
      this.mqPaperTime,
      this.mqPaperInst,
      this.subname,
      this.subid, this.streamId})
      : super(key: key);

  @override
  _MCQInstructionState createState() => _MCQInstructionState();
}

class _MCQInstructionState extends State<MCQInstruction> {
  String mcqPaperId;
  String mcqPaperName;
  String mcqPaperQs;
  String mcqPaperTime;
  String mcqPaperInst;
  List pmcqQuestions = List();
  int pTime, pPage = 0, pCor, psetEnd, transTime;
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
  // int transTime;
  int qNumber;
  int quesAmt;
  int correct = 0;
  int wrong = 0;
  double total = 0.0;
  int strtEndT;
  bool isClosed = true;

  // getMcqQues(mcqPprId) async {
  //   print("GetSUbPapers called");
  //   // FirebaseUser user = await FirebaseAuth.instance.currentUser();

  //   String pprId = mcqPprId;

  //   var url = 'http://appadmin.rankme.lk/getMcqPprs.php';
  //   final response = await http.post(Uri.encodeFull(url), headers: {
  //     "Accept": "application/json"
  //   }, body: {
  //     "mcqPprId": pprId,
  //   });

  //   if (response.body.toString() != "Error") {
  //     String jsonDataString = response.body;
  //     var data = jsonDecode(jsonDataString);

  //     if (this.mounted) {
  //       setState(() {
  //         pmcqQuestions = json.decode(jsonDataString.toString());
  //       });
  //     }

  //     print("******************1234");
  //     print(pmcqQuestions.toString() + "*************************");

  //     // return new Row(children: list);

  //   }
  // }
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
      // print(ans);
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
                    mcqId: widget.mqPaperId,
                    subId: widget.subid,
                    subName: widget.subname,
                    papername: widget.mqPaperName,
                    stramId: widget.streamId,
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
                    mcqId: widget.mqPaperId,
                    subId: widget.subid,
                    subName: widget.subname,
                    papername: widget.mqPaperName,
                     stramId: widget.streamId,
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
    getMcqQues(widget.mqPaperId);
    pageNo = 0;
    setState(() {
      mcqPaperId = widget.mqPaperId;
      mcqPaperName = widget.mqPaperName;
      mcqPaperQs = widget.mqPaperQs;
      mcqPaperTime = widget.mqPaperTime;
      mcqPaperInst = widget.mqPaperInst;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Center(
          child: Container(
            // height: size.height * 0.9,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new ExactAssetImage('assets/bgchoosegrade.png'),
                fit: BoxFit.fill,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image(
                      image: AssetImage('assets/png_logo.png'),
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.30),
                  Container(
                    height: size.height * 0.08,
                    child: ListTile(
                      title: Center(
                        child: Text(
                          "Instructions",
                          style: TextStyle(
                              fontSize: size.height * 0.05,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  Container(
                    height: size.height * 0.1,
                    child: ListTile(
                      title: Text(
                        "Time Limit",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(mcqPaperTime + " min"),
                      leading: Icon(
                        Icons.timer,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.1,
                    child: ListTile(
                      title: Text(
                        "Subject",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(widget.subname),
                      leading: Icon(
                        Icons.book,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.1,
                    child: ListTile(
                      title: Text(
                        "Questions",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(mcqPaperQs),
                      leading: Icon(
                        Icons.format_list_numbered,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.1,
                    child: ListTile(
                      title: Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(mcqPaperInst),
                      leading: Icon(
                        Icons.question_answer,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                    child: RaisedButton(
                      color: Colors.indigo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => MCQViewQues(
                        //               mcqPprId: mcqPaperId,
                        //               subId: widget.subid,
                        //             )));
                        //  Navigator.push(
                        //                       context,
                        //                       MaterialPageRoute(
                        //                           builder: (context) => MCQView2(
                        //                               quesList: pmcqQuestions,
                        //                               pageNo: pPage,
                        //                               correct: pCor,
                        //                               // ansList: finalsPause,
                        //                               mcqId: widget.mqPaperId,
                        //                               subId: widget.subid,
                        //                               // time: pTime,
                        //                               // iniTime: transTime,
                        //                               // setEnd:
                        //                               //     psetEnd.toString(),
                        //                               // mapped: map,
                        //                               )));
                        validateAns(selectedFinal);
                      },
                      child: Text('View',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  )
                ],
              ),
            ),
          ),
        ),
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
