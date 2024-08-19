import 'package:flutter/material.dart';

class HeaderViewSettings {
  const HeaderViewSettings({
    this.headerViewHeight = 100,
    this.dateTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 36,
      fontWeight: FontWeight.w600,
    ),
    this.dayTextStyle = const TextStyle(
      color: Colors.blueAccent,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    this.selectedDateColor = Colors.blueAccent,
    this.todayColor = Colors.redAccent,
    this.headerCellWidth = 200,
  });

  final double headerViewHeight;
  final TextStyle dateTextStyle;
  final TextStyle dayTextStyle;

  final Color selectedDateColor;
  final Color todayColor;
  final double headerCellWidth;
}
