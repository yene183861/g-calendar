import 'package:flutter/widgets.dart';
import 'package:g_calendar/src/settings/header_view_settings.dart';
import 'package:g_calendar/src/settings/time_slot_view_settings.dart';

class CalendarView extends CustomPainter {
  final TimeSlotViewSettings timeSlotViewSettings;
  final double headerCellWidth;

  CalendarView({
    required this.timeSlotViewSettings,
    required this.headerCellWidth,
  });

  final _linePainter = Paint();
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final cellBorderSide = timeSlotViewSettings.cellBorderSide;
    final showEndTime = timeSlotViewSettings.showEndTime;
    final showStartTime = timeSlotViewSettings.showStartTime;
    final timeIntervalHeight = timeSlotViewSettings.timeIntervalHeight;

    _linePainter
      ..color = cellBorderSide.color
      ..strokeWidth = cellBorderSide.width;

    double startXPosition = 0.0;

    // horiontal line
    canvas.drawLine(
      Offset(startXPosition, 0),
      Offset(startXPosition, height),
      _linePainter,
    );

    for (var i = 0; i < timeSlotViewSettings.horizontalLinesCount; i++) {
      startXPosition += headerCellWidth;
      canvas.drawLine(
        Offset(startXPosition, 0),
        Offset(startXPosition, height),
        _linePainter,
      );
    }

    final textHeight = timeSlotViewSettings.textSize.height;
    double startYPosition = 0.0;
    if (!showStartTime) {
      startYPosition = -textHeight / 2;
    }

    //  vertical line
    for (var i = 0; i < timeSlotViewSettings.timeLineCount + (showEndTime ? 1 : 0); i++) {
      var lineYPosition = startYPosition + textHeight / 2;
      if (i == timeSlotViewSettings.timeLineCount + (showEndTime ? 1 : 0) - 1) {
        lineYPosition =
            lineYPosition - timeIntervalHeight / timeSlotViewSettings.timeIntervalInMinutes;
      }
      canvas.drawLine(
        Offset(0, lineYPosition),
        Offset(size.width, lineYPosition),
        _linePainter,
      );

      startYPosition += timeIntervalHeight;
    }
  }

  @override
  bool shouldRepaint(covariant CalendarView oldDelegate) {
    return oldDelegate.timeSlotViewSettings != timeSlotViewSettings ||
        oldDelegate.headerCellWidth != headerCellWidth;
  }
}
