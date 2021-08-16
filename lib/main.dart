import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rankme_admin/OnBoarding_Screens/Welcome.dart';
import 'package:rankme_admin/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
  }

  return runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  final FirebaseMessaging _messaging = FirebaseMessaging();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //   navigatorObservers: [AnalyticsService().getAnalyticsObserver()],
      title: 'RankMe',
      theme: ThemeData(
        fontFamily: 'ProductSans',
        primaryColor: Colors.blueAccent[400],
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreen(),
    );
  }
}
