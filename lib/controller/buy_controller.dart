import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislam_car/http/request.dart';
import 'package:sislam_car/http/url.dart';
import 'package:sislam_car/model/buy_cars_model.dart';
import 'package:sislam_car/utility/syncronize_data.dart';

class BuyController extends GetxController {
  var dashboardBuyCarsListData = <BuyCars>[].obs;
  var filterBuyCarsListData = <BuyCars>[].obs;
  var brandsLoader = false.obs;
  var conditionsLoader = false.obs;
  var modelsLoader = false.obs;
  var fuelTypesLoader = false.obs;
  var dashboardCarsLoader = false.obs;
  var pagesBuyCar = 1.obs;
  var hasMore = true.obs;
  int perPage =10;
  @override
  void onInit() {
    filterBuyCarsListData.clear();
    dashboardBuyCarsListData.clear();
    apiGetBuyCarsList();

    super.onInit();
  }

  void apiGetBuyCarsList() async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(const Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    SyncronizationData.isInternet().then((connection) {
      if (connection) {
    
       // filterCarsListData.clear();
        //dashboardCarsLoader.value = true;
         var urlDashboardCars = 'get_dashboard_cars?page='+pagesBuyCar.toString();
         print(urlDashboardCars);
        Request request = Request(url: urlDashboardCars, body: null);

        request.get().then((value) {
          dashboardCarsLoader.value = false;
          print(value.statusCode);
          BuyCarsData dashboardCarsListModel =
              BuyCarsData.fromJson(json.decode(value.body));
          if (dashboardCarsListModel.success == 1) {
            dashboardBuyCarsListData.addAll(dashboardCarsListModel.dashboardCars);
            print(dashboardBuyCarsListData.length);
            filterBuyCarsListData.value = dashboardBuyCarsListData;
            pagesBuyCar++;
            print(filterBuyCarsListData.length);
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

  onItemChanged(String value) {
    final suggetions = dashboardBuyCarsListData
        .where((u) => u.carTitle.toLowerCase().contains(value.toLowerCase()))
        .toList();
 hasMore.value = false;
    filterBuyCarsListData.value = suggetions;
  }
}
