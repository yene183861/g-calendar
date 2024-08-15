import 'package:flutter/material.dart';
import 'package:g_calendar/src/util/date_time_util.dart';

class TimeSlotViewSettings {
  final Duration timeInterval;
  final double timeIntervalHeight;
  // final double timeIntervalWidth;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  final String timeFormat;

  // final List<int> nonWorkingDays;

  // /// number of days displayed on the calendar (Not effective with [CalendarViewMode.day] view mode)
  // final int numberOfDaysInView;

  final double timeRulerSize;

  TimeSlotViewSettings({
    this.timeInterval = const Duration(minutes: 30),
    this.timeIntervalHeight = 60,
    // this.timeIntervalWidth = 100,
    this.startTime = const TimeOfDay(hour: 8, minute: 0),
    this.endTime = const TimeOfDay(hour: 20, minute: 0),
    this.timeFormat = 'HH:mm',
    // this.nonWorkingDays = const [],
    // this.numberOfDaysInView = 7,

    this.timeRulerSize = 76,
  }) {
    assert(timeIntervalHeight >= 0);

    // assert(numberOfDaysInView > 0 && numberOfDaysInView < 7);
    assert(timeRulerSize >= 0);

    assert(endTime.getMinutes >= startTime.getMinutes);
  }

  int get totalMinutes => 24 * 60;

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
}
