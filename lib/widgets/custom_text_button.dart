import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Icon icon;
  final Color color;

  const CustomTextButton(
      {Key key,
      @required this.onPressed,
      @required this.title,
      this.icon,
      this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      // width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.grey[300],
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        style: TextButton.styleFrom(
            backgroundColor: color == null ? Color(0xFE1CDAA5) : color),
      ),
    );
  }
}
