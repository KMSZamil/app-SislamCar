import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sislam_car/http/request.dart';
import 'package:sislam_car/http/url.dart';
import 'package:sislam_car/model/brands_model.dart';
import 'package:sislam_car/model/conditions_model.dart';
import 'package:sislam_car/model/dashboard_cars_model.dart';
import 'package:sislam_car/model/district_model.dart';
import 'package:sislam_car/model/fuel_types_model.dart';
import 'package:sislam_car/model/models_model.dart';
import 'package:sislam_car/model/registration_serial_model.dart';
import 'package:sislam_car/model/thana_model.dart';
import 'package:sislam_car/utility/syncronize_data.dart';
import 'package:http/http.dart' as http;

class ExchangeController extends GetxController {
  var exchangeCarsListData = <DashboardCars>[].obs;
  var filterCarsListData = <DashboardCars>[].obs;
  var exchangeCarsLoader = false.obs;
  var action = false.obs;
  var brandsListData = <Brands>[].obs;
  var conditionsListData = <Conditions>[].obs;
  var modelsListData = <Models>[].obs;
  var fuelTypesListData = <FuelTypes>[].obs;
  var registrationSerialListData = <RegistrationSerial>[].obs;
  final getdata = GetStorage();
  var brandsLoader = false.obs;
  var conditionsLoader = false.obs;
  var modelsLoader = false.obs;
  var fuelTypesLoader = false.obs;
  var registrationSerialLoader = false.obs;
  var districtListData = <District>[].obs;
  var districtLoader = false.obs;
  var thanaListData = <Thana>[].obs;
  var thanaLoader = false.obs;
  late TextEditingController titleTextController;
  late TextEditingController nameTextController;
  late TextEditingController emailTextController;
  late TextEditingController mobileTextController;
  late TextEditingController add1TextController;
  late TextEditingController add2TextController;
  late TextEditingController regSerialTextController;
  late TextEditingController askingPriceTextController;
  late TextEditingController commentsTextController;
  var pagesBuyCar = 1.obs;
  var hasMore = true.obs;
  int perPage =10;
  @override
  void onInit() {
    apiGetExchangeCarsList();

    _apiGetBrandsList();
    _apiGetConditionsList();
    _apiGetFuelTypesList();
    _apiGetRegistrationSerialList();
    _apiGetDistrictList();

    titleTextController = TextEditingController();
    nameTextController = TextEditingController();
    emailTextController = TextEditingController();
    mobileTextController = TextEditingController();
    add1TextController = TextEditingController();
    add2TextController = TextEditingController();
    regSerialTextController = TextEditingController();
    askingPriceTextController = TextEditingController();
    commentsTextController = TextEditingController();
    super.onInit();
  }

  void apiGetExchangeCarsList() async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(const Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    SyncronizationData.isInternet().then((connection) {
      if (connection) {
        //exchangeCarsListData.clear();
       // exchangeCarsLoader.value = true;
        var urlDashboardCars = 'get_dashboard_cars?page='+pagesBuyCar.toString();
         print(urlDashboardCars);
        Request request = Request(url: urlDashboardCars, body: null);

        request.get().then((value) {
          exchangeCarsLoader.value = false;
          print(value.statusCode);
          DashboardCarsData dashboardCarsListModel =
              DashboardCarsData.fromJson(json.decode(value.body));
          if (dashboardCarsListModel.success == 1) {
            exchangeCarsListData.addAll(dashboardCarsListModel.dashboardCars);
            print(exchangeCarsListData.length);
            filterCarsListData.value = exchangeCarsListData;
             pagesBuyCar++;
            print(filterCarsListData.length);
            if (dashboardCarsListModel.dashboardCars.length < perPage) {
              hasMore.value = false;
            } else {
              hasMore.value = true;
            }
          } else {
            Get.snackbar("msg", 'no data found',
                snackPosition: SnackPosition.BOTTOM);
          }

          // Get.back();
        }).catchError((onError) {
          exchangeCarsLoader.value = false;
          // ignore: avoid_print
          print(onError);
        });
      } else {
        Get.snackbar('!opps', '"No Internet"',
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      }
    });
  }

  onItemChanged(String value) {
    final suggetions = exchangeCarsListData
        .where((u) => u.carTitle.toLowerCase().contains(value.toLowerCase()))
        .toList();
hasMore.value = false;
    filterCarsListData.value = suggetions;
  }

  void _apiGetBrandsList() async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(const Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    SyncronizationData.isInternet().then((connection) {
      if (connection) {
        brandsLoader.value = true;
        Request request = Request(url: urlGetBrands, body: null);

        request.get().then((value) {
          // ignore: avoid_print
          brandsLoader.value = false;
          print(value.statusCode);
          BrandsList brandsListModel =
              BrandsList.fromJson(json.decode(value.body));
          if (brandsListModel.success == 1) {
            brandsListData.value = brandsListModel.brands;
          } else {
            Get.snackbar("msg", 'no data found',
                snackPosition: SnackPosition.BOTTOM);
          }

          // Get.back();
        }).catchError((onError) {
          brandsLoader.value = false;
          // ignore: avoid_print
          print(onError);
        });
      } else {
        Get.snackbar('!opps', '"No Internet"',
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      }
    });
  }

  void _apiGetConditionsList() async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(const Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    SyncronizationData.isInternet().then((connection) {
      if (connection) {
        conditionsLoader.value = true;
        Request request = Request(url: urlGetConditions, body: null);

        request.get().then((value) {
          conditionsLoader.value = false;
          print(value.statusCode);
          ConditionsList consditionsListModel =
              ConditionsList.fromJson(json.decode(value.body));
          if (consditionsListModel.success == 1) {
            conditionsListData.value = consditionsListModel.conditions;
          } else {
            Get.snackbar("msg", 'no data found',
                snackPosition: SnackPosition.BOTTOM);
          }

          // Get.back();
        }).catchError((onError) {
          conditionsLoader.value = false;
          // ignore: avoid_print
          print(onError);
        });
      } else {
        Get.snackbar('!opps', '"No Internet"',
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      }
    });
  }

  void apiGetModelsList(CarBrandId) async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(const Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    SyncronizationData.isInternet().then((connection) {
      if (connection) {
        modelsListData.clear();
        modelsLoader.value = true;
        Request request = Request(
            url: urlGetModels, body: {'CarBrand': CarBrandId.toString()});

        request.post().then((value) {
          modelsLoader.value = false;
          print(value.statusCode);
          ModelsList modelsListModel =
              ModelsList.fromJson(json.decode(value.body));
          if (modelsListModel.success == 1) {
            modelsListData.value = modelsListModel.models;
          } else {
            Get.snackbar("msg", 'no data found',
                snackPosition: SnackPosition.BOTTOM);
          }

          // Get.back();
        }).catchError((onError) {
          modelsLoader.value = false;
          // ignore: avoid_print
          print(onError);
        });
      } else {
        Get.snackbar('!opps', '"No Internet"',
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      }
    });
  }

  void _apiGetFuelTypesList() async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(const Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    SyncronizationData.isInternet().then((connection) {
      if (connection) {
        fuelTypesLoader.value = true;
        Request request = Request(url: urlGetFuelTypes, body: null);

        request.get().then((value) {
          fuelTypesLoader.value = false;
          print(value.statusCode);
          FuelTypesList fuelTypessListModel =
              FuelTypesList.fromJson(json.decode(value.body));
          if (fuelTypessListModel.success == 1) {
            fuelTypesListData.value = fuelTypessListModel.fuelTypes;
          } else {
            Get.snackbar("msg", 'no data found',
                snackPosition: SnackPosition.BOTTOM);
          }

          // Get.back();
        }).catchError((onError) {
          fuelTypesLoader.value = false;
          // ignore: avoid_print
          print(onError);
        });
      } else {
        Get.snackbar('!opps', '"No Internet"',
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      }
    });
  }

  void _apiGetDistrictList() async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(const Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    SyncronizationData.isInternet().then((connection) {
      if (connection) {
        districtLoader.value = true;
        Request request = Request(url: urlGetDistrict, body: null);

        request.get().then((value) {
          // ignore: avoid_print
          districtLoader.value = false;
          print(value.statusCode);
          DistrictData districsListModel =
              DistrictData.fromJson(json.decode(value.body));
          if (districsListModel.success == 1) {
            districtListData.value = districsListModel.district;
          } else {
            Get.snackbar("msg", 'no data found',
                snackPosition: SnackPosition.BOTTOM);
          }

          // Get.back();
        }).catchError((onError) {
          districtLoader.value = false;
          // ignore: avoid_print
          print(onError);
        });
      } else {
        Get.snackbar('!opps', '"No Internet"',
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      }
    });
  }

  void apiGetThanaList(disrictId) async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(const Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    SyncronizationData.isInternet().then((connection) {
      if (connection) {
        thanaLoader.value = true;
        Request request = Request(
            url: urlGetThana, body: {"DistrictID": disrictId.toString()});
        print(request.body);
        request.post().then((value) {
          // ignore: avoid_print
          thanaLoader.value = false;
          print(value.statusCode);
          ThanaData thanasListModel =
              ThanaData.fromJson(json.decode(value.body));
          if (thanasListModel.success == 1) {
            thanaListData.value = thanasListModel.thana;
          } else {
            Get.snackbar("msg", 'no data found',
                snackPosition: SnackPosition.BOTTOM);
          }

          // Get.back();
        }).catchError((onError) {
          thanaLoader.value = false;
          // ignore: avoid_print
          print(onError);
        });
      } else {
        Get.snackbar('!opps', '"No Internet"',
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      }
    });
  }

  void _apiGetRegistrationSerialList() async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(const Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    SyncronizationData.isInternet().then((connection) {
      if (connection) {
        registrationSerialLoader.value = true;
        Request request = Request(url: urlGetRegistrationSerial, body: null);

        request.get().then((value) {
          registrationSerialLoader.value = false;
          print(value.statusCode);
          RegistrationSerialData regSerialListModel =
              RegistrationSerialData.fromJson(json.decode(value.body));
          if (regSerialListModel.success == 1) {
            registrationSerialListData.value =
                regSerialListModel.registrationSerial;
          } else {
            Get.snackbar("msg", 'no data found',
                snackPosition: SnackPosition.BOTTOM);
          }

          // Get.back();
        }).catchError((onError) {
          registrationSerialLoader.value = false;
          // ignore: avoid_print
          print(onError);
        });
      } else {
        Get.snackbar('!opps', '"No Internet"',
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      }
    });
  }

  var image = [].obs;
  final picker = ImagePicker();
  var selectImagePath = ''.obs;
  var selectIamgeSize = ''.obs;

  Future getImage1() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 85);
    if (pickedFile != null) {
      selectImagePath.value = pickedFile.path;
      selectIamgeSize.value =
          ((File(selectImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              "Mb";
    } else {
      Get.snackbar('Error', "No Image Selected",
          snackPosition: SnackPosition.BOTTOM);
    }
    image.add(pickedFile!.path);

    print(image);
  }

  EexchangeSubmit(conditionId, brandId, modelId, _manufacturingYear, _regYear,
      registrationLetter, districtID, thanaId, showroomCarID) async {
    action.value = (true);
    final uri =
        Uri.parse("https://sicapi.sislamcars.com.bd/api/submit_car_exchange");

    var request = http.MultipartRequest('POST', uri);
    request.fields['car_title'] = 'car title';
    request.fields['car_condition'] = conditionId.toString();
    request.fields['car_brands'] = brandId.toString();
    request.fields['car_model'] = modelId.toString();
    request.fields['manufacturing_year'] = _manufacturingYear.toString();
    request.fields['registration_year'] = _regYear.toString();
    request.fields['registration_number'] =
        (registrationLetter.toString() + '-' + regSerialTextController.text)
            .toString();
    request.fields['asking_price'] = askingPriceTextController.text.toString();
    request.fields['comments'] = commentsTextController.text.toString();
    request.fields['name'] = nameTextController.text.toString();
    request.fields['email'] = emailTextController.text.toString();
    request.fields['thana'] = thanaId.toString();
    request.fields['district'] = districtID.toString();
    request.fields['address_line1'] = add1TextController.text.toString();
    request.fields['address_line2'] = add2TextController.text.toString();
    request.fields['mobile'] = mobileTextController.text.toString();
    request.fields['ShowroomCarID'] = showroomCarID.toString();
    List<http.MultipartFile> imageList = [];
    print(image);
    for (var img in image) {
      if (img != "") {
        var multipartFile =
            await http.MultipartFile.fromPath("car_photo[]", File(img).path);
        imageList.add(multipartFile);
      }
    }
    print(imageList);
    // var pic =
    //     await http.MultipartFile.fromPath("car_photo", image.value);

    request.files.addAll(imageList);
    print(request.fields);
    // var response = await request.send();

    // if (response.statusCode == 200) {
    //   print(response);
    //   print('Image Uploaded');
    // } else {
    //   print('Image Not Uploaded');
    // }

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        action.value = (false);
        print(response.body);
        if (response.statusCode == 200) {
          // print("Uploaded! ");

          var result = json.decode(response.body);
          print(result['success']);
          if (result?.isNotEmpty ?? true) {
            if (result['success'] == 1) {
              image.clear();
              titleTextController.clear();
              nameTextController.clear();
              emailTextController.clear();
              mobileTextController.clear();
              add1TextController.clear();
              add2TextController.clear();
              regSerialTextController.clear();
              askingPriceTextController.clear();
              commentsTextController.clear();
              Get.toNamed('homeView');
              // Get.snackbar('Submited', result['message'],
              //     snackPosition: SnackPosition.BOTTOM);
              Get.defaultDialog(
                  title: "THANK YOU!",
                  titleStyle: TextStyle(fontWeight: FontWeight.w800),
                  middleText: getdata.read('exchangeCarBrand') +
                      ' ' +
                      getdata.read('exchangeCarModel') +
                      ' ' +
                      _manufacturingYear.toString() +
                      ' we have received your request and will respond soon.\nYou can call us to +8801712282178',
                  middleTextStyle:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                  textCancel: 'Close');
            } else {
              Get.snackbar('Submited', 'UnSuceessfull',
                  snackPosition: SnackPosition.BOTTOM);
            }
          }
        }

        // return response.body;
      });
    }).catchError((onError) {
      print(onError);
      action.value = (false);
      print("Error == $onError");
      Get.defaultDialog(
          title: 'Error',
          content: Center(child: Text(onError)),
          barrierDismissible: true);
    });
  }
}
