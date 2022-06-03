import 'package:flutter/material.dart';
import 'package:plantamas/plantaMas/generatedHomeWidget/generatedHomeWidget.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // initialRoute: '/generatedHomeWidget',
      // routes: {
      //   '/generatedHomeWidget': (context) => GeneratedHomeWidget(),
      // },
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: My Garden',
      style: optionStyle,
    ),
    Text(
      'Index 2: Search',
      style: optionStyle,
    ),
    Text(
      'Index 3: Chat',
      style: optionStyle,
    ),
    Text(
      'Index 4: Notes',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color.fromARGB(245, 245, 245, 245)),
          BottomNavigationBarItem(
              icon: Icon(Icons.heart_broken),
              label: 'MyGarden',
              backgroundColor: Color.fromARGB(245, 245, 245, 245)),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: Color.fromARGB(245, 245, 245, 245)),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
              backgroundColor: Color.fromARGB(245, 245, 245, 245)),
          BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Notes',
              backgroundColor: Color.fromARGB(245, 245, 245, 245)),
        ],
        backgroundColor: Color.fromARGB(255, 160, 160, 160),
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        onTap: _onItemTapped,
      ),
    );
  }
}
