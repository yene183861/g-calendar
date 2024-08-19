import 'package:flutter/material.dart';
import 'package:g_calendar/src/settings/time_slot_view_settings.dart';
import 'package:g_calendar/src/util/date_time_util.dart';

class TimeRulerView extends CustomPainter {
  final TimeSlotViewSettings timeSlotViewSettings;

  TimeRulerView({
    required this.timeSlotViewSettings,
  });

  final _linePainter = Paint();
  final _textPainter = TextPainter();
  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0) return;
    final now = DateTime.now().date;

    _textPainter
      ..textDirection = TextDirection.ltr
      ..textScaler = TextScaler.noScaling;

    _linePainter
      ..color = timeSlotViewSettings.cellBorderSide.color
      ..strokeWidth = timeSlotViewSettings.cellBorderSide.width;

    final timeIntervalInMinutes = timeSlotViewSettings.timeIntervalInMinutes;
    final showEndTime = timeSlotViewSettings.showEndTime;
    final showStartTime = timeSlotViewSettings.showStartTime;

    final timeLineCount = timeSlotViewSettings.timeLineCount + (showEndTime ? 1 : 0);

    final minuteHeight = timeSlotViewSettings.minuteHeight;

    double startYPosition = 0.0;
    double startXPosition = 0.0;
    if (!showStartTime) {
      startYPosition = -timeSlotViewSettings.textSize.height / 2;
    }

    for (var i = 0; i < timeLineCount; i++) {
      final minute = i * timeIntervalInMinutes;

      var date = now.copyWith(minute: minute, hour: 0);
      if (showEndTime && i == timeLineCount - 1) {
        date = date.subtract(const Duration(seconds: 1));
      }
      String time = DateTimeUtil.formatDateTimeToString(
          datetime: date, pattern: timeSlotViewSettings.timeFormat);
      time = time.toLowerCase();
      if (i == 0) {
        if (!showStartTime) {
          time = '';
        } else if (timeSlotViewSettings.showTimeZone) {
          time = 'GMT${DateTime.now().timeZoneName}';
        }
      }

      final textSpan = TextSpan(text: time, style: timeSlotViewSettings.timeTextStyle);

      _textPainter
        ..text = textSpan
        ..layout(
          maxWidth: size.width,
          minWidth: 0,
        );

      startXPosition = (size.width - _textPainter.width) / 2;

      if (showEndTime && i == timeLineCount - 1) {
        startYPosition = startYPosition - minuteHeight;
      }

      _textPainter.paint(canvas, Offset(startXPosition, startYPosition));

      final lineYPosition = startYPosition + _textPainter.height / 2;
      canvas.drawLine(
        Offset(startXPosition + _textPainter.width + 8, lineYPosition),
        Offset(size.width, lineYPosition),
        _linePainter,
      );

      startYPosition += timeSlotViewSettings.timeIntervalHeight;
    }
  }

  @override
  bool shouldRepaint(covariant TimeRulerView oldDelegate) {
    return oldDelegate.timeSlotViewSettings != timeSlotViewSettings;
  }
}
