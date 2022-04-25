import 'package:flutter/material.dart';
import 'package:sislam_cars_app/utility/bottom_nav_bar.dart';
import 'package:sislam_cars_app/utility/drawer_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InboxView extends StatefulWidget {
  const InboxView({Key? key}) : super(key: key);

  @override
  State<InboxView> createState() => _InboxViewState();
}

class _InboxViewState extends State<InboxView> {
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
          initialUrl: 'https://www.sislamcars.com.bd/messenger-intregation',
          javascriptMode: JavascriptMode.unrestricted,
        ),
        bottomNavigationBar: BottomNavBarView());
  }
}
