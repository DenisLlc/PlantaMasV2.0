import 'package:flutter/material.dart';

class GeneratedHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ClipRRect(
        borderRadius: BorderRadius.zero,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.zero,
              child: Container(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.red,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Business',
                  backgroundColor: Colors.green,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'School',
                  backgroundColor: Colors.purple,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                  backgroundColor: Colors.pink,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
