import 'package:flutter/material.dart';
import 'package:plantamas/appBar/app_Bar.dart';
import 'package:plantamas/bottomNavigation/bottom_nav.dart';
import 'package:plantamas/bottomNavigation/routes.dart';
import 'package:plantamas/plantaMas/generatedHomeWidget/generatedHomeWidget.dart';
import 'package:plantamas/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planta Más',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute: '/generatedHomeWidget',
      // routes: {
      //   '/generatedHomeWidget': (context) => GeneratedHomeWidget(),
      // },
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  BNavigator? myBNB;

  @override
  void initState() {
    // TODO: implement initState
    myBNB = BNavigator(currentIndex: (i) {
      setState(() {
        index = i;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: myBNB,
        body: Routes(index: index),
        appBar: AppBarPage());
  }
}
