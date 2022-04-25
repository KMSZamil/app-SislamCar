import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sislam_car/res/colors.dart';
import 'package:sislam_car/utility/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final getdata = GetStorage();
  getdata.writeIfNull('isLoggedIn', false);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(
    GetMaterialApp(
      title: 'S ISLAM CARS',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      getPages: RouterRoute.route,
      initialRoute: '/splashView',
      theme: ThemeData(
        primarySwatch: ColorRes.navy,
        appBarTheme: AppBarTheme(
          color: ColorRes.barColor,
          // ignore: deprecated_member_use
          textTheme: TextTheme(
            headline6: GoogleFonts.exo2(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}
