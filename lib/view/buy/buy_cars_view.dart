import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislam_car/controller/buy_controller.dart';
import 'package:sislam_car/http/url.dart';
import 'package:sislam_car/utility/bottom_nav_bar.dart';
import 'package:sislam_car/utility/drawer_view.dart';

class BuyCarsView extends StatefulWidget {
  const BuyCarsView({Key? key}) : super(key: key);

  @override
  State<BuyCarsView> createState() => _BuyCarsViewState();
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

class _BuyCarsViewState extends State<BuyCarsView> {
  final BuyController buyController = Get.put(BuyController());
  final _debouncer = Debouncer(milliseconds: 200);
  final scrollControllerBuyCar = ScrollController();
  @override
  void initState() {
    super.initState();

    //  buyController.apiGetBuyCarsList();
    scrollControllerBuyCar.addListener(() {
      if (scrollControllerBuyCar.position.maxScrollExtent ==
          scrollControllerBuyCar.offset) {
        print('hello');
        buyController.apiGetBuyCarsList();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollControllerBuyCar.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 3,
            title: Text(
              'Car Buy',
              style: TextStyle(fontSize: 16),
            ),
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
            SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 30,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    color: Colors.grey.shade200,
                    //width: Get.width - 50,
                    child: TextField(
                      readOnly: true,
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
                      // onChanged: (v) {
                      //   _debouncer.run(() {
                      //     buyController.onItemChanged(v);
                      //   });
                      // }
                      onTap: () {
                        Get.toNamed('searchView');
                      },
                    ),
                  ),
                )),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Obx(
                () => (buyController.dashboardCarsLoader.value == true)
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
                            buyController.filterBuyCarsListData.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index <
                              buyController.filterBuyCarsListData.length) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(index.toString()),
                                  Stack(
                                    children: [
                                      const SizedBox(height: 210),
                                      (buyController
                                              .filterBuyCarsListData[index]
                                              .carImages
                                              .isNotEmpty)
                                          ? SizedBox(
                                              height: 200,
                                              width: double.infinity,
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    ('assets/img/loading.gif'),
                                                image: buyController
                                                    .filterBuyCarsListData[
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                    style: TextButton.styleFrom(
                                                        padding:
                                                            EdgeInsets.zero),
                                                    onPressed: (buyController
                                                                .filterBuyCarsListData[
                                                                    index]
                                                                .status ==
                                                            2)
                                                        ? null
                                                        : () {
                                                            Get.toNamed(
                                                                'bookNowView',
                                                                arguments: [
                                                                  buyController
                                                                      .filterBuyCarsListData[
                                                                          index]
                                                                      .id,
                                                                  buyController
                                                                      .filterBuyCarsListData[
                                                                          index]
                                                                      .carTitle,
                                                                  buyController
                                                                      .filterBuyCarsListData[
                                                                          index]
                                                                      .carImages[
                                                                          0]
                                                                      .carImage
                                                                ]);
                                                          },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration: BoxDecoration(
                                                          color: (buyController
                                                                      .filterBuyCarsListData[
                                                                          index]
                                                                      .status ==
                                                                  2)
                                                              ? Colors.red
                                                              : const Color(
                                                                  0xff0a172a),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Center(
                                                        child: (buyController
                                                                    .filterBuyCarsListData[
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
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xff0a172a),
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Center(
                                                    child: Text(
                                                      'Tk. ' +
                                                          buyController
                                                              .filterBuyCarsListData[
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
                                    buyController
                                        .filterBuyCarsListData[index].carTitle,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        buyController
                                                .filterBuyCarsListData[index]
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
                                          buyController
                                              .filterBuyCarsListData[index]
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
                                          buyController
                                              .filterBuyCarsListData[index]
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
                                          buyController
                                              .filterBuyCarsListData[index]
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
                                          buyController
                                              .filterBuyCarsListData[index]
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
                                          buyController
                                                  .filterBuyCarsListData[index]
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
                                          buyController
                                              .filterBuyCarsListData[index]
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
                                      Text(
                                          buyController
                                              .filterBuyCarsListData[index]
                                              .driveType
                                              .name,
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero),
                                      onPressed: () {
                                        print(buyController
                                            .filterBuyCarsListData[index].id);
                                        Get.toNamed('carDetailsView',
                                            arguments: [
                                              buyController
                                                  .filterBuyCarsListData[index]
                                                  .id,
                                              buyController
                                                  .filterBuyCarsListData[index]
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
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: Center(
                                  child: (buyController.hasMore.value)
                                      ? CircularProgressIndicator(
                                          color: Colors.red,
                                          strokeWidth: 1,
                                        )
                                      : Text('No data found')),
                            );
                          }
                        }),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBarView());
  }
}
