class BrandsList {
  BrandsList({
    required this.success,
    required this.message,
    required this.brands,
  });
  late final int success;
  late final String message;
  late final List<Brands> brands;

  BrandsList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    brands = List.from(json['brands']).map((e) => Brands.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['brands'] = brands.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Brands {
  Brands({
    required this.id,
    required this.name,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int status;

  Brands.fromJson(Map<String, dynamic> json) {
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
