import 'package:flutter/material.dart';

class Clear_Button extends StatelessWidget {
  const Clear_Button({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 100,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
      child: Center(
        child: Text(
          "Clear",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
