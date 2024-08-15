import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_calendar/src/data/enum_type/enums.dart';

part 'g_calendar_event.dart';
part 'g_calendar_state.dart';

class GCalendarBloc extends Bloc<GCalendarEvent, GCalendarState> {
  GCalendarBloc() : super(const GCalendarState()) {
    on<GCalendarChangeViewEvent>(_onChangeViewEvent);
  }

  void _onChangeViewEvent(GCalendarChangeViewEvent event, Emitter<GCalendarState> emit) {
    emit(state.copyWith(viewMode: event.viewMode));
  }
}
