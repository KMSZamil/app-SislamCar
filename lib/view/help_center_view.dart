import 'package:flutter/material.dart';
import 'package:sislam_car/utility/bottom_nav_bar.dart';
import 'package:sislam_car/utility/drawer_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpCenterView extends StatefulWidget {
  const HelpCenterView({Key? key}) : super(key: key);

  @override
  State<HelpCenterView> createState() => _HelpCenterViewState();
}

class _HelpCenterViewState extends State<HelpCenterView> {
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: WebView(
          initialUrl: 'https://www.sislamcars.com.bd/help-center-mob',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          onPageFinished: (url) {
            // print(urllink);
            controller.runJavascript(
                "document.getElementsByTagName('header')[0].style.display='none';");
            controller.runJavascript(
                "document.getElementsByTagName('footer')[0].style.display='none';");
          },
        ),
        bottomNavigationBar: BottomNavBarView());
  }
}
