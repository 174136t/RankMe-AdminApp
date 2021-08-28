import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rankme_admin/Animation/fade_animation.dart';
import 'package:rankme_admin/SubPages/essay_paper_list.dart';

class EssaySubList extends StatefulWidget {
  final String sub;
  const EssaySubList({Key key, this.sub}) : super(key: key);

  @override
  _EssaySubListState createState() => _EssaySubListState();
}

class _EssaySubListState extends State<EssaySubList> {
  List subList = [];

  //Getting dynamic subjects
  getSubjects(stream) async {
    print("GetSUb called");

    var url = 'http://appadmin.rankme.lk/getDynamicSub.php';
    final response = await http.post(Uri.encodeFull(url), headers: {
      "Accept": "application/json"
    }, body: {
      "selectedStream": stream,
    });
    String jsonDataString = response.body;
    var data = jsonDecode(jsonDataString);
    print(jsonDataString.toString());
    setState(() {
      subList = json.decode(jsonDataString.toString());
//      for(var i = 0; i < subList.length; i++){
//        selectedSubList[subList[i]] = false;
//      }
    });
  }

  @override
  void initState() {
    // initPreferences();
    super.initState();
    getSubjects(widget.sub);
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
                // mainAxisAlignment: MainAxisAlignment.center,

                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'Subject List',
                        style: TextStyle(
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  FadeAnimation(
                    1.4,
                    Column(
                      children: subList
                          .map((list) => Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // String subjectId = list['id'];

                                    // String user =

                                    //     list['user_data_id'];

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EssayPaperList(
                                                    subId: list['id'],
                                                    subName: list['name'])));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.green, width: 2),
                                        color: Colors.green[100]),
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
                                            list['name'],
                                            style: TextStyle(
                                                fontSize: size.width * 0.04,
                                                color: Colors.green[700],
                                                fontWeight: FontWeight.w900),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
