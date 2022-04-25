import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sislam_car/http/request.dart';
import 'package:sislam_car/http/url.dart';
import 'package:sislam_car/model/brands_model.dart';
import 'package:sislam_car/model/conditions_model.dart';
import 'package:sislam_car/model/district_model.dart';
import 'package:sislam_car/model/fuel_types_model.dart';
import 'package:sislam_car/model/models_model.dart';
import 'package:sislam_car/model/registration_serial_model.dart';
import 'package:sislam_car/model/thana_model.dart';
import 'package:sislam_car/utility/syncronize_data.dart';
import 'package:http/http.dart' as http;

class SellController extends GetxController {
  var action = false.obs;
  var brandsListData = <Brands>[].obs;
  var conditionsListData = <Conditions>[].obs;
  var modelsListData = <Models>[].obs;
  var fuelTypesListData = <FuelTypes>[].obs;
  var registrationSerialListData = <RegistrationSerial>[].obs;

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

  @override
  void onInit() {
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

  void apiGetModelsList(carBrandId) async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(const Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    SyncronizationData.isInternet().then((connection) {
      if (connection) {
        modelsListData.clear();
        modelsLoader.value = true;
        Request request = Request(
            url: urlGetModels, body: {'CarBrand': carBrandId.toString()});
        print(request.body);
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

  void apiGetThanaList(districtId) async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(const Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    SyncronizationData.isInternet().then((connection) {
      if (connection) {
        thanaListData.clear();
        thanaLoader.value = true;
        Request request = Request(
            url: urlGetThana, body: {"DistrictID": districtId.toString()});
        print(request.body);
        request.post().then((value) {
          // ignore: avoid_print
          thanaLoader.value = false;
          print(value.body);
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

  sellSubmit(
      conditionId,
      brandId,
      modelId,
      _manufacturingYear,
      _regYear,
      registrationSerialId,
      districtID,
      thanaId,
      sellCarBrand,
      sellCarModel) async {
    action.value = (true);
    final uri =
        Uri.parse("https://sicapi.sislamcars.com.bd/api/submit_car_seller");

    var request = http.MultipartRequest('POST', uri);
    request.fields['car_title'] = "car Title";

    request.fields['car_condition'] = conditionId.toString();
    request.fields['car_brands'] = brandId.toString();
    request.fields['car_model'] = modelId.toString();
    request.fields['manufacturing_year'] = _manufacturingYear.toString();
    request.fields['registration_year'] = _regYear.toString();
    request.fields['registration_number'] =
        (registrationSerialId.toString() + '-' + regSerialTextController.text)
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
    List<http.MultipartFile> imageList = [];
    // print(image);
    for (var img in image) {
      if (img != "") {
        var multipartFile =
            await http.MultipartFile.fromPath("car_photo[]", File(img).path);
        imageList.add(multipartFile);
      }
    }
    print(imageList);
    // var pic =
    //     await http.MultipartFile.fromPath("car_photo", File(image[0]).path);
    // request.files.add(pic);
    request.files.addAll(imageList);
    print(request.files);
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
              regSerialTextController.clear();
              askingPriceTextController.clear();
              commentsTextController.clear();
              nameTextController.clear();
              emailTextController.clear();
              add1TextController.clear();
              add2TextController.clear();
              mobileTextController.clear();
              Get.back();
              Get.defaultDialog(
                  title: "THANK YOU!",
                  titleStyle: TextStyle(fontWeight: FontWeight.w800),
                  middleText: sellCarBrand +
                      ' ' +
                      sellCarModel +
                      ' ' +
                      _manufacturingYear.toString() +
                      ' we have received your request and will respond soon.\nYou can call us to +8801712282178',
                  middleTextStyle:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                  textCancel: 'Close');
            } else {
              Get.snackbar('Submited', 'not submitted',
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
          content: Center(child: Text('No Internet')),
          barrierDismissible: true);
    });
  }
}
