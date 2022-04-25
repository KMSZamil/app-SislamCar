import 'package:flutter/material.dart';

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
          'Buy cars with S Islam Cars & get payment instantly',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const Text(
          'check out all our cars and buy the carsof your choice at affortable prices',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        TextButton(
            onPressed: () {},
            child: Container(
              height: 30,
              padding: const EdgeInsets.all(4),
              width: double.infinity,
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
