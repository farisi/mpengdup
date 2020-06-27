class Kecamatan {
  int id;
  String nama;

  Kecamatan({
    this.id, this.nama,
  });

  factory Kecamatan.fromJson(Map<String,dynamic> json) {
    return Kecamatan(
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