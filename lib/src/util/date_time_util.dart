import 'package:intl/intl.dart';

class DateTimeUtil {
  String formatDateTimeToString({required DateTime datetime, String? pattern, String? locale}) {
    return DateFormat(pattern ?? DateTimePattern.datePattern, locale).format(datetime);
  }
}

class DateTimePattern {
  /// yyyy-MM-dd
  static String datePattern = 'yyyy-MM-dd';
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
