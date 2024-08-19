import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtil {
  static String formatDateTimeToString(
      {required DateTime datetime, String? pattern, String? locale}) {
    return DateFormat(pattern ?? DateTimePattern.datePattern, locale).format(datetime);
  }
}

class DateTimePattern {
  /// yyyy-MM-dd
  static String datePattern = 'yyyy-MM-dd';

  /// EE
  static String dayPattern = 'EE';
}

extension DateTimeExt on DateTime {
  bool get isToday {
    final now = DateTime.now();
    if (year == now.year && month == now.month && day == now.day) {
      return true;
    }
    return false;
  }

  DateTime get date {
    return DateTime(year, month, day);
  }
}

extension TimeOfDayExt on TimeOfDay {
  int get getMinutes {
    return hour * 60 + minute;
  }
}
