part of 'g_calendar_bloc.dart';

class GCalendarState extends Equatable {
  final CalendarViewMode viewMode;
  final DateTime startDate;
  final DateTime endDate;

  const GCalendarState({
    this.viewMode = CalendarViewMode.day,
    required this.startDate,
    required this.endDate,
  });

  GCalendarState copyWith({
    CalendarViewMode? viewMode,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return GCalendarState(
      viewMode: viewMode ?? this.viewMode,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  List<Object?> get props => [
        viewMode,
        startDate,
        endDate,
      ];
}
