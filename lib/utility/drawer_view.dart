import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);
  _launcherUrl(_url) async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("assets/img/sillogo.png"),
                    fit: BoxFit.fitWidth)),
          ),
          Card(
            color: Colors.grey.shade100,
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Get.toNamed('homeView');
              },
            ),
          ),
          Card(
            color: Colors.grey.shade100,
            child: ListTile(
              leading: Icon(Icons.description),
              title: Text('About Us'),
              onTap: () {
                Get.toNamed('aboutUsView');
              },
            ),
          ),
          Card(
            color: Colors.grey.shade100,
            child: ListTile(
              leading: Icon(Icons.history),
              title: Text('Blog'),
              onTap: () {
                final Uri _url =
                    Uri.parse('https://www.sislamcars.com.bd/blog');
                _launcherUrl(_url);
              },
            ),
          ),
          Card(
            color: Colors.grey.shade100,
            child: ListTile(
              leading: Icon(Icons.contact_page),
              title: Text('Contact Us'),
              onTap: () {
                Get.toNamed('contactUsView');
              },
            ),
          ),
          Card(
            color: Colors.grey.shade100,
            child: ListTile(
              leading: Icon(Icons.play_arrow, color: Colors.red),
              title: Text('Watch Channel'),
              onTap: () {
                Get.toNamed('watchChannelView');
              },
            ),
          ),
          Card(
            color: Colors.grey.shade100,
            child: ListTile(
              leading: Icon(Icons.help),
              title: Text('Help Center'),
              onTap: () {
                Get.toNamed('helpCenterView');
              },
            ),
          ),
        ],
      ),
    );
  }
}
