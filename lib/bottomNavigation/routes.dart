import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plantamas/home_page.dart';
import 'package:plantamas/page2.dart';
import 'package:plantamas/page3.dart';
import 'package:plantamas/page4.dart';
import 'package:plantamas/page5.dart';

class Routes extends StatelessWidget {
  final int index;
  const Routes({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      MyHomePage(),
      const Page2(),
      Page3( ),
      const Page4(),
      const Page5()
    ];
    return myList[index];
  }
}
