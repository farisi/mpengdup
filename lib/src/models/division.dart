class ChuckDivision {
  List<Division> data;
  bool status;

  ChuckDivision({this.data,this.status});

  ChuckDivision.fromJson(Map<String,dynamic> json) {
    if(json['data']!=null) {
      data = new List<Division>();
      json['data'].forEach((v) {
        data.add(new Division.fromJson(v));
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

class Division {
   int id;
   String division;

  Division({this.id,this.division});

  Division.fromJson(Map<String,dynamic> json){
    id=json['id'];
    division = json['division'];
  }

   Map<String,dynamic> toJson() {
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['id']=this.id;
    data['division']=this.division;
    return data;
  }


}