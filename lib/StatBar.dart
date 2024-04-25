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
    this.maxValue = 255,
  });

  @override
  Widget build(BuildContext context) {
    String shortLabel = label == 'Special-attack'
        ? 'Sp. Atk'
        : label == 'Special-defense'
            ? 'Sp. Def'
            : label;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$shortLabel ($value)',
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        ),
        // const SizedBox(width: 8),
        const SizedBox(height: 4),
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
