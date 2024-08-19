import 'package:flutter/material.dart';
import 'package:g_calendar/src/settings/time_slot_view_settings.dart';
import 'package:g_calendar/src/util/date_time_util.dart';

class CurrentTimeIndicator extends CustomPainter {
  final TimeSlotViewSettings timeSlotViewSettings;
  final Color todayHighlightColor;
  final Color todayTextColor;
  final bool showCurrentTimeText;

  CurrentTimeIndicator({
    required this.timeSlotViewSettings,
    this.todayHighlightColor = Colors.black,
    this.todayTextColor = Colors.white,
    ValueNotifier<int>? repaintNotifier,
    this.showCurrentTimeText = false,
  }) : super(repaint: repaintNotifier);

  final _textPainter = TextPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final width = timeSlotViewSettings.timeRulerSize * 0.8;

    final now = DateTime.now();
    final paint = Paint()
      ..color = todayHighlightColor
      ..style = PaintingStyle.fill
      ..strokeWidth = timeSlotViewSettings.cellBorderSide.width;

    double startYPosition = 0.0;

    if (timeSlotViewSettings.showStartTime) {
      startYPosition = timeSlotViewSettings.textSize.height / 2;
    }

    final duration = Duration(hours: now.hour, minutes: now.minute);
    double yPosition = startYPosition +
        timeSlotViewSettings.getYPositionTime(
          durationTime: duration,
        );
    canvas.drawLine(Offset(0, yPosition), Offset(size.width, yPosition), paint);

    if (showCurrentTimeText) {
      String time = DateTimeUtil.formatDateTimeToString(
          datetime: now, pattern: timeSlotViewSettings.timeFormat);
      time = time.toLowerCase();

      final textSpan = TextSpan(
          text: time,
          style: timeSlotViewSettings.timeTextStyle.copyWith(
            color: todayTextColor,
          ));

      _textPainter
        ..textDirection = TextDirection.ltr
        ..text = textSpan
        ..textScaler = TextScaler.noScaling
        ..layout(
          maxWidth: size.width,
          minWidth: 0,
        );

      final height = _textPainter.height + 8;

      canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(-width, yPosition - height / 2, width, height),
            const Radius.circular(12),
          ),
          paint);
      _textPainter.paint(
          canvas, Offset(-width / 2 - _textPainter.width / 2, yPosition - _textPainter.height / 2));
      return;
    }
    canvas.drawCircle(Offset(0, yPosition), 5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
