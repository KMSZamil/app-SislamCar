import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislam_cars_app/controller/home_controller.dart';
import 'package:sislam_cars_app/model/brands_model.dart';
import 'package:sislam_cars_app/model/conditions_model.dart';
import 'package:sislam_cars_app/model/fuel_types_model.dart';
import 'package:sislam_cars_app/model/models_model.dart';
import 'package:sislam_cars_app/utility/bottom_nav_bar.dart';
import 'package:sislam_cars_app/utility/drawer_view.dart';
import 'package:sislam_cars_app/view/buy/buy_view.dart';
import 'package:sislam_cars_app/view/data/tabbar_data.dart';
import 'package:sislam_cars_app/view/exchange/exchange_view.dart';
import 'package:sislam_cars_app/view/sell/sell_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
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

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = Get.put(HomeController());
  double _lowerValue = 0.0;
  double _upperValue = 100000;
  Brands? brandValue = null;
  Conditions? conditionValue = null;
  Models? modelValue = null;
  FuelTypes? fuelTypeValue = null;
  int selectIndex = 1;

  final controller = PageController(initialPage: 1);
  final _debouncer = Debouncer(milliseconds: 200);
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        print('hello');
        homeController.apiGetDashboardCarsList();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    controller.dispose();
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Do you want to exit?"),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            //  print('yes selected');
                            exit(0);
                          },
                          child: const Text("Yes"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red.shade800),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          //  print('no selected');
                          Navigator.of(context).pop();
                        },
                        child: const Text("No",
                            style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 3,
              title: const SizedBox(
                height: 50,
                child: Image(
                  image: AssetImage('assets/img/sillogo.png'),
                ),
              )),
          endDrawer: DrawerView(),
          body: SingleChildScrollView(
            controller: scrollController,
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 55,
                    width: double.infinity,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: TabbarData.tabbarData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectIndex = index;
                                });
                                print(selectIndex);
                                if (index == 0) {
                                  controller.animateToPage(0,
                                      duration:
                                          const Duration(microseconds: 500),
                                      curve: Curves.easeInOut);
                                } else if (index == 1) {
                                  controller.animateToPage(1,
                                      duration:
                                          const Duration(microseconds: 500),
                                      curve: Curves.easeInOut);
                                } else {
                                  controller.animateToPage(2,
                                      duration:
                                          const Duration(microseconds: 500),
                                      curve: Curves.easeInOut);
                                }
                              },
                              child: Container(
                                width: 110,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: (selectIndex == index)
                                        ? const Border(
                                            top: BorderSide(
                                              //                    <--- top side
                                              color: Color(0xFFbe8f30),
                                              width: 3.0,
                                            ),
                                            left: BorderSide(
                                              //                    <--- top side
                                              color: Color(0xFFbe8f30),
                                              width: 3.0,
                                            ),
                                            right: BorderSide(
                                              //                    <--- top side
                                              color: Color(0xFFbe8f30),
                                              width: 3.0,
                                            ))
                                        : const Border(
                                            bottom: BorderSide(
                                              //                    <--- top side
                                              color: Color(0xFFbe8f30),
                                              width: 3.0,
                                            ),
                                          )),
                                child: Column(
                                  children: [
                                    Icon(
                                      TabbarData.tabbarData[index].img,
                                      size: 13,
                                    ),
                                    Text(TabbarData.tabbarData[index].name)
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 112,
                    child: PageView(
                        controller: controller,
                        physics: const BouncingScrollPhysics(),
                        children: [BuyView(), SellView(), ExchangeView()]),
                  ),
                  SizedBox(
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Container(
                          color: Colors.grey.shade200,
                          //width: Get.width - 50,
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 16, left: 4),
                                hintText: 'Search by  brand or model',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                  //size: 40,
                                )),
                            // onChanged: (v) {
                            //   if (v.length > 2) {
                            //     _debouncer.run(() {
                            //       homeController.apiGetCarsSearchList(v);
                            //     });
                            //   } else {
                            //     homeController.filterCarsListData =
                            //         homeController.dashboardCarsListData;
                            //   }
                            // }
                            onTap: () {
                              Get.toNamed('searchView');
                            },
                          ),
                        ),
                      )),

                  // RangeSliderFlutter(
                  //   // key: Key('3343'),
                  //   values: [_lowerValue, _upperValue],
                  //   rangeSlider: true,
                  //   tooltip: RangeSliderFlutterTooltip(
                  //     alwaysShowTooltip: true,
                  //   ),
                  //   max: 8000000,
                  //   textPositionTop: -40,
                  //   handlerHeight: 20,
                  //   trackBar: RangeSliderFlutterTrackBar(
                  //     activeTrackBarHeight: 3,
                  //     inactiveTrackBarHeight: 3,
                  //     activeTrackBar: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: Colors.black12,
                  //     ),
                  //     inactiveTrackBar: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: const Color(0xFFc1912f),
                  //     ),
                  //   ),

                  //   min: 0,
                  //   fontSize: 12,
                  //   textBackgroundColor: Colors.black12,
                  //   onDragging: (handlerIndex, lowerValue, upperValue) {
                  //     _lowerValue = lowerValue;
                  //     _upperValue = upperValue;
                  //     setState(() {});
                  //   },
                  // ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(
                    () => (homeController.filterCarsListData.isEmpty)
                        ? Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 0.5,
                              color: Colors.red,
                            ),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            // primary: true,
                            itemCount:
                                homeController.filterCarsListData.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index <
                                  homeController.filterCarsListData.length) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        const SizedBox(height: 220),
                                        (homeController
                                                .filterCarsListData[index]
                                                .carImages
                                                .isEmpty)
                                            ? Container()
                                            : SizedBox(
                                                height: 200,
                                                width: double.infinity,
                                                child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      ('assets/img/loading.gif'),
                                                  image: homeController
                                                      .filterCarsListData[index]
                                                      .carImages[0]
                                                      .carImage,
                                                  fit: BoxFit.fill,
                                                )),
                                        Positioned(
                                            bottom: -5,
                                            left: 0,
                                            right: 0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero),
                                                      onPressed: (homeController
                                                                  .filterCarsListData[
                                                                      index]
                                                                  .status ==
                                                              2)
                                                          ? null
                                                          : () {
                                                              Get.toNamed(
                                                                  'bookNowView',
                                                                  arguments: [
                                                                    homeController
                                                                        .filterCarsListData[
                                                                            index]
                                                                        .id,
                                                                    homeController
                                                                        .filterCarsListData[
                                                                            index]
                                                                        .carTitle,
                                                                    homeController
                                                                        .filterCarsListData[
                                                                            index]
                                                                        .carImages[
                                                                            0]
                                                                        .carImage
                                                                  ]);
                                                            },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration: BoxDecoration(
                                                            color: (homeController
                                                                        .filterCarsListData[
                                                                            index]
                                                                        .status ==
                                                                    2)
                                                                ? Colors.red
                                                                : const Color(
                                                                    0xff0a172a),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: Center(
                                                          child: (homeController
                                                                      .filterCarsListData[
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
                                                                  'Book Now',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                        ),
                                                      )),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xff0a172a),
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Center(
                                                      child: Text(
                                                        'Tk. ' +
                                                            homeController
                                                                .filterCarsListData[
                                                                    index]
                                                                .price
                                                                .toString() +
                                                            '.00',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                                      homeController
                                          .filterCarsListData[index].carTitle,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                          homeController
                                                  .filterCarsListData[index]
                                                  .milage +
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
                                            homeController
                                                .filterCarsListData[index]
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
                                            homeController
                                                .filterCarsListData[index]
                                                .menufacturingYear
                                                .toString(),
                                            style: TextStyle(fontSize: 12)),
                                        Spacer(),
                                        ImageIcon(
                                          AssetImage(
                                              "assets/img/car-colours.png"),
                                          color: Color(0xFFc1912f),
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                            homeController
                                                .filterCarsListData[index]
                                                .carExteriorColor
                                                .name,
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ImageIcon(
                                          AssetImage("assets/img/car-body.png"),
                                          color: Color(0xFFc1912f),
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                            homeController
                                                .filterCarsListData[index]
                                                .bodytype
                                                .name,
                                            style: TextStyle(fontSize: 12)),
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
                                            homeController
                                                    .filterCarsListData[index]
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
                                            homeController
                                                .filterCarsListData[index]
                                                .fuelType,
                                            style: TextStyle(fontSize: 12)),
                                        Spacer(),
                                        ImageIcon(
                                          AssetImage(
                                              "assets/img/4wd-drive.png"),
                                          color: Color(0xFFc1912f),
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                            homeController
                                                .filterCarsListData[index]
                                                .driveType
                                                .name,
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero),
                                        onPressed: () {
                                          Get.toNamed('carDetailsView',
                                              arguments: [
                                                homeController
                                                    .filterCarsListData[index]
                                                    .id,
                                                homeController
                                                    .filterCarsListData[index]
                                                    .carImages[0]
                                                    .carImage
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
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 32),
                                  child: Center(
                                      child: (homeController.hasMore.value)
                                          ? CircularProgressIndicator(
                                              color: Colors.red,
                                              strokeWidth: 1,
                                            )
                                          : Text('No data found')),
                                );
                              }
                            }),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavBarView()),
    );
  }
}
