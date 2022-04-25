class FuelTypesList {
  FuelTypesList({
    required this.success,
    required this.message,
    required this.fuelTypes,
  });
  late final int success;
  late final String message;
  late final List<FuelTypes> fuelTypes;

  FuelTypesList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    fuelTypes = List.from(json['fuel_types'])
        .map((e) => FuelTypes.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['fuel_types'] = fuelTypes.map((e) => e.toJson()).toList();
    return _data;
  }
}

class FuelTypes {
  FuelTypes({
    required this.id,
    required this.name,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int status;

  FuelTypes.fromJson(Map<String, dynamic> json) {
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
