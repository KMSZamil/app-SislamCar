class ConditionsList {
  ConditionsList({
    required this.success,
    required this.message,
    required this.conditions,
  });
  late final int success;
  late final String message;
  late final List<Conditions> conditions;

  ConditionsList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    conditions = List.from(json['conditions'])
        .map((e) => Conditions.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['conditions'] = conditions.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Conditions {
  Conditions({
    required this.id,
    required this.name,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int status;

  Conditions.fromJson(Map<String, dynamic> json) {
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
