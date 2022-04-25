import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislam_car/http/request.dart';
import 'package:sislam_car/http/url.dart';

import 'package:sislam_car/model/brands_model.dart';
import 'package:sislam_car/model/conditions_model.dart';
import 'package:sislam_car/model/dashboard_cars_model.dart';
import 'package:sislam_car/model/fuel_types_model.dart';
import 'package:sislam_car/model/models_model.dart';
import 'package:sislam_car/utility/syncronize_data.dart';

class HomeController extends GetxController {
  var brandsListData = <Brands>[].obs;
  var conditionsListData = <Conditions>[].obs;
  var modelsListData = <Models>[].obs;
  var fuelTypesListData = <FuelTypes>[].obs;
  var dashboardCarsListData = <DashboardCars>[].obs;
  var filterCarsListData = <DashboardCars>[].obs;
  var brandsLoader = false.obs;
  var conditionsLoader = false.obs;
  var modelsLoader = false.obs;
  var fuelTypesLoader = false.obs;
  var dashboardCarsLoader = false.obs;
  var pages = 1.obs;
  var hasMore = true.obs;
  int perPage = 10;
  @override
  void onInit() {
    // _apiGetModelsList();
    // _apiGetBrandsList();
    // _apiGetConditionsList();
    // _apiGetFuelTypesList();
    apiGetDashboardCarsList();

    super.onInit();
  }

  void apiGetDashboardCarsList() async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(const Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    SyncronizationData.isInternet().then((connection) {
      if (connection) {
        // dashboardCarsListData.clear();
        //   dashboardCarsLoader.value = true;
        var urlDashboardCars = 'get_dashboard_cars?page=' + pages.toString();
        print(urlDashboardCars);
        Request request = Request(url: urlDashboardCars, body: null);

        request.get().then((value) {
          dashboardCarsLoader.value = false;
          print(value.statusCode);
          DashboardCarsData dashboardCarsListModel =
              DashboardCarsData.fromJson(json.decode(value.body));
          print(dashboardCarsListModel);
          if (dashboardCarsListModel.success == 1) {
            dashboardCarsListData.addAll(dashboardCarsListModel.dashboardCars);
            print(dashboardCarsListData.length);
            filterCarsListData.value = dashboardCarsListData;
            pages++;
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

  // onItemChanged(String value) {
  //   final suggetions = dashboardCarsListData
  //       .where((u) => u.carTitle.toLowerCase().contains(value.toLowerCase()))
  //       .toList();
  //   hasMore.value = false;
  //   filterCarsListData.value = suggetions;
  // }
  void apiGetCarsSearchList(searchKeyWord) async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(const Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    SyncronizationData.isInternet().then((connection) {
      if (connection) {
        filterCarsListData.clear();
        dashboardCarsLoader.value = true;
        var urlDashboardCars = 'get_dashboard_car_search';
        print(urlDashboardCars);
        Request request =
            Request(url: urlDashboardCars, body: {'search': searchKeyWord});

        request.post().then((value) {
          dashboardCarsLoader.value = false;
          print(value.statusCode);
          print(json.decode(value.body));
          DashboardCarsData dashboardCarsListModel =
              DashboardCarsData.fromJson(json.decode(value.body));

          if (dashboardCarsListModel.success == 1) {
            filterCarsListData.value = dashboardCarsListModel.dashboardCars;
            print(filterCarsListData.length);
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

  onPriceFilter(minPrice, maxPrice) {
    final suggetions = dashboardCarsListData
        .where((u) => u.price > minPrice && u.price < maxPrice)
        .toList();

    filterCarsListData.value = suggetions;
  }
}
