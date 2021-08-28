import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rankme_admin/Animation/fade_animation.dart';
import 'package:rankme_admin/SubPages/essay_body.dart';

class EssayPaperList extends StatefulWidget {
  final String subId;
  final String subName;
  const EssayPaperList({Key key, this.subId, this.subName}) : super(key: key);

  @override
  _EssayPaperListState createState() => _EssayPaperListState();
}

class _EssayPaperListState extends State<EssayPaperList> {
  bool loading = true;
  List mcqDetails = List();
  //Getting dynamic subjects
  getSubMcq(subId) async {
    print("Get mcq SUbPapers called");
    // FirebaseUser user = await FirebaseAuth.instance.currentUser();

    String subject = subId;

    var url = 'http://rankme.lk/appadmin/get_all_eassy_quesions.php';
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
                          'Question List',
                          style: TextStyle(
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    mcqDetails.length == 0
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text("No Questions"),
                                ),
                              ],
                            ),
                          )
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
                                                        EssayBody(
                                                            qText: list['text'],
                                                            qImage:
                                                                list['image'],
                                                            answer:
                                                                list['answer'],
                                                            answerImage: list[
                                                                'answer_image'],
                                                            qNo: list['no']
                                                                .toString())));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.green,
                                                    width: 2),
                                                color: list['status'] == '1'
                                                    ? Colors.green[100]
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
                                                  color: Colors.green[700],
                                                ),
                                                Container(
                                                  width: size.width * 0.7,
                                                  child: Text(
                                                    "Question No " + list['no'],
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.04,
                                                        color:
                                                            Colors.green[700],
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: size.width * 0.06,
                                                  color: Colors.green[700],
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
