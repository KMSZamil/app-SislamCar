import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislam_car/http/request.dart';
import 'package:sislam_car/http/url.dart';
import 'package:sislam_car/model/car_details_model.dart';
import 'package:sislam_car/utility/syncronize_data.dart';

class CarDetailsController extends GetxController {
  var id = Get.arguments[0];
  var carDetailsListData = <CarDetails>[].obs;
  var carDetailsLoader = false.obs;
  var videoId=''.obs;

  @override
  void onInit() {
 //   apiGetCarDetailsList();
    super.onInit();
  }

  void apiGetCarDetailsList(id) async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(const Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    print(id);
    SyncronizationData.isInternet().then((connection) {
      if (connection) {
        carDetailsLoader.value = true;
        carDetailsListData.clear();
        videoId.value='';
        Request request = Request(
            
            url: urlGetDashboardCarSelected, body: {'id': id.toString()});

        request.post().then((value) {
          carDetailsLoader.value = false;
          print(value.statusCode);
          var result =json.decode(value.body);
          CarDetailsData carDetailsListModel =
              CarDetailsData.fromJson(result);
          if (carDetailsListModel.success == 1) {
            carDetailsListData.value = carDetailsListModel.carDetails;
            videoId.value=result['video_id'];
            print(carDetailsListData.length);

          } else {
            Get.snackbar("msg", 'no data found',
                snackPosition: SnackPosition.BOTTOM);
          }

          // Get.back();
        }).catchError((onError) {
          carDetailsLoader.value = false;
          // ignore: avoid_print
          print(onError);
        });
      } else {
        Get.snackbar('!opps', '"No Internet"',
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      }
    });
  }
}
