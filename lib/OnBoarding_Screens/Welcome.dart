import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rankme_admin/Animation/fade_animation.dart';
import 'package:rankme_admin/OnBoarding_Screens/login.dart';
import 'package:rankme_admin/OnBoarding_Screens/signup.dart';
import 'package:rankme_admin/constant.dart';


class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              "assets/splashback.png",
              height: size.height,
              width: size.width,
              fit: BoxFit.fill,
            ),
            FadeAnimation(
              1.2,
              Container(
                // we will give media query height
                // double.infinity make it big as my parent allows
                // while MediaQuery make it big as per the screen

                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(
                  // even space distribution
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: size.width * 0.90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Welcome to,",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "RankMe",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/boy.png"))),
                    ),
                    Column(
                      children: <Widget>[
                        // the login button
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Container(
                            width: size.width * 0.80,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                // gradient: blackBlueGradient
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.blue, width: 2)),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        // creating the signup button
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                          },
                          child: Container(
                            width: size.width * 0.80,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: skyBlueGradient),
                            child: Center(
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
