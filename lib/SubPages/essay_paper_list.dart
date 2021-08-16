import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class EssayPaperList extends StatefulWidget {
   final String subId;
  final String subName;
  const EssayPaperList({ Key key, this.subId, this.subName }) : super(key: key);

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

    var url = 'http://appadmin.rankme.lk/getSubMcq.php';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Center(child: Text(mcqDetails[0]['instructions']))],
        ),
      ),
    );
  }
}
