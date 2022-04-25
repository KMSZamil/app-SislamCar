class BuyCarsData {
  BuyCarsData({
    required this.success,
    required this.message,
    required this.dashboardCars,
  });
  late final int success;
  late final String message;
  late final List<BuyCars> dashboardCars;
  
  BuyCarsData.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    dashboardCars = List.from(json['dashboard_cars']).map((e)=>BuyCars.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['dashboard_cars'] = dashboardCars.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class BuyCars {
  BuyCars({
    required this.id,
    required this.customerId,
    required this.carTitle,
    required this.madeIn,
    required this.carCondition,
    required this.brand,
    required this.carModel,
    required this.menufacturingYear,
    required this.milage,
    required this.engineCapacity,
    required this.bodyType,
    required this.fuelType,
    required this.transmission,
    required this.registrationYear,
     this.registrationSerial,
     this.registrationCity,
     this.registrationNumber,
    required this.driveType,
    required this.exteriorColor,
    required this.interiorColor,
    required this.comfort,
    required this.enterteinment,
    required this.safty,
    required this.seats,
    required this.wwindow,
    required this.others,
    required this.taxTokenExpaire,
    required this.fitnesExspaire,
    required this.bankLoan,
    required this.nameTransfer,
    required this.message,
    required this.price,
     this.videoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.status,
    required this.homeFeature,
    required this.carStatus,
    required this.carDetails,
    required this.images,
    required this.carImages,
    required this.sellerFuelTypes,
    required this.condition,
    required this.carBrand,
    required this.model,
    required this.bodytype,
    required this.carExteriorColor,
    required this.carTransmission,
  });
  late final int id;
  late final int customerId;
  late final String carTitle;
  late final int madeIn;
  late final int carCondition;
  late final int brand;
  late final int carModel;
  late final int menufacturingYear;
  late final String milage;
  late final String engineCapacity;
  late final int bodyType;
  late final String fuelType;
  late final int transmission;
  late final int registrationYear;
  late final int? registrationSerial;
  late final int? registrationCity;
  late final String? registrationNumber;
  late final DriveType driveType;
  late final int exteriorColor;
  late final int interiorColor;
  late final String comfort;
  late final String enterteinment;
  late final String safty;
  late final String seats;
  late final String wwindow;
  late final String others;
  late final String taxTokenExpaire;
  late final String fitnesExspaire;
  late final String bankLoan;
  late final int nameTransfer;
  late final String message;
  late final int price;
  late final String? videoUrl;
  late final String createdAt;
  late final String updatedAt;
  late final int createdBy;
  late final int status;
  late final int homeFeature;
  late final int carStatus;
  late final String carDetails;
  late final List<Images> images;
  late final List<CarImages> carImages;
  late final List<SellerFuelTypes> sellerFuelTypes;
  late final Condition condition;
  late final CarBrand carBrand;
  late final Model model;
  late final Bodytype bodytype;
  late final CarExteriorColor carExteriorColor;
  late final CarTransmission carTransmission;
  
  BuyCars.fromJson(Map<String, dynamic> json){
    id = json['id'];
    customerId = json['customer_id'];
    carTitle = json['car_title'];
    madeIn = json['made_in'];
    carCondition = json['car_condition'];
    brand = json['brand'];
    carModel = json['car_model'];
    menufacturingYear = json['menufacturing_year'];
    milage = json['milage'];
    engineCapacity = json['engine_capacity'];
    bodyType = json['body_type'];
    fuelType = (json['fuel_type']==null)?'':json['fuel_type'];
    transmission = json['transmission'];
    registrationYear = json['registration_year'];
    registrationSerial = (json['registration_serial']==null)?0:json['registration_serial'];
    registrationCity = (json['registration_city']==null)?0:json['registration_city'];
    registrationNumber = (json['registration_number']==null)?'':json['registration_number'];
    driveType = DriveType.fromJson(json['car_drive_type']);
    exteriorColor = json['exterior_color'];
    interiorColor = json['interior_color'];
    comfort = (json['comfort']==null)?'':json['comfort'];
    enterteinment = (json['enterteinment']==null)?'':json['enterteinment'];
    safty = (json['safty']==null)?'':json['safty'];
    seats = json['seats'];
    wwindow = (json['wwindow']==null)?'':json['wwindow'];
    others = (json['others']==null)?'':json['others'];
    taxTokenExpaire = json['tax_token_expaire'];
    fitnesExspaire = json['fitnes_exspaire'];
    bankLoan = (json['bank_loan']==null)?'':json['bank_loan'];
    nameTransfer = json['name_transfer'];
    message = (json['message']==null)?'':json['message'];
    price = json['price'];
    videoUrl = (json['video_url']==null)?'':json['video_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = (json['created_by']==null)?0:json['created_by'];
    status = json['status'];
    homeFeature = json['home_feature'];
    carStatus = json['car_status'];
    carDetails = json['car_details'];
    images = List.from(json['images']).map((e)=>Images.fromJson(e)).toList();
    carImages = List.from(json['car_images']).map((e)=>CarImages.fromJson(e)).toList();
    sellerFuelTypes = List.from(json['seller_fuel_types']).map((e)=>SellerFuelTypes.fromJson(e)).toList();
    condition = Condition.fromJson(json['condition']);
    carBrand = CarBrand.fromJson(json['car_brand']);
    model = Model.fromJson(json['model']);
    bodytype = Bodytype.fromJson(json['bodytype']);
    carExteriorColor = CarExteriorColor.fromJson(json['car_exterior_color']);
    carTransmission = CarTransmission.fromJson(json['car_transmission']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['customer_id'] = customerId;
    _data['car_title'] = carTitle;
    _data['made_in'] = madeIn;
    _data['car_condition'] = carCondition;
    _data['brand'] = brand;
    _data['car_model'] = carModel;
    _data['menufacturing_year'] = menufacturingYear;
    _data['milage'] = milage;
    _data['engine_capacity'] = engineCapacity;
    _data['body_type'] = bodyType;
    _data['fuel_type'] = fuelType;
    _data['transmission'] = transmission;
    _data['registration_year'] = registrationYear;
    _data['registration_serial'] = registrationSerial;
    _data['registration_city'] = registrationCity;
    _data['registration_number'] = registrationNumber;
    _data['car_drive_type'] = driveType.toJson();
    _data['exterior_color'] = exteriorColor;
    _data['interior_color'] = interiorColor;
    _data['comfort'] = comfort;
    _data['enterteinment'] = enterteinment;
    _data['safty'] = safty;
    _data['seats'] = seats;
    _data['wwindow'] = wwindow;
    _data['others'] = others;
    _data['tax_token_expaire'] = taxTokenExpaire;
    _data['fitnes_exspaire'] = fitnesExspaire;
    _data['bank_loan'] = bankLoan;
    _data['name_transfer'] = nameTransfer;
    _data['message'] = message;
    _data['price'] = price;
    _data['video_url'] = videoUrl;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['created_by'] = createdBy;
    _data['status'] = status;
    _data['home_feature'] = homeFeature;
    _data['car_status'] = carStatus;
    _data['car_details'] = carDetails;
    _data['images'] = images.map((e)=>e.toJson()).toList();
    _data['car_images'] = carImages.map((e)=>e.toJson()).toList();
    _data['seller_fuel_types'] = sellerFuelTypes.map((e)=>e.toJson()).toList();
    _data['condition'] = condition.toJson();
    _data['car_brand'] = carBrand.toJson();
    _data['model'] = model.toJson();
    _data['bodytype'] = bodytype.toJson();
    _data['car_exterior_color'] = carExteriorColor.toJson();
    _data['car_transmission'] = carTransmission.toJson();
    return _data;
  }
}

class DriveType {
  DriveType({
    required this.id,
    required this.name,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int status;
  
  DriveType.fromJson(Map<String, dynamic> json){
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

class Images {
  Images({
    required this.sellerId,
    required this.smartCardPhoto,
     this.taxTokenPhoto,
    required this.fitnessPhoto,
    required this.bankClearancePhoto,
  });
  late final int sellerId;
  late final String smartCardPhoto;
  late final String? taxTokenPhoto;
  late final String fitnessPhoto;
  late final String bankClearancePhoto;
  
  Images.fromJson(Map<String, dynamic> json){
    sellerId = json['seller_id'];
    smartCardPhoto = (json['smart_card_photo']==null)?'':json['smart_card_photo'];
    taxTokenPhoto = (json['tax_token_photo']==null)?'':json['tax_token_photo'];
    fitnessPhoto = (json['fitness_photo']==null)?'':json['fitness_photo'];
    bankClearancePhoto = (json['bank_clearance_photo']==null)?'':json['bank_clearance_photo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['seller_id'] = sellerId;
    _data['smart_card_photo'] = smartCardPhoto;
    _data['tax_token_photo'] = taxTokenPhoto;
    _data['fitness_photo'] = fitnessPhoto;
    _data['bank_clearance_photo'] = bankClearancePhoto;
    return _data;
  }
}

class CarImages {
  CarImages({
    required this.id,
    required this.sellerId,
    required this.carImage,
    required this.status,
  });
  late final int id;
  late final int sellerId;
  late final String carImage;
  late final String status;
  
  CarImages.fromJson(Map<String, dynamic> json){
    id = json['id'];
    sellerId = json['seller_id'];
    carImage = json['car_image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['seller_id'] = sellerId;
    _data['car_image'] = carImage;
    _data['status'] = status;
    return _data;
  }
}

class SellerFuelTypes {
  SellerFuelTypes({
    required this.id,
    required this.sellerId,
    required this.fuelTypeId,
    required this.fuelTypeName,
  });
  late final int id;
  late final int sellerId;
  late final int fuelTypeId;
  late final FuelTypeName fuelTypeName;
  
  SellerFuelTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    sellerId = json['seller_id'];
    fuelTypeId = json['fuel_type_id'];
    fuelTypeName = FuelTypeName.fromJson(json['fuel_type_name']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['seller_id'] = sellerId;
    _data['fuel_type_id'] = fuelTypeId;
    _data['fuel_type_name'] = fuelTypeName.toJson();
    return _data;
  }
}

class FuelTypeName {
  FuelTypeName({
    required this.id,
    required this.name,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int status;
  
  FuelTypeName.fromJson(Map<String, dynamic> json){
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

class Condition {
  Condition({
    required this.id,
    required this.name,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int status;
  
  Condition.fromJson(Map<String, dynamic> json){
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

class CarBrand {
  CarBrand({
    required this.id,
    required this.name,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int status;
  
  CarBrand.fromJson(Map<String, dynamic> json){
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

class Model {
  Model({
    required this.id,
    required this.name,
    required this.carBrand,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int carBrand;
  late final int status;
  
  Model.fromJson(Map<String, dynamic> json){
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

class Bodytype {
  Bodytype({
    required this.id,
    required this.name,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int status;
  
  Bodytype.fromJson(Map<String, dynamic> json){
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

class CarExteriorColor {
  CarExteriorColor({
    required this.id,
    required this.name,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int status;
  
  CarExteriorColor.fromJson(Map<String, dynamic> json){
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

class CarTransmission {
  CarTransmission({
    required this.id,
    required this.name,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int status;
  
  CarTransmission.fromJson(Map<String, dynamic> json){
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