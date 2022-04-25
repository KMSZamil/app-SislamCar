import 'package:flutter/material.dart';
import 'package:sislam_car/utility/bottom_nav_bar.dart';
import 'package:sislam_car/utility/drawer_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WatchChannelView extends StatefulWidget {
  const WatchChannelView({Key? key}) : super(key: key);

  @override
  State<WatchChannelView> createState() => _WatchChannelViewState();
}

class _WatchChannelViewState extends State<WatchChannelView> {
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
          initialUrl:
              'https://www.youtube.com/channel/UCd1FJ9NRXlKIavNbZoscvQg',
          javascriptMode: JavascriptMode.unrestricted,
        ),
        bottomNavigationBar: BottomNavBarView());
  }
}
