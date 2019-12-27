import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:villastore_app/old.dart';

import 'Home.dart';
import 'Models/UnitModel.dart';
import 'package:loadmore/loadmore.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
            bottomNavigationBar: Container(
              child: CurvedNavigationBar(
                backgroundColor: Colors.white70,
                buttonBackgroundColor: Colors.white,
                color: Colors.white,
                height: 42,
                items: <Widget>[
                  Icon(Icons.add, size: 30, color: Colors.indigo),
                  Icon(Icons.list, size: 30, color: Colors.indigo),
                  Icon(Icons.home, size: 30, color: Colors.indigo),
                  Icon(Icons.score, size: 30, color: Colors.indigo),
                  Icon(Icons.print, size: 30, color: Colors.indigo),
                ],
                onTap: (index) {
                  //Handle button tap
                },
              ),
//              alignment: FractionalOffset.bottomCenter,
            ),
            body: Scaffold(
              body:  Home(),

            )));
  }
}
