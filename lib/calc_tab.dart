// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:calculator/my_colors.dart';

class CalcTab extends StatelessWidget {
  final Color color;
  final String text;
  final Function()? onTap;
  const CalcTab({Key? key, required this.text, required this.color, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: MyColors.tabDark,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
