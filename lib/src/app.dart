import 'package:flutter/material.dart';
import 'package:mpengdup/src/screen/admin/complain_show.dart';
import 'package:mpengdup/src/screen/login.dart';
import 'package:mpengdup/src/screen/admin/home.dart' as Admin;
import 'package:mpengdup/src/screen/employee/home.dart' as Employee;
import 'package:mpengdup/src/screen/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
        routes: <String,WidgetBuilder>{
          '/':(context) => CheckAuth(),
          '/admin_home':(context)=>Admin.Home(),
          '/employee_home': (context)=>Employee.Home(),
          '/show_complaint':(context)=>ComplaintShow(),
          '/login':(context)=>Login(),
          '/Register':(context)=>Register()
        },
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  String role;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var group = localStorage.getString("role");

    if(token != null){
      setState(() {
        isAuth = true;
        role = group;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    print("Test");
    Widget child;
    if (isAuth) {
      print("app home");
      child = Admin.Home();
    } else {
      print("app login");
      child = Login();
    }

    return Scaffold(
      body: child,
    );
  }
}