import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mpengdup/src/screen/login.dart';
import 'package:mpengdup/src/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  String name;
  String group;
  @override
  void initState(){
    _loadUserData();
    super.initState();
  }
  _loadUserData() async{

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    var role = jsonDecode(localStorage.getString("role"));
    if(user != null) {
      setState(() {
        name = user['name'];
        group = role;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Petugas'),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
              logout();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Hi, $name',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logout() async{

    var res = await Network().getData('/auth/logout');
    var body = json.decode(res.body);

    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove("role");
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.pushNamed(context, '/login');
    }
  }
}