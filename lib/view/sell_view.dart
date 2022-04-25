import 'package:flutter/material.dart';

class SellView extends StatefulWidget {
  const SellView({Key? key}) : super(key: key);

  @override
  State<SellView> createState() => _SellViewState();
}

class _SellViewState extends State<SellView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Sell your car instantly',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const Text(
          'Send your vehicle information!!! Right away our representative will arrive at your door with the money...',
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
