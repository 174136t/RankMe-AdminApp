import 'package:flutter/material.dart';
import 'package:rankme_admin/HomePages/essay.dart';
import 'package:rankme_admin/HomePages/mcq.dart';
import 'package:rankme_admin/HomePages/notice.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 1;
  onTap(int index) {
    setState(() {
      currentIndex = index;
      print(currentIndex);
    });
  }

  @override
  void initState() {
    super.initState();

    currentIndex = 1;
    // getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: <Widget>[EssayPage(), McqPage(), NoticePage()][currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          index: 1,
          backgroundColor: Colors.white,
           color: currentIndex == 0
                  ? Colors.green[800]
                  : currentIndex == 1
                      ? Colors.blue[700]
                      : Colors.amber[800],
                    onTap: onTap,
              items: <Widget>[
                 Icon(
                  Icons.question_answer,
                  color: Colors.white,
                ),
                Icon(
                  Icons.file_copy,
                  color: Colors.white,
                ),
               
                Icon(
                  Icons.emoji_objects_rounded,
                  color: Colors.white,
                ),
              ]   
                      )
      ),
    );
  }
}
