import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyView extends StatefulWidget {
  const BuyView({Key? key}) : super(key: key);

  @override
  State<BuyView> createState() => _BuyViewState();
}

class _BuyViewState extends State<BuyView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Buy cars from S Islam Cars',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const Text(
          'check out all our cars and buy the carsof your choice at affortable prices',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: () {
              Get.toNamed('buyCarsView');
            },
            child: Container(
              height: 30,
              padding: const EdgeInsets.all(0),
              width: Get.width,
              color: const Color(0xFF353a3c),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Next ',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 14,
                  )
                ],
              )),
            )),
      ],
    );
  }
}
