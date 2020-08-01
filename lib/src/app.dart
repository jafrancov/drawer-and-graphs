import 'package:drawer/src/screens/first_screen.dart';
import 'package:drawer/src/screens/fourth_screen.dart';
import 'package:drawer/src/screens/home_screen.dart';
import 'package:drawer/src/screens/second_screen.dart';
import 'package:drawer/src/screens/third_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  final appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
//        '/': (context) => MyHomePage(),
        '/barrasSimple': (context) => BarrasSimple(),
        '/barrasHorizontales': (context) => BarrasHorizontales(),
        '/barrasRedondeadas': (context) => BarrasRedondeadas(),
        '/barrasAgrupadas': (context) => BarrasAgrupadas(),
      },
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

