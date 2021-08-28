import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rankme_admin/Animation/fade_animation.dart';
import 'package:rankme_admin/SubPages/mcq_instruction.dart';

class MCQPaperList extends StatefulWidget {
  final String subId;
  final String subName;
  const MCQPaperList({Key key, this.subId, this.subName}) : super(key: key);

  @override
  _MCQPaperListState createState() => _MCQPaperListState();
}

class _MCQPaperListState extends State<MCQPaperList> {
  bool loading = true;
  List mcqDetails = List();
  String mcqPaperId;
  String mcqPaperName;
  String mcqPaperQs;
  String mcqPaperTime;
  String mcqPaperInst;
  //Getting dynamic subjects
  getSubMcq(subId) async {
    print("Get mcq SUbPapers called");
    // FirebaseUser user = await FirebaseAuth.instance.currentUser();

    String subject = subId;

    var url = 'http://rankme.lk/appadmin/get_all_papers_new.php';
    final response = await http.post(Uri.encodeFull(url), headers: {
      "Accept": "application/json"
    }, body: {
      "subId": subject,
    });
    print(response.body);
    // if (response.body.toString() != "Error") {
    String jsonDataString = response.body;
    var data = jsonDecode(jsonDataString);
    loading = false;
    // if (this.mounted) {
    setState(() {
      mcqDetails = json.decode(jsonDataString.toString());
      print(mcqDetails);
      // mcqPaperId = mcqDetails[0]['id'];
      // mcqPaperName = mcqDetails[0]['name'];
      // mcqPaperQs = mcqDetails[0]['questions'];
      // mcqPaperTime = mcqDetails[0]['paper_time'];
      // mcqPaperInst = mcqDetails[0]['instructions'];
    });
    // }
    // checkCompletedornot(mcqPaperId, widget.user);
    // getPaused(mcqPaperId);
    // getMcqQues(mcqPaperId);
    // } else {
    //   setState(() {
    //     loading = false;
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    print('meka vada');
    getSubMcq(widget.subId);
    print(' vada');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: [
                Image.asset(
                  "assets/Guest_Screen.png",
                  height: size.height,
                  width: size.width,
                  fit: BoxFit.fill,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          'Paper List',
                          style: TextStyle(
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    mcqDetails.length == 0
                        ? Text('No papers')
                        : FadeAnimation(
                            1.4,
                            Column(
                              children: mcqDetails.reversed
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
                                                        MCQInstruction(
                                                          mqPaperId: list['id'],
                                                          mqPaperInst: list[
                                                              'instructions'],
                                                          mqPaperName:
                                                              list['name'],
                                                          mqPaperQs:
                                                              list['questions'],
                                                          mqPaperTime: list[
                                                              'paper_time'],
                                                          subname:
                                                              widget.subName,
                                                          subid: widget.subId,
                                                        )));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.blue,
                                                    width: 2),
                                                color: list['status'] == '1'
                                                    ? Colors.blue[100]
                                                    : Colors.amber[100]),
                                            height: size.height * 0.07,
                                            width: size.width * 0.9,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.library_books_outlined,
                                                  size: size.width * 0.06,
                                                  color: Colors.blue[700],
                                                ),
                                                Container(
                                                  width: size.width * 0.7,
                                                  child: Text(
                                                    list['name'],
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.04,
                                                        color: Colors.blue[700],
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
                          )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
