import 'package:flutter/material.dart';


class MonthlyPrice extends StatelessWidget {

  final double price;

  const MonthlyPrice({
    super.key,
    required this.price
  });


  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          children: [
            TextSpan(
                text: '\$${price.ceil()}',
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.w900
                )
            ),

            const TextSpan(
                text: ' / Месяц',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                )
            ),
          ]),
    );
  }
}
