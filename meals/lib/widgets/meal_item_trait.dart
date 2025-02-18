import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 17,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
