import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallper/views/home/home.dart';
import 'package:flutter_wallper/views/about/about.dart';


void main(){
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarIconBrightness:Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'neets壁纸',
      routes: {
        '/splash':(context) => SplashPage(),
        '/home':(context) => HomePage(),
        '/about':(context) => AboutPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = new Timer(const Duration(milliseconds: 1500), () {
      _navigateToSecondPage(context);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }

  _navigateToSecondPage(BuildContext context) async {
    dynamic customArgumnets = await Navigator.pushNamed(context, '/home',
        arguments: 'Android进阶之光');//1
  }
}

