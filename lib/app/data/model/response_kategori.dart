/// status : 200
/// message : "success"
/// data : [{"id":6,"nama":"religi","created_at":"2024-04-24T08:25:27.000000Z","updated_at":"2024-04-24T08:25:27.000000Z"},{"id":2,"nama":"hiburan","created_at":"2024-03-28T03:57:00.000000Z","updated_at":"2024-03-28T03:57:00.000000Z"},{"id":1,"nama":"umum","created_at":"2024-03-07T00:34:02.000000Z","updated_at":"2024-03-07T00:34:02.000000Z"}]

class ResponseKategori {
  ResponseKategori({
    int? status,
    String? message,
    List<DataKategori>? data,
  }) {
    _status = status;
    _message = message;
    _data = data ?? [];
  }

  ResponseKategori.fromJson(dynamic json) {
    _status = json['status'] as int?;  // Pastikan tipe data yang tepat
    _message = json['message'] as String?;
    _data = json['data'] != null
        ? (json['data'] as List<dynamic>)
        .map((v) => DataKategori.fromJson(v))
        .toList()
        : [];
  }

  int? _status;
  String? _message;
  List<DataKategori>? _data;

  ResponseKategori copyWith({
    int? status,
    String? message,
    List<DataKategori>? data,
  }) {
    return ResponseKategori(
      status: status ?? _status,
      message: message ?? _message,
      data: data ?? _data,
    );
  }

  int? get status => _status;
  String? get message => _message;
  List<DataKategori>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data?.map((v) => v.toJson()).toList();  // Perlakukan null dengan hati-hati
    return map;
  }
}


/// id : 6
/// nama : "religi"
/// created_at : "2024-04-24T08:25:27.000000Z"
/// updated_at : "2024-04-24T08:25:27.000000Z"

class DataKategori {
  DataKategori({
    int? id,
    String? nama,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _nama = nama;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  DataKategori.fromJson(dynamic json) {
    _id = json['id'] as int?;  // Pastikan tipe data yang tepat
    _nama = json['nama'] as String?;
    _createdAt = json['created_at'] as String?;
    _updatedAt = json['updated_at'] as String?;
  }

  int? _id;
  String? _nama;
  String? _createdAt;
  String? _updatedAt;

  DataKategori copyWith({
    int? id,
    String? nama,
    String? createdAt,
    String? updatedAt,
  }) {
    return DataKategori(
      id: id ?? _id,
      nama: nama ?? _nama,
      createdAt: createdAt ?? _createdAt,
      updatedAt: updatedAt ?? _updatedAt,
    );
  }

  int? get id => _id;
  String? get nama => _nama;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nama'] = _nama;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
