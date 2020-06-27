import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mpengdup/src/blocs/complaint_bloc.dart';
import 'package:mpengdup/src/models/complaint.dart';
import 'package:mpengdup/src/models/response.dart';
import 'package:mpengdup/src/network_utils/api.dart';
import 'package:mpengdup/src/screen/admin/complain_show.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  String name;
  String group;
  bool _isLoading = false;
  ComplaintBloc bloc;

  @override
  void initState(){
    _loadUserData();

    super.initState();
    bloc = ComplaintBloc();
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
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Admin'),
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
        body: RefreshIndicator(
            onRefresh: ()=>bloc.fetchAllComplaint(),
            child: StreamBuilder<Response<List<Complaint>>>(
                stream:bloc.allComplaint,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    switch(snapshot.data.status) {
                      case Status.LOADING:
                        print("Status Loading " );
                        return Loading(loadingMessage: snapshot.data.message);
                        break;
                      case Status.COMPLETED:
                      // TODO: Handle this case.
                        return ComplaintList(complaints: snapshot.data.data);
                        break;
                      case Status.ERROR:
                      // TODO: Handle this case.
                        return Error(
                          errorMessage: snapshot.data.message,
                          onRetryPressed: () => bloc.fetchAllComplaint(),
                        );
                        break;
                    }
                  }
                  return Container();
                }
            )
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
class ComplaintList extends StatelessWidget{
  final List<Complaint> complaints;

  const ComplaintList({Key key, this.complaints}) : super(key:key);

  Widget build(BuildContext context) {
    print(" build ComplaintList " );
    return ListView.builder(
        itemCount: complaints.length,
        padding: EdgeInsets.only(top:15.5),
        itemBuilder: (BuildContext context, i){
          return Card(
            child: ListTile(
                title:Text(complaints[i].description.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(complaints[i].created_at.toString()),
                trailing: IconButton(
                icon:Icon(Icons.arrow_right),
                    onPressed: (){
                      print(" list di klik " + complaints[i].division.id.toString());
                      Navigator.pushNamed(context, '/show_complaint',arguments: complaints[i]);
                    },
                ),

            ),
          );
        }
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.lightGreen,
            child: Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}