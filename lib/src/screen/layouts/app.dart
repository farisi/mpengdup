import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpengdup/src/screen/admin/complain_show.dart';
import 'package:mpengdup/src/screen/admin/home.dart';
import 'package:mpengdup/src/screen/login.dart';
import 'package:mpengdup/src/screen/register.dart';

class LayoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Map<int, Color> color = {
      50: Color.fromRGBO(255, 144, 0, .1),
      100: Color.fromRGBO(255, 144, 0, .2),
      200: Color.fromRGBO(255, 144, 0, .3),
      300: Color.fromRGBO(255, 144, 0, .4),
      400: Color.fromRGBO(255, 144, 0, .5),
      500: Color.fromRGBO(255, 144, 0, .6),
      600: Color.fromRGBO(255, 144, 0, .7),
      700: Color.fromRGBO(255, 144, 0, .8),
      800: Color.fromRGBO(255, 144, 0, .9),
      900: Color.fromRGBO(255, 144, 0, 1),
    };

    return MaterialApp(
      theme:ThemeData(
          primarySwatch:MaterialColor(0xFFFF7000, color),
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => Home(),
        '/show_complaint':(context)=>ComplaintShow(),
        '/login':(context)=>Login(),
        'Register':(context)=>Register()
      },
    );
  }
}