part of 'g_calendar_bloc.dart';

class GCalendarState extends Equatable {
  final CalendarViewMode viewMode;

  const GCalendarState({
    this.viewMode = CalendarViewMode.day,
  });

  GCalendarState copyWith({
    CalendarViewMode? viewMode,
  }) {
    return GCalendarState(
      viewMode: viewMode ?? this.viewMode,
    );
  }

  @override
  List<Object?> get props => [
        viewMode,
      ];
}
