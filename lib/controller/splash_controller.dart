import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void handleTapEvent() {
    Get.offNamed('/homeView');
  }
}