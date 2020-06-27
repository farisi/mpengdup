import 'package:mpengdup/src/models/division.dart';



class ChuckComplaints {
  List<Complaint> data;
  bool status;

  ChuckComplaints({this.data,this.status});

  ChuckComplaints.fromJson(Map<String,dynamic> json) {

    if(json['data']!=null) {
      data = new List<Complaint>();
      json['data'].forEach((v) {
        data.add(new Complaint.fromJson(v));
      });
    }

    status=json['status'];

  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> mydata = new Map<String, dynamic>();
    mydata['status']=this.status;

    if(this.data != null) {
      mydata['data'] = this.data.map((v)=>v.toJson()).toList();
    }
    return mydata;
  }
}

class Complaint {
  int id;
  String name;
  String nik;
  String profession;
  DateTime born;
  String organitation;
  String mobile;
  String alternative_mobile;
  String telpon;
  String email;
  String description;
  DateTime created_at;
  DateTime updated_at;
  int division_id;
  Division division;
  //final Kabupaten kab;
  //final Kecamatan kec;

  Complaint({this.id,this.name,this.nik,this.profession,this.born,this.organitation,this.mobile,this.alternative_mobile,
    this.telpon,this.email,this.description,this.created_at, this.updated_at, this.division_id, this.division});

  Complaint.fromJson(Map<String,dynamic> data){
    id = data['id'];
    name = data['name'];
    nik = data['nik'];
    profession = data['profession'];
    born = DateTime.parse(data['born']);
    organitation = data['organitation'];
    mobile = data['mobile'];
    alternative_mobile = data['alternative_mobile'];
    telpon = data['telpon'];
    email = data['email'];
    description = data['description'];
    created_at = DateTime.parse(data['created_at']);
    updated_at = DateTime.parse(data['updated_at']);
    division =  data['division'] != null ?  Division.fromJson(data['division']) : new Division();
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this.id;
    data['name']=this.name;
    data['nik']=this.nik;
    data['profession'] = this.profession;
    data['born'] = this.born.toString();
    data['organitation'] = this.organitation;
    data['mobile']=this.mobile;
    data['alternative_mobile'] = this.alternative_mobile;
    data['telpon'] = this.telpon;
    data['email'] = this.email;
    data['description'] = this.description;
    data['division_id'] = this.division_id;
    //data['kab'] = this.kab;
    //data['kec'] = this.kec;

    return data;

  }

}