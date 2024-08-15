part of 'g_calendar_bloc.dart';

abstract class GCalendarEvent extends Equatable {}

class GCalendarChangeViewEvent extends GCalendarEvent {
  final CalendarViewMode viewMode;

  GCalendarChangeViewEvent(this.viewMode);

  @override
  List<Object?> get props => [viewMode];
}
