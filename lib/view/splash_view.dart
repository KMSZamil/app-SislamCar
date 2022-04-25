import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislam_cars_app/controller/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), splashController.handleTapEvent);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
                height: 200,
                width: 200,
                image: AssetImage('assets/img/logo.png')),
            SizedBox(height: 28),
            DefaultTextStyle(
              style: TextStyle(color: Colors.amber, fontSize: 20),
              child: AnimatedTextKit(
                animatedTexts: [WavyAnimatedText('S ISLAM CARS')],
                isRepeatingAnimation: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
