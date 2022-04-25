class ThanaData {
  ThanaData({
    required this.success,
    required this.message,
    required this.thana,
  });
  late final int success;
  late final String message;
  late final List<Thana> thana;

  ThanaData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    thana = List.from(json['thana']).map((e) => Thana.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['thana'] = thana.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Thana {
  Thana({
    required this.id,
    required this.name,
    required this.districtId,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int districtId;
  late final int status;

  Thana.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    districtId = json['district_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['district_id'] = districtId;
    _data['status'] = status;
    return _data;
  }
}
