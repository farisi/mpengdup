import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mpengdup/src/screen/login.dart';
import 'package:mpengdup/src/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.red;
  final Text title;
  final AppBar appBar;
  final List<Widget> widgets;

  /// you can add more fields that meet your needs

  const BaseAppBar({Key key, this.title, this.appBar, this.widgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

//  void logout() async{
//
//    var res = await Network().getData('/auth/logout');
//    var body = json.decode(res.body);
//
//    if(body['success']){
//      SharedPreferences localStorage = await SharedPreferences.getInstance();
//      localStorage.remove("role");
//      localStorage.remove('user');
//      localStorage.remove('token');
//      Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context)=>Login()));
//    }
//  }
}