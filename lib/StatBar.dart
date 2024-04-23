import 'package:flutter/material.dart';

class StatBar extends StatelessWidget {
  final String label;
  final Color? barColour;
  final int value;
  final int maxValue;

  const StatBar({
    super.key,
    required this.label,
    required this.barColour,
    required this.value,
    this.maxValue = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        ),
        Container(
          height: 20,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Stack(
            children: [
              Container(
                width: value * 100 / maxValue,
                decoration: BoxDecoration(
                  color: barColour,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
