import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/widgets/custom_text_button.dart';

class CustomTestButtonIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color color;
  final String imageUrl;

  const CustomTestButtonIcon({
    Key key,
    this.onPressed,
    this.title,
    this.color,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      // width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(primary: color),
        child: Row(
          children: [
            Image.asset(imageUrl),
            Container(
              height: 30.0,
              width: 1.0,
              color: Colors.white30,
              margin: const EdgeInsets.only(left: 5.0, right: 5.0),
            ),
            Spacer(),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
