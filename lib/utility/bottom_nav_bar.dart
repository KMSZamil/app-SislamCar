import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BottomNavBarView extends StatelessWidget {
   BottomNavBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        height: 50,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {
                  Get.toNamed('inboxView');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat,
                      color: Colors.black,
                      size: 13,
                    ),
                    Text(
                      'chat',
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                  ],
                )),
            Center(
              child: Container(
                height: 30,
                width: 1,
                color: Colors.grey.shade300,
              ),
            ),
            Expanded(
              child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                   
                    Get.toNamed('buyCarsView');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.credit_card,
                        color: Colors.black,
                        size: 13,
                      ),
                      Text(
                        'Buy',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ],
                  )),
            ),
            Center(
              child: Container(
                height: 30,
                width: 1,
                color: Colors.grey.shade300,
              ),
            ),
            Expanded(
              child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    Get.toNamed('sellSubmitView');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.money,
                        color: Colors.black,
                        size: 13,
                      ),
                      Text(
                        'Sell',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ],
                  )),
            ),
            Center(
              child: Container(
                height: 30,
                width: 1,
                color: Colors.grey.shade300,
              ),
            ),
            Expanded(
              child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    Get.toNamed('exchangeSubmitView');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.car_rental,
                        color: Colors.black,
                        size: 13,
                      ),
                      Text(
                        'Exchange',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
