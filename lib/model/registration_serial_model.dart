class RegistrationSerialData {
  RegistrationSerialData({
    required this.success,
    required this.message,
    required this.registrationSerial,
  });
  late final int success;
  late final String message;
  late final List<RegistrationSerial> registrationSerial;

  RegistrationSerialData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    registrationSerial = List.from(json['registration_serial'])
        .map((e) => RegistrationSerial.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['registration_serial'] =
        registrationSerial.map((e) => e.toJson()).toList();
    return _data;
  }
}

class RegistrationSerial {
  RegistrationSerial({
    required this.id,
    required this.name,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int status;

  RegistrationSerial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['status'] = status;
    return _data;
  }
}
