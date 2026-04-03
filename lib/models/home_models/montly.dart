import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final Color color;
  final String title;
  final String percent;

  const LegendItem({
    super.key,
    required this.color,
    required this.title,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 4, backgroundColor: color),
        SizedBox(width: 8),
        SizedBox(
          width: 70,
          child: Text(title),
        ),
        Text(
          percent,
          style: TextStyle(fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}