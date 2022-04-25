import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislam_cars_app/controller/sell_controller.dart';
import 'package:sislam_cars_app/model/brands_model.dart';
import 'package:sislam_cars_app/model/conditions_model.dart';
import 'package:sislam_cars_app/model/district_model.dart';
import 'package:sislam_cars_app/model/fuel_types_model.dart';
import 'package:sislam_cars_app/model/models_model.dart';
import 'package:sislam_cars_app/model/registration_serial_model.dart';
import 'package:sislam_cars_app/model/thana_model.dart';
import 'package:sislam_cars_app/utility/bottom_nav_bar.dart';
import 'package:sislam_cars_app/utility/drawer_view.dart';
import 'package:sislam_cars_app/utility/syncronize_data.dart';

class SellSubmitView extends StatefulWidget {
  const SellSubmitView({Key? key}) : super(key: key);

  @override
  State<SellSubmitView> createState() => _SellSubmitViewState();
}

class _SellSubmitViewState extends State<SellSubmitView> {
  final SellController sellController = Get.put(SellController());
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  Brands? brandValue = null;
  Conditions? conditionValue = null;
  Models? modelValue = null;
  FuelTypes? fuelTypeValue = null;
  RegistrationSerial? registrationSerialValue = null;
  District? districtValue = null;
  Thana? thanaValue = null;
  int _manufacturingYear = 0;
  int _regYear = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 3,
            title: Text(
              'Send Your Car Information',
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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          primary: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Sell your car instantly',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Send your vehicle information!!! Right away our representative will arrive at your door with the money...',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black38),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: ListView(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            children: <Widget>[
                              Text(
                                'Car Details',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: false,
                                child: TextFormField(
                                  controller:
                                      sellController.titleTextController,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'OpenSans',
                                      fontSize: 14),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 5),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.teal)),
                                    hintText: 'Enter Car Title',
                                    hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'OpenSans',
                                        fontSize: 12),
                                  ),
                                  validator: (value) => value!.trim().isEmpty
                                      ? 'car title required'
                                      : null,
                                ),
                              ),
                              // SizedBox(
                              //   height: 5,
                              // ),
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
                                          () => (sellController
                                                      .conditionsLoader.value ==
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
                                                              bottom: 11,
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
                                                  hint: conditionValue == null
                                                      ? const Text('Condition',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      9.5))
                                                      : Text(
                                                          conditionValue!.name,
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
                                                  items: sellController
                                                      .conditionsListData
                                                      .map<
                                                          DropdownMenuItem<
                                                              Conditions>>(
                                                    (Conditions? value) {
                                                      return DropdownMenuItem<
                                                          Conditions>(
                                                        value: value,
                                                        child:
                                                            Text(value!.name),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (val) {
                                                    setState(
                                                      () {
                                                        conditionValue =
                                                            val as Conditions?;
                                                      },
                                                    );
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
                                          () => (sellController
                                                      .brandsLoader.value ==
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
                                                              bottom: 11,
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
                                                  hint: brandValue == null
                                                      ? const Text('Brand',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      9.5))
                                                      : Text(
                                                          brandValue!.name,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 10),
                                                        ),
                                                  isExpanded: true,
                                                  iconSize: 30.0,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  items: sellController
                                                      .brandsListData
                                                      .map<
                                                          DropdownMenuItem<
                                                              Brands>>(
                                                    (Brands? value) {
                                                      return DropdownMenuItem<
                                                          Brands>(
                                                        value: value,
                                                        child:
                                                            Text(value!.name),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (val) {
                                                    setState(
                                                      () {
                                                        modelValue = null;
                                                        brandValue =
                                                            val as Brands?;
                                                      },
                                                    );
                                                    sellController
                                                        .apiGetModelsList(
                                                            brandValue!.id);
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
                                          () => (sellController
                                                      .modelsLoader.value ==
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
                                                              bottom: 11,
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
                                                  hint: modelValue == null
                                                      ? const Text('Model',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      9.5))
                                                      : Text(
                                                          modelValue!.name,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 10),
                                                        ),
                                                  isExpanded: true,
                                                  iconSize: 30.0,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  items: sellController
                                                      .modelsListData
                                                      .map<
                                                          DropdownMenuItem<
                                                              Models>>(
                                                    (Models? value) {
                                                      return DropdownMenuItem<
                                                          Models>(
                                                        value: value,
                                                        child:
                                                            Text(value!.name),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (val) {
                                                    setState(
                                                      () {
                                                        modelValue =
                                                            val as Models?;
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
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    "Select Manufacturing Year"),
                                                content: Container(
                                                  // Need to use container to add size constraint.
                                                  width: 300,
                                                  height: 300,
                                                  child: YearPicker(
                                                    firstDate: DateTime(
                                                        DateTime.now().year -
                                                            50,
                                                        1),
                                                    lastDate: DateTime(
                                                        DateTime.now().year +
                                                            50,
                                                        1),
                                                    initialDate: DateTime.now(),
                                                    // save the selected date to _selectedDate DateTime variable.
                                                    // It's used to set the previous selected date when
                                                    // re-showing the dialog.
                                                    selectedDate:
                                                        DateTime.now(),

                                                    onChanged:
                                                        (DateTime dateTime) {
                                                      // close the dialog when year is selected.
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        _manufacturingYear =
                                                            dateTime.year;
                                                      });

                                                      // Do something with the dateTime selected.
                                                      // Remember that you need to use dateTime.year to get the year
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey)),
                                          height: 40,
                                          child: (_manufacturingYear == 0)
                                              ? Center(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Menufacturing. Year',
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      ImageIcon(
                                                        AssetImage(
                                                            "assets/img/calendar.png"),
                                                        color:
                                                            Color(0xFFc1912f),
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Center(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        _manufacturingYear
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      ImageIcon(
                                                        AssetImage(
                                                            "assets/img/calendar.png"),
                                                        color:
                                                            Color(0xFFc1912f),
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    "Select Registration Year"),
                                                content: Container(
                                                  // Need to use container to add size constraint.
                                                  width: 300,
                                                  height: 300,
                                                  child: YearPicker(
                                                    firstDate: DateTime(
                                                        DateTime.now().year -
                                                            50,
                                                        1),
                                                    lastDate: DateTime(
                                                        DateTime.now().year +
                                                            50,
                                                        1),
                                                    initialDate: DateTime.now(),
                                                    // save the selected date to _selectedDate DateTime variable.
                                                    // It's used to set the previous selected date when
                                                    // re-showing the dialog.
                                                    selectedDate:
                                                        DateTime.now(),

                                                    onChanged:
                                                        (DateTime dateTime) {
                                                      // close the dialog when year is selected.
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        _regYear =
                                                            dateTime.year;
                                                      });

                                                      // Do something with the dateTime selected.
                                                      // Remember that you need to use dateTime.year to get the year
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey)),
                                          height: 40,
                                          child: (_regYear == 0)
                                              ? Center(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Registration. Year',
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      ImageIcon(
                                                        AssetImage(
                                                            "assets/img/calendar.png"),
                                                        color:
                                                            Color(0xFFc1912f),
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Center(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        _regYear.toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      ImageIcon(
                                                        AssetImage(
                                                            "assets/img/calendar.png"),
                                                        color:
                                                            Color(0xFFc1912f),
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ), // ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.grey)),
                                      child: Obx(
                                        () => (sellController
                                                    .conditionsLoader.value ==
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
                                                            bottom: 11,
                                                            top: 0,
                                                            left: 6,
                                                            right: 6),
                                                    errorStyle:
                                                        TextStyle(height: 0),
                                                    counterText: "",
                                                    errorBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4)),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.red)),
                                                    border: InputBorder.none),
                                                hint: registrationSerialValue ==
                                                        null
                                                    ? const Text('Reg. Serial',
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 9.0))
                                                    : Text(
                                                        registrationSerialValue!
                                                            .name,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 9),
                                                      ),
                                                isExpanded: true,
                                                iconSize: 30.0,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                items: sellController
                                                    .registrationSerialListData
                                                    .map<
                                                        DropdownMenuItem<
                                                            RegistrationSerial>>(
                                                  (RegistrationSerial? value) {
                                                    return DropdownMenuItem<
                                                        RegistrationSerial>(
                                                      value: value,
                                                      child: Text(value!.name),
                                                    );
                                                  },
                                                ).toList(),
                                                onChanged: (val) {
                                                  setState(
                                                    () {
                                                      registrationSerialValue = val
                                                          as RegistrationSerial?;
                                                    },
                                                  );
                                                },
                                                validator: (value) =>
                                                    value == null ? '' : null,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: 40,
                                    child: TextFormField(
                                      controller: sellController
                                          .regSerialTextController,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'OpenSans',
                                          fontSize: 10),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 5),
                                        errorStyle: TextStyle(height: 0),
                                        border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.teal)),
                                        hintText: 'Number',
                                        hintStyle: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'OpenSans',
                                            fontSize: 10),
                                      ),
                                      validator: (value) =>
                                          value!.trim().isEmpty ? '' : null,
                                    ),
                                  )),
                                ],
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                controller:
                                    sellController.askingPriceTextController,
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
                                  hintText: 'Enter Asking Price',
                                  hintStyle: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'OpenSans',
                                      fontSize: 12),
                                ),
                                validator: (value) => value!.trim().isEmpty
                                    ? 'Enter Asking Price required'
                                    : null,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller:
                                    sellController.commentsTextController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                  hintText: 'Enter Comments',
                                  hintStyle: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'OpenSans',
                                      fontSize: 12),
                                ),
                                // validator: (value) => value!.trim().isEmpty
                                //     ? 'Comments required'
                                //     : null,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Contact Details',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: sellController.nameTextController,
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
                                controller: sellController.mobileTextController,
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
                                          () => (sellController
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
                                                  items: sellController
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
                                                    sellController
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
                                          () => (sellController
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
                                                  items: sellController
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
                              TextField(
                                controller: sellController.emailTextController,
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
                              TextFormField(
                                controller: sellController.add1TextController,
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
                                controller: sellController.add2TextController,
                                focusNode: _focusNode,
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
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Photo Upload',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 60,
                                    // width: 45,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: Colors.blue.shade200)),
                                    child: Center(
                                        child: IconButton(
                                            icon: Icon(Icons.camera_alt_sharp),
                                            onPressed: () {
                                              sellController.getImage1();
                                            })),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Obx(
                                    () => (sellController.image.isEmpty)
                                        ? Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color:
                                                        Colors.red.shade200)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  'No Image Picked',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Expanded(
                                            child: Container(
                                              // Horizontal ListView
                                              height: 60,

                                              child: ListView.builder(
                                                itemCount:
                                                    sellController.image.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                primary: true,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Container(
                                                      height: 60,
                                                      //width: 60,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 2,
                                                              color: Colors.grey
                                                                  .shade200)),
                                                      alignment:
                                                          Alignment.center,
                                                      // color: Colors.blue[(index % 9) * 100],
                                                      child: Image.file(
                                                        File(sellController
                                                            .image[index]),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Obx(() => (sellController.action.value == true)
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
                                    if (sellController.image.isEmpty) {
                                      Get.snackbar('msg', 'Image is required',
                                          snackPosition: SnackPosition.BOTTOM);
                                    } else if (_manufacturingYear == 0) {
                                      Get.snackbar('msg',
                                          'Manufacturing year is required',
                                          snackPosition: SnackPosition.BOTTOM);
                                    } else if (_regYear == 0) {
                                      Get.snackbar('msg',
                                          'Registration year is required',
                                          snackPosition: SnackPosition.BOTTOM);
                                    } else {
                                      sellController.sellSubmit(
                                          conditionValue!.id,
                                          brandValue!.id,
                                          modelValue!.id,
                                          _manufacturingYear,
                                          _regYear,
                                          registrationSerialValue!.name,
                                          districtValue!.id,
                                          thanaValue!.id,
                                          brandValue!.name,
                                          modelValue!.name);
                                    }
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
