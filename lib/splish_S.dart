import 'dart:async';

import 'package:arne_news/home.dart';
import 'package:flutter/material.dart';

class splish_Screen extends StatefulWidget {
  const splish_Screen({super.key});

  @override
  State<splish_Screen> createState() => _splish_ScreenState();
}

class _splish_ScreenState extends State<splish_Screen> {
   void initState() {
    super.initState();

    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
            
              child: Image.asset(
                ('images/logo.png'),
                height: 210,
              ),
            ),
          ],
        ),
      ),
    );
  }
}