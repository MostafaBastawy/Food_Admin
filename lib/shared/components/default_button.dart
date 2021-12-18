import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  Function onPressed;
  String labelText;
  Color color;
  double? height = 55;
  DefaultButton({
    Key? key,
    required this.onPressed,
    required this.labelText,
    required this.color,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: MaterialButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          labelText,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
