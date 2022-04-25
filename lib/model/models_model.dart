class ModelsList {
  ModelsList({
    required this.success,
    required this.message,
    required this.models,
  });
  late final int success;
  late final String message;
  late final List<Models> models;

  ModelsList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    models = List.from(json['models']).map((e) => Models.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['models'] = models.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Models {
  Models({
    required this.id,
    required this.name,
    required this.carBrand,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int carBrand;
  late final int status;

  Models.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    carBrand = json['car_brand'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['car_brand'] = carBrand;
    _data['status'] = status;
    return _data;
  }
}
