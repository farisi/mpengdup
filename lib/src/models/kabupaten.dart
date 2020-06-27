class Kabupaten {
  int id;
  String nama;

  Kabupaten({
    this.id, this.nama,
  });

  factory Kabupaten.fromJson(Map<String,dynamic> json) {
    return Kabupaten(
        id: json['id'],
        nama:json['nama']
    );
  }

  Map<String, dynamic> toJson(){
    Map<String,dynamic> data = new Map<String,dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    return data;
  }
}