class TimeSlotViewSettings {
  final Duration timeInterval;
  final double timeIntervalHeight;
  final double timeIntervalWidth;
  final int startHour;
  final int endHour;

  final String timeFormat;

  final List<int> nonWorkingDays;

  /// number of days displayed on the calendar (Not effective with [CalendarViewMode.day] view mode)
  final int numberOfDaysInView;

  TimeSlotViewSettings({
    this.timeInterval = const Duration(minutes: 60),
    this.timeIntervalHeight = 60,
    this.timeIntervalWidth = 100,
    this.startHour = 0,
    this.endHour = 0,
    this.timeFormat = 'HH:mm',
    this.nonWorkingDays = const [],
    this.numberOfDaysInView = 7,
  }) {
    assert(timeIntervalHeight >= 0 && timeIntervalWidth >= 0);
    assert(
        startHour >= 0 && startHour <= 23 && endHour >= 0 && endHour <= 23 && startHour <= endHour);
    assert(numberOfDaysInView > 0 && numberOfDaysInView < 7);
  }
}
