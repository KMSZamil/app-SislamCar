import 'package:flutter/material.dart';
import 'package:sislam_car/utility/bottom_nav_bar.dart';
import 'package:sislam_car/utility/drawer_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogView extends StatefulWidget {
  const BlogView({Key? key}) : super(key: key);

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
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
          initialUrl: 'https://www.sislamcars.com.bd/news',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          onPageStarted: (url) {
            // print(urllink);
            controller.runJavascript(
                "document.getElementsByTagName('header')[0].style.display='none';");
            controller.runJavascript(
                "document.getElementsByTagName('footer')[0].style.display='none';");
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
