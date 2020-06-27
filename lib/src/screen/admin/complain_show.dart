import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mpengdup/src/blocs/complaint_bloc.dart';
import 'package:mpengdup/src/blocs/division_bloc.dart';
import 'package:mpengdup/src/models/complaint.dart';
import 'package:mpengdup/src/models/division.dart';
import 'package:mpengdup/src/models/response.dart';
import 'package:mpengdup/src/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ComplaintShow extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ComplainShowState();
  }

}
class _ComplainShowState extends State<ComplaintShow> {

  DivisionBloc bloc;
  ComplaintBloc _complaintBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Complaint mcomplaint;

  _ComplainShowState();

  int dropdownValue=0;

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc  = DivisionBloc();
    _complaintBloc = ComplaintBloc();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(ComplaintShow oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print(" didUpdateWidget Call " + oldWidget.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _complaintBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Complaint complaint = ModalRoute.of(context).settings.arguments;
    print(" complaint pada compaint_show build " + complaint.division.id.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Pengaduan"),
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
      body:Container(
        child:
        Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left:2.0,top:2.0,right:5.0,bottom:2.0),
                  child:Card(
                    elevation: 4.0,
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10, right: 10,bottom: 20,top: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: StreamBuilder<Response<List<Division>>>(
                            stream: bloc.divisionListStream,
                            builder: (context,snapshot){
                              if(snapshot.hasData){
                                switch(snapshot.data.status) {
                                  case Status.LOADING:
                                    return Loading(loadingMessage: snapshot.data.message);
                                    break;
                                  case Status.COMPLETED:
                                  // TODO: Handle this case.
                                    List<DropdownMenuItem> listDivisi = List<DropdownMenuItem>();
                                    listDivisi.add(new DropdownMenuItem(child: Text('Pilih Salah Satu'),value: 0,));
                                    snapshot.data.data.forEach((f)=>listDivisi.add(new DropdownMenuItem(child: Text(f.division),value: f.id)));
                                    //return DivisionDropdownButton(divisions: snapshot.data.data);
                                    return DropdownButton<dynamic>(
                                      items: listDivisi,
                                      onChanged: (dynamic value) {
                                          setState(() {
                                            dropdownValue=value;
                                          });
                                          complaint.division.id = value;
                                      },
                                      value:complaint.division.id == null ? 0 : complaint.division.id,


                                    );
                                    break;
                                  case Status.ERROR:
                                  // TODO: Handle this case.
                                    return Error(
                                      errorMessage: snapshot.data.message,
                                      onRetryPressed: () => bloc.FetchAllDivision(),
                                    );
                                    break;
                                }
                              }
                              return Container();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child:  FlatButton(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 8, bottom: 8, left: 10, right: 10),
                              child: Text(
                                'Tugaskan',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            color: Colors.teal,
                            disabledColor: Colors.grey,
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(20.0)),
                            onPressed: () {

                                print(" complain divisi id sebelum diberikan dropdown" + complaint.division.id.toString());

                                if(complaint.division.id > 0 ) {
                                  complaint.division_id = dropdownValue;
                                    _complaintBloc.updateComplaint('/complain/' + complaint.id.toString() , complaint);
                                    _complaintBloc.getComplaint.single.then((Response v){
                                      print(v.message);
                                      _showMsg(v.message);
                                    });
                                    Navigator.pushNamed(context, "/admin_home");
                                }
                            },
                          ),
                        ),
                      ],
                    ),
                  ) ,
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                          elevation: 4.0,
                          color: Colors.white,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: EdgeInsets.all(28.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left:5.0, top:18.0,right: 18.0,bottom: 18.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text('Nama'),
                                      ),
                                      Expanded(
                                        child: Text(complaint.name),
                                      )
                                    ],
                                  ),

                                ),
                                Padding(
                                  padding: EdgeInsets.only(left:5.0, top:18.0,right: 18.0,bottom: 18.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text('Email'),
                                      ),
                                      Expanded(
                                        child: Text(complaint.email),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left:5.0, top:18.0,right: 18.0,bottom: 18.0),
                                  child: Text('Ini Isinya descripsi dari permasalah yang akan dilaporkan '),
                                )

                              ],
                            ),
                          )
                      ),
                    )

                  ],
                )
              ],
            )
          ],
        ) ,
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