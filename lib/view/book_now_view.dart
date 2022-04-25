import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislam_car/controller/book_now_controller.dart';
import 'package:sislam_car/http/url.dart';
import 'package:sislam_car/model/district_model.dart';
import 'package:sislam_car/model/thana_model.dart';
import 'package:sislam_car/utility/bottom_nav_bar.dart';
import 'package:sislam_car/utility/drawer_view.dart';
import 'package:sislam_car/utility/syncronize_data.dart';

class BookNowView extends StatefulWidget {
  const BookNowView({Key? key}) : super(key: key);

  @override
  State<BookNowView> createState() => _BookNowViewState();
}

class _BookNowViewState extends State<BookNowView> {
  final BookNowController bookNowController = Get.put(BookNowController());
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  var carId = Get.arguments[0];
  var carName = Get.arguments[1];
  var carImage = Get.arguments[2];
  District? districtValue = null;
  Thana? thanaValue = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 3,
            title: Text('Book a Car', style: TextStyle(fontSize: 16)),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ))),
        endDrawer: DrawerView(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Book ' + carName,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 180,
                  child: Center(
                    child: FadeInImage(
                        image: NetworkImage(carImage),
                        fit: BoxFit.fill,
                        placeholder: AssetImage('assets/img/loading.gif')),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please send us your contact Details, We will contact you soon!',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: ListView(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            children: <Widget>[
                              TextFormField(
                                controller:
                                    bookNowController.nameTextController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                  hintText: 'Enter Full Name',
                                  hintStyle: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'OpenSans',
                                      fontSize: 12),
                                ),
                                validator: (value) => value!.trim().isEmpty
                                    ? 'Full Name required'
                                    : null,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller:
                                    bookNowController.mobileTextController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                    fontSize: 14),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                  hintText: 'Enter Mobile',
                                  hintStyle: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'OpenSans',
                                      fontSize: 12),
                                ),
                                validator: (value) => value!.trim().isEmpty
                                    ? 'Mobile required'
                                    : null,
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller:
                                    bookNowController.emailTextController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                    fontSize: 14),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                  hintText: 'Enter Email',
                                  hintStyle: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'OpenSans',
                                      fontSize: 12),
                                ),
                                // validator: (value) => value!.trim().isEmpty
                                //     ? 'Email required'
                                //     : null,
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 40,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.grey)),
                                        child: Obx(
                                          () => (bookNowController
                                                      .districtLoader.value ==
                                                  true)
                                              ? Center(
                                                  child: SizedBox(
                                                    width: 15,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 0.5,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                )
                                              : DropdownButtonFormField(
                                                  decoration: const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 10.5,
                                                              top: 0,
                                                              left: 6,
                                                              right: 6),
                                                      errorStyle:
                                                          TextStyle(height: 0),
                                                      counterText: "",
                                                      errorBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4)),
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .red)),
                                                      border: InputBorder.none),
                                                  hint: districtValue == null
                                                      ? const Text('District',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      9.5))
                                                      : Text(
                                                          districtValue!.name,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 10),
                                                        ),
                                                  isExpanded: true,
                                                  iconSize: 30.0,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                  items: bookNowController
                                                      .districtListData
                                                      .map<
                                                          DropdownMenuItem<
                                                              District>>(
                                                    (District? value) {
                                                      return DropdownMenuItem<
                                                          District>(
                                                        value: value,
                                                        child:
                                                            Text(value!.name),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (val) {
                                                    setState(
                                                      () {
                                                        thanaValue = null;
                                                        districtValue =
                                                            val as District?;
                                                      },
                                                    );
                                                    bookNowController
                                                        .apiGetThanaList(
                                                            districtValue!.id);
                                                  },
                                                  validator: (value) =>
                                                      value == null ? '' : null,
                                                ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.grey)),
                                        child: Obx(
                                          () => (bookNowController
                                                      .thanaLoader.value ==
                                                  true)
                                              ? Center(
                                                  child: SizedBox(
                                                    width: 15,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 0.5,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                )
                                              : DropdownButtonFormField(
                                                  decoration: const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 10.5,
                                                              top: 0,
                                                              left: 6,
                                                              right: 6),
                                                      errorStyle:
                                                          TextStyle(height: 0),
                                                      counterText: "",
                                                      errorBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4)),
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .red)),
                                                      border: InputBorder.none),
                                                  hint: thanaValue == null
                                                      ? const Text('Thana',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      9.5))
                                                      : Text(
                                                          thanaValue!.name,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 10),
                                                        ),
                                                  isExpanded: true,
                                                  iconSize: 30.0,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                  items: bookNowController
                                                      .thanaListData
                                                      .map<
                                                          DropdownMenuItem<
                                                              Thana>>(
                                                    (Thana? value) {
                                                      return DropdownMenuItem<
                                                          Thana>(
                                                        value: value,
                                                        child:
                                                            Text(value!.name),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (val) {
                                                    setState(
                                                      () {
                                                        thanaValue =
                                                            val as Thana?;
                                                      },
                                                    );
                                                  },
                                                  validator: (value) =>
                                                      value == null ? '' : null,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller:
                                    bookNowController.add1TextController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                  hintText: 'Enter Address Line 1',
                                  hintStyle: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'OpenSans',
                                      fontSize: 12),
                                ),
                                validator: (value) => value!.trim().isEmpty
                                    ? 'Address Line 1 required'
                                    : null,
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller:
                                    bookNowController.add2TextController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                  hintText: 'Enter Address Line 2',
                                  hintStyle: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'OpenSans',
                                      fontSize: 12),
                                ),
                                // validator: (value) => value!.trim().isEmpty
                                //     ? 'Address Line 2 required'
                                //     : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Obx(() => (bookNowController.action.value == true)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: MaterialButton(
                            color: Color(0xFFc1912f),
                            height: 45,
                            minWidth: double.infinity,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: const Text(
                              'SUBMIT',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              // ignore: avoid_print
                              print("Internet connection abailale");
                              SyncronizationData.isInternet()
                                  .then((connection) {
                                if (connection) {
                                  // ignore: avoid_print
                                  print("Internet connection abailale");
                                  if (_formKey.currentState!.validate()) {
                                    bookNowController.bookNowSubmit(
                                        carId,
                                        carName,
                                        districtValue!.id,
                                        thanaValue!.id);
                                  }
                                } else {
                                  Get.snackbar('!opps', '"No Internet"',
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: Colors.red);
                                }
                              });
                            }),
                      )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarView());
  }
}
