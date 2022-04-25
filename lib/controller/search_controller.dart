import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislam_car/http/request.dart';
import 'package:sislam_car/model/search_model.dart';
import 'package:sislam_car/utility/syncronize_data.dart';

class SearchController extends GetxController {
  var dashboardBuyCarsListData = <SearchData>[].obs;
  var filterBuyCarsListData = <SearchData>[].obs;
  var brandsLoader = false.obs;
  var conditionsLoader = false.obs;
  var modelsLoader = false.obs;
  var fuelTypesLoader = false.obs;
  var dashboardCarsLoader = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void apiGetCarsSearchList(searchKeyWord) async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(const Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    SyncronizationData.isInternet().then((connection) {
      if (connection) {
        dashboardBuyCarsListData.clear();
        dashboardCarsLoader.value = true;
        var urlDashboardCars = 'get_dashboard_car_search';
        print(urlDashboardCars);
        Request request =
            Request(url: urlDashboardCars, body: {'search': searchKeyWord});

        request.post().then((value) {
          dashboardCarsLoader.value = false;
          print(value.statusCode);
          print(json.decode(value.body));
          CarSearchData dashboardCarsListModel =
              CarSearchData.fromJson(json.decode(value.body));

          if (dashboardCarsListModel.success == 1) {
            dashboardBuyCarsListData.value =
                dashboardCarsListModel.dashboardCars;
            print(dashboardBuyCarsListData.length);
            filterBuyCarsListData.value = dashboardBuyCarsListData;
          } else {
            Get.snackbar("msg", 'no data found',
                snackPosition: SnackPosition.BOTTOM);
          }

          // Get.back();
        }).catchError((onError) {
          dashboardCarsLoader.value = false;
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
