import 'package:flutter/material.dart';

class LargeButtons extends StatelessWidget {
  final Color bordercolor;
  final Color textcolor;
  final Color backgroundcolor;
  final String text;
  final Function()? onPressed;
  const LargeButtons({
    super.key,
    required this.bordercolor,
    required this.textcolor,
    required this.backgroundcolor,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        side: BorderSide(color: bordercolor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        backgroundColor: backgroundcolor,
        fixedSize: const Size(500, 50),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textcolor,
          fontSize: 16,
        ),
      ),
    );
  }
}
