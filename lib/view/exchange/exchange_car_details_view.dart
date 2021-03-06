import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sislam_car/controller/car_details_contoller.dart';
import 'package:sislam_car/controller/exchange_controller.dart';
import 'package:sislam_car/http/url.dart';
import 'package:sislam_car/utility/bottom_nav_bar.dart';
import 'package:sislam_car/utility/drawer_view.dart';
import 'package:sislam_car/utility/syncronize_data.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExchangeCarDetailsView extends StatefulWidget {
  const ExchangeCarDetailsView({Key? key}) : super(key: key);

  @override
  State<ExchangeCarDetailsView> createState() => _ExchangeCarDetailsViewState();
}

class _ExchangeCarDetailsViewState extends State<ExchangeCarDetailsView> {
  final CarDetailsController carDetailsController =
      Get.put(CarDetailsController());
  final ExchangeController exchangeController = Get.put(ExchangeController());
  final getdata = GetStorage();
  var onChageImage;
  var registrationSerialName;
  var exchangeCarId = Get.arguments[0];
  var conditionId = Get.arguments[1];
  var brandId = Get.arguments[2];
  var modelId = Get.arguments[3];
  var manufacturingYear = Get.arguments[4];
  var regYear = Get.arguments[5];
  var districtId = Get.arguments[6];
  var thanaId = Get.arguments[7];
  late YoutubePlayerController _youController;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  late PlayerState _playerState;
  var videoId = 'ONqJUS36X3Y';

  listener() {
    if (_isPlayerReady && mounted && !_youController.value.isFullScreen) {
      setState(() {
        _playerState = _youController.value.playerState;
        _videoMetaData = _youController.metadata;
      });
    }
  }

  @override
  void deactivate() {
    _youController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _youController.dispose();
    super.dispose();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Close",
            style: TextStyle(color: Colors.white),
          ),
          Icon(Icons.close, color: Colors.red)
        ],
      ),
      onPressed: () {
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("My title"),
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: okButton,
      content: YoutubePlayer(
        controller: _youController,
        aspectRatio: 16 / 9,
        showVideoProgressIndicator: true,
        onReady: () {
          _youController.addListener(listener);
        },
      ),
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    carDetailsController.apiGetCarDetailsList(exchangeCarId);
    onChageImage = getdata.read('carImage');
    registrationSerialName = getdata.read('registrationSerialName');
    _youController = YoutubePlayerController(
      initialVideoId: videoId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const SizedBox(
              height: 50,
              child: Image(
                image: AssetImage('assets/img/sillogo.png'),
              ),
            )),
        endDrawer: DrawerView(),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => (carDetailsController.carDetailsListData.isEmpty)
                      ? Center(
                          child: CircularProgressIndicator(
                          strokeWidth: 0.5,
                        ))
                      : Stack(
                          children: [
                            SizedBox(
                              height: 220,
                            ),
                            Container(
                              height: 200,
                              child: FadeInImage(
                                  image: NetworkImage(onChageImage),
                                  fit: BoxFit.fill,
                                  placeholder:
                                      AssetImage('assets/img/loading.gif')),
                            ),
                            Positioned(
                              right: -10,
                              top: -6,
                              child: TextButton(
                                  onPressed: () {
                                    _youController = YoutubePlayerController(
                                        initialVideoId:
                                            carDetailsController.videoId.value,
                                        flags: YoutubePlayerFlags(
                                            autoPlay: false,
                                            mute: false,
                                            loop: false,
                                            isLive: false,
                                            forceHD: false));
                                    showAlertDialog(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFff0000),
                                        border: Border.all(
                                            color: Colors.white, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Watch Video',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: -5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // TextButton(
                                    //     style: TextButton.styleFrom(
                                    //         padding: EdgeInsets.zero),
                                    //     onPressed: () {
                                    //       Get.toNamed('exchangeSubmitView',
                                    //           arguments: [
                                    //             carDetailsController
                                    //                 .carDetailsListData[0].id,
                                    //             carDetailsController
                                    //                 .carDetailsListData[0]
                                    //                 .carTitle,
                                    //             carDetailsController
                                    //                 .carDetailsListData[0]
                                    //                 .carImages[0]
                                    //                 .carImage
                                    //           ]);
                                    //     },
                                    //     child: Container(
                                    //       padding: const EdgeInsets.all(10),
                                    //       decoration: BoxDecoration(
                                    //           color: Colors.indigoAccent,
                                    //           border: Border.all(
                                    //               color: Colors.white,
                                    //               width: 1),
                                    //           borderRadius:
                                    //               BorderRadius.circular(15)),
                                    //       child: const Center(
                                    //         child: Text(
                                    //           'Select Car',
                                    //           style: TextStyle(
                                    //               color: Colors.white),
                                    //         ),
                                    //       ),
                                    //     )),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Center(
                                        child: Obx(
                                          () => (carDetailsController
                                                  .carDetailsListData.isEmpty)
                                              ? Container()
                                              : Text(
                                                  'Tk. ' +
                                                      carDetailsController
                                                          .carDetailsListData[0]
                                                          .price
                                                          .toString() +
                                                      '.00',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 70,
                  child: Obx(
                    () => (carDetailsController.carDetailsListData.isEmpty)
                        ? Container()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: carDetailsController
                                .carDetailsListData[0].carImages.length,
                            itemBuilder: (BuildContext context, int index) {
                              var carImage = carDetailsController
                                  .carDetailsListData[0].carImages;
                              return Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      onChageImage = carImage[index].carImage;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: (carImage[index].carImage ==
                                                onChageImage)
                                            ? Border.all(
                                                width: 3, color: Colors.amber)
                                            : Border.all(width: 0)),
                                    width: 70,
                                    child: ClipOval(
                                      child: FadeInImage(
                                          image: NetworkImage(
                                              carImage[index].carImage),
                                          fit: BoxFit.fill,
                                          placeholder: AssetImage(
                                              'assets/img/loading.gif')),
                                    ),
                                  ),
                                ),
                              );
                            }),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => (carDetailsController.carDetailsListData.isEmpty)
                      ? Container()
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          primary: true,
                          itemCount:
                              carDetailsController.carDetailsListData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    carDetailsController
                                        .carDetailsListData[index].carTitle
                                        .toString(),
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Color(0xFF0f2749),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      height: 30,
                                      width: double.infinity,
                                      color: Colors.grey.shade200,
                                      child: Text(
                                        'Specification',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Price',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        "Tk." +
                                            carDetailsController
                                                .carDetailsListData[index].price
                                                .toString() +
                                            ".00",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Make',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        carDetailsController
                                            .carDetailsListData[index]
                                            .carBrand
                                            .name
                                            .toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Model',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        carDetailsController
                                            .carDetailsListData[index].carModel
                                            .toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Body Style',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        carDetailsController
                                            .carDetailsListData[index]
                                            .bodytype
                                            .name
                                            .toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Manufacturing Year',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        carDetailsController
                                            .carDetailsListData[index]
                                            .menufacturingYear
                                            .toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Registration Year',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        carDetailsController
                                            .carDetailsListData[index]
                                            .registrationYear
                                            .toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Condition',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        carDetailsController
                                            .carDetailsListData[index]
                                            .condition
                                            .name
                                            .toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Mileage',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        carDetailsController
                                                .carDetailsListData[index]
                                                .milage
                                                .toString() +
                                            " km",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Make',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        carDetailsController
                                            .carDetailsListData[index]
                                            .carBrand
                                            .name
                                            .toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Exterior Color',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        carDetailsController
                                            .carDetailsListData[index]
                                            .carExteriorColor
                                            .name
                                            .toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Transmission',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        carDetailsController
                                            .carDetailsListData[index]
                                            .carTransmission
                                            .name
                                            .toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Engine Capacity',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        carDetailsController
                                            .carDetailsListData[index]
                                            .engineCapacity
                                            .toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Fuel Type',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        carDetailsController
                                            .carDetailsListData[index].fuelType
                                            .toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                ],
                              ),
                            );
                          }),
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => (carDetailsController.carDetailsListData.isEmpty)
                      ? Container()
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          primary: true,
                          itemCount:
                              carDetailsController.carDetailsListData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Column(
                                children: [
                                  Text(
                                    carDetailsController
                                        .carDetailsListData[index].carDetails
                                        .toString(),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  (carDetailsController
                                              .carDetailsListData[index]
                                              .status ==
                                          2)
                                      ? Container()
                                      : Obx(() => (exchangeController
                                                  .action.value ==
                                              true)
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : TextButton(
                                              style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero),
                                              onPressed: () {
                                                SyncronizationData.isInternet()
                                                    .then((connection) {
                                                  if (connection) {
                                                    exchangeController
                                                        .EexchangeSubmit(
                                                            conditionId,
                                                            brandId,
                                                            modelId,
                                                            manufacturingYear,
                                                            regYear,
                                                            registrationSerialName,
                                                            districtId,
                                                            thanaId,
                                                            exchangeCarId);
                                                  } else {
                                                    Get.snackbar('!opps',
                                                        '"No Internet"',
                                                        snackPosition:
                                                            SnackPosition
                                                                .BOTTOM,
                                                        colorText: Colors.red);
                                                  }
                                                });
                                                // Get.toNamed('exchangeSubmitView',
                                                //     arguments: [
                                                //       carDetailsController
                                                //           .carDetailsListData[index].id,
                                                //       carDetailsController
                                                //           .carDetailsListData[index]
                                                //           .carTitle,
                                                //       carDetailsController
                                                //           .carDetailsListData[index]
                                                //           .carImages[0]
                                                //           .carImage
                                                //     ]);
                                              },
                                              child: Container(
                                                height: 40,
                                                padding:
                                                    const EdgeInsets.all(4),
                                                width: double.infinity,
                                                color: Color(0xFFc1912f),
                                                child: const Center(
                                                    child: Text(
                                                  'EXCHANGE',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white),
                                                )),
                                              ))),
                                ],
                              ),
                            );
                          }),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarView());
  }
}
