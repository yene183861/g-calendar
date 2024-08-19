import 'package:flutter/material.dart';

class TimeSlotViewSettings {
  final Duration timeInterval;
  final double timeIntervalHeight;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  final BorderSide cellBorderSide;

  final bool showEndTime;

  final bool showStartTime;

  /// show time zone (GMT+00) instead of start time (12:00 am), default true
  final bool showTimeZone;

  ///
  final double timeRulerSize;

  /// time display format, default HH:mm
  final String timeFormat;
  final TextStyle timeTextStyle;

  final int horizontalLinesCount;

  TimeSlotViewSettings({
    this.timeInterval = const Duration(minutes: 60),
    this.timeIntervalHeight = 60,
    this.startTime = const TimeOfDay(hour: 8, minute: 0),
    this.endTime = const TimeOfDay(hour: 20, minute: 0),
    this.cellBorderSide = const BorderSide(width: 0.2, color: Colors.black54),
    this.showEndTime = false,
    this.showStartTime = false,
    this.showTimeZone = true,
    this.timeRulerSize = 80,
    this.timeFormat = 'HH:mm',
    this.timeTextStyle = const TextStyle(
      color: Colors.grey,
      fontSize: 12,
    ),
    this.horizontalLinesCount = 6,
  }) {
    assert(timeInterval.inMinutes > 0, 'Minimum timeInterval is 1 minute');
    // assert(timeRulerSize >= 0);
  }

  int get totalMinutes => 24 * 60;

  /// caculate actual time interval base on [timeInterval]
  int get timeIntervalInMinutes {
    final timeIntervalMinutes = timeInterval.inMinutes;
    if (timeIntervalMinutes >= 0 && timeIntervalMinutes <= totalMinutes) {
      if (totalMinutes % timeIntervalMinutes == 0) {
        return timeIntervalMinutes;
      }
      return _getNearestTimeValue(totalMinutes, timeIntervalMinutes);
    } else {
      return 60;
    }
  }

  int _getNearestTimeValue(int totalMinutes, int timeIntervalMinutes) {
    final nextIntervalMinutes = timeIntervalInMinutes + 1;
    if (totalMinutes % nextIntervalMinutes == 0) return nextIntervalMinutes;
    return _getNearestTimeValue(totalMinutes, timeIntervalMinutes);
  }

  int get timeLineCount {
    return totalMinutes ~/ timeIntervalInMinutes;
  }

  double get _totalTimeHeight => timeIntervalHeight * timeLineCount;

  double get totalTimeRulerHeight {
    if (timeIntervalHeight < 0) return 0;
    final halfTextHeight = textSize.height / 2;
    var diff = (showEndTime ? halfTextHeight - minuteHeight : 0.0) +
        (showStartTime ? halfTextHeight : 0.0);

    return _totalTimeHeight + diff;
  }

  double get minuteHeight {
    return timeIntervalHeight / timeIntervalInMinutes;
  }

  Size get textSize {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: '', style: timeTextStyle),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(
        minWidth: 0,
        maxWidth: double.maxFinite,
      );
    return textPainter.size;
  }

  /// y-axis offset of time
  double getYPositionTime({required Duration durationTime}) {
    final minutes = durationTime.inMinutes;

    return minutes / totalMinutes * _totalTimeHeight;
  }
}
