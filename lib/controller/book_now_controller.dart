import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislam_car/http/request.dart';
import 'package:sislam_car/http/url.dart';
import 'package:sislam_car/model/district_model.dart';
import 'package:sislam_car/model/thana_model.dart';
import 'package:sislam_car/utility/syncronize_data.dart';

class BookNowController extends GetxController {
  var action = false.obs;
  var districtListData = <District>[].obs;
  var districtLoader = false.obs;
  var thanaListData = <Thana>[].obs;
  var thanaLoader = false.obs;
  late TextEditingController nameTextController;
  late TextEditingController emailTextController;
  late TextEditingController mobileTextController;
  late TextEditingController add1TextController;
  late TextEditingController add2TextController;
  @override
  void onInit() {
    super.onInit();
    _apiGetDistrictList();

    nameTextController = TextEditingController();
    emailTextController = TextEditingController();
    mobileTextController = TextEditingController();
    add1TextController = TextEditingController();
    add2TextController = TextEditingController();
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
        thanaLoader.value = true;
        Request request = Request(
            url: urlGetThana, body: {'DistrictID': districtId.toString()});

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

  bookNowSubmit(carId, carName, districtId, thanaId) {
    action(true);
    Request request = Request(url: urlSubmitCarBuyer, body: {
      'CarID': carId.toString(),
      'name': nameTextController.text,
      'email': emailTextController.text,
      'thana': thanaId.toString(),
      'district': districtId.toString(),
      'address_line1': add1TextController.text,
      'address_line2': add2TextController.text,
      'mobile': mobileTextController.text
    });
    print(request.body);
    request.post().then((value) {
      var result = json.decode(value.body);
      // ignore: avoid_print
      print(result);
      if (result['success'] == 1) {
        action(false);
        nameTextController.clear();
        mobileTextController.clear();
        emailTextController.clear();
        add1TextController.clear();
        add2TextController.clear();

        Get.toNamed('homeView');
        // Get.snackbar('MSG', result['message'],
        //     snackPosition: SnackPosition.BOTTOM);
        Get.defaultDialog(
            title: "THANK YOU!",
            titleStyle: TextStyle(fontWeight: FontWeight.w800),
            middleText: carName +
                ' has been successfully booked  and we will be contacting you shortly.\nYou can call us to +8801712282178',
            middleTextStyle:
                TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
            textCancel: 'Close');
      } else {
        action(false);

        Get.snackbar('MSG', result['message'],
            colorText: Colors.green,
            backgroundColor: const Color(0xFF252525),
            snackPosition: SnackPosition.BOTTOM);
      }
    }).catchError((onError) {
      action(false);
      // ignore: avoid_print
      print("Error == $onError");
      Get.defaultDialog(
          title: 'Warning',
          content: const Center(
              child: Text('Warning \n something went wrong in server!!!')),
          barrierDismissible: true);
    });
  }
}
