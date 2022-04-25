import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sislam_car/controller/exchange_controller.dart';
import 'package:sislam_car/controller/search_controller.dart';
import 'package:sislam_car/http/url.dart';
import 'package:sislam_car/res/colors.dart';
import 'package:sislam_car/utility/bottom_nav_bar.dart';
import 'package:sislam_car/utility/drawer_view.dart';

class ExchangeSearchView extends StatefulWidget {
  const ExchangeSearchView({Key? key}) : super(key: key);

  @override
  State<ExchangeSearchView> createState() => _ExchangeSearchViewState();
}

class Debouncer {
  late int milliseconds;
  late VoidCallback? action;
  Timer? _timer;
  Debouncer({required this.milliseconds});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _ExchangeSearchViewState extends State<ExchangeSearchView> {
  final SearchController searchController = Get.put(SearchController());
  final _debouncer = Debouncer(milliseconds: 200);
  var conditionId = Get.arguments[0];
  var brandId = Get.arguments[1];
  var modelId = Get.arguments[2];
  var manufacturingYear = Get.arguments[3];
  var regYear = Get.arguments[4];
  var registrationSerialName = Get.arguments[5];
  var districtId = Get.arguments[6];
  var thanaId = Get.arguments[7];
  final getdata = GetStorage();
  final scrollControllerBuyCar = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 3,
            title: Text('Exchange Car', style: TextStyle(fontSize: 16)),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ))),
        endDrawer: DrawerView(),
        body: Column(
          children: [
            SizedBox(height: 10),
            SizedBox(
                height: 30,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    color: Colors.grey.shade200,
                    //width: Get.width - 50,
                    child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(top: 0, bottom: 16, left: 4),
                            hintText: 'Search by  brand or model',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 13),
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                              //size: 40,
                            )),
                        onChanged: (v) {
                          if (v.length > 2) {
                            _debouncer.run(() {
                              searchController.apiGetCarsSearchList(v);
                            });
                          } else {
                            searchController.dashboardBuyCarsListData.clear();
                          }
                        }),
                  ),
                )),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Obx(
                () => (searchController.dashboardCarsLoader.value == true)
                    ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 0.5,
                          color: Colors.red,
                        ),
                      )
                    : ListView.builder(
                        controller: scrollControllerBuyCar,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        // primary: true,
                        itemCount:
                            searchController.dashboardBuyCarsListData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    const SizedBox(height: 210),
                                    (searchController
                                            .dashboardBuyCarsListData[index]
                                            .carImages
                                            .isNotEmpty)
                                        ? SizedBox(
                                            height: 200,
                                            width: double.infinity,
                                            child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  ('assets/img/loading.gif'),
                                              image: searchController
                                                  .dashboardBuyCarsListData[
                                                      index]
                                                  .carImages[0]
                                                  .carImage,
                                              fit: BoxFit.fill,
                                            ))
                                        : Container(),
                                    Positioned(
                                        bottom: -5,
                                        left: 0,
                                        right: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      padding: EdgeInsets.zero),
                                                  onPressed: (searchController
                                                              .dashboardBuyCarsListData[
                                                                  index]
                                                              .status ==
                                                          2)
                                                      ? null
                                                      : () {
                                                          getdata.write(
                                                              'carImage',
                                                              searchController
                                                                  .dashboardBuyCarsListData[
                                                                      index]
                                                                  .carImages[0]
                                                                  .carImage);
                                                          getdata.write(
                                                              'registrationSerialName',
                                                              registrationSerialName);
                                                          Get.toNamed(
                                                              'exchangeCarDetailsView',
                                                              arguments: [
                                                                searchController
                                                                    .dashboardBuyCarsListData[
                                                                        index]
                                                                    .id,
                                                                conditionId,
                                                                brandId,
                                                                modelId,
                                                                manufacturingYear,
                                                                regYear,
                                                                districtId,
                                                                thanaId
                                                              ]);
                                                        },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                        color: (searchController
                                                                    .dashboardBuyCarsListData[
                                                                        index]
                                                                    .status ==
                                                                2)
                                                            ? Colors.red
                                                            : Color(0xFFc1912f),
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Center(
                                                      child: (searchController
                                                                  .dashboardBuyCarsListData[
                                                                      index]
                                                                  .status ==
                                                              2)
                                                          ? Text(
                                                              'Sold Out',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : Text(
                                                              'Exchange Now',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                    ),
                                                  )),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff0a172a),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Center(
                                                  child: Text(
                                                    'Tk. ' +
                                                        searchController
                                                            .dashboardBuyCarsListData[
                                                                index]
                                                            .price
                                                            .toString() +
                                                        '.00',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  searchController
                                      .dashboardBuyCarsListData[index].carTitle,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ImageIcon(
                                      AssetImage("assets/img/road.png"),
                                      color: Color(0xFFc1912f),
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      searchController
                                              .dashboardBuyCarsListData[index]
                                              .milage! +
                                          ' km',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Spacer(),
                                    ImageIcon(
                                      AssetImage("assets/img/gear.png"),
                                      color: Color(0xFFc1912f),
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                        searchController
                                            .dashboardBuyCarsListData[index]
                                            .carTransmission
                                            .name,
                                        style: TextStyle(fontSize: 12)),
                                    Spacer(),
                                    ImageIcon(
                                      AssetImage("assets/img/calendar.png"),
                                      color: Color(0xFFc1912f),
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                        searchController
                                            .dashboardBuyCarsListData[index]
                                            .menufacturingYear
                                            .toString(),
                                        style: TextStyle(fontSize: 12)),
                                    Spacer(),
                                    ImageIcon(
                                      AssetImage("assets/img/car-colours.png"),
                                      color: Color(0xFFc1912f),
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                        searchController
                                            .dashboardBuyCarsListData[index]
                                            .carExteriorColor
                                            .name,
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ImageIcon(
                                      AssetImage("assets/img/car-body.png"),
                                      color: Color(0xFFc1912f),
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    // Text(
                                    //     searchController
                                    //         .dashboardBuyCarsListData[index]
                                    //         .bodytype
                                    //         .name,
                                    //     style: TextStyle(fontSize: 12)),
                                    Spacer(),
                                    ImageIcon(
                                      AssetImage(
                                          "assets/img/car-engine-cc.png"),
                                      color: Color(0xFFc1912f),
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                        searchController
                                                .dashboardBuyCarsListData[index]
                                                .engineCapacity +
                                            ' CC',
                                        style: TextStyle(fontSize: 12)),
                                    Spacer(),
                                    ImageIcon(
                                      AssetImage("assets/img/fuel.png"),
                                      color: Color(0xFFc1912f),
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                        searchController
                                            .dashboardBuyCarsListData[index]
                                            .fuelType,
                                        style: TextStyle(fontSize: 12)),
                                    Spacer(),
                                    ImageIcon(
                                      AssetImage("assets/img/4wd-drive.png"),
                                      color: Color(0xFFc1912f),
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    // Text(
                                    //     searchController
                                    //         .dashboardBuyCarsListData[index]
                                    //         .driveType
                                    //         .name,
                                    //     style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero),
                                    onPressed: () {
                                      getdata.write(
                                          'carImage',
                                          searchController
                                              .dashboardBuyCarsListData[index]
                                              .carImages[0]
                                              .carImage);
                                      getdata.write('registrationSerialName',
                                          registrationSerialName);
                                      Get.toNamed('exchangeCarDetailsView',
                                          arguments: [
                                            searchController
                                                .dashboardBuyCarsListData[index]
                                                .id,
                                            conditionId,
                                            brandId,
                                            modelId,
                                            manufacturingYear,
                                            regYear,
                                            districtId,
                                            thanaId
                                          ]);
                                    },
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.all(4),
                                      width: double.infinity,
                                      color: const Color(0xFFc1912f),
                                      child: const Center(
                                          child: Text(
                                        'DETAILS ',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white),
                                      )),
                                    ))
                              ],
                            ),
                          );
                        }),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBarView());
  }
}
