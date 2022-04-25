class DistrictData {
  DistrictData({
    required this.success,
    required this.message,
    required this.district,
  });
  late final int success;
  late final String message;
  late final List<District> district;

  DistrictData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    district =
        List.from(json['district']).map((e) => District.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['district'] = district.map((e) => e.toJson()).toList();
    return _data;
  }
}

class District {
  District(
      {required this.id,
      required this.name,
      required this.divisionId,
      required this.status});
  late final int id;
  late final String name;
  late final int divisionId;
  late final int status;

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    divisionId = json['division_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['division_id'] = divisionId;
    _data['status'] = status;
    return _data;
  }
}
