import 'package:flutter/material.dart';

class TripButton extends StatelessWidget {
  const TripButton({
    super.key,
    required this.clickedButton,
    this.text = 'Save',
  });

  final Function() clickedButton;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clickedButton,
      child: Container(
        width: 150,
        height: 45,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 229, 217, 242),
                const Color.fromARGB(170, 205, 193, 255),
              ],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Color.fromARGB(255, 46, 80, 119),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.save,
              color: Color.fromARGB(255, 46, 80, 119),
            ),
          ],
        ),
      ),
    );
  }
}
