import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_calendar/src/data/enum_type/enums.dart';
import 'package:g_calendar/src/util/date_time_util.dart';

part 'g_calendar_event.dart';
part 'g_calendar_state.dart';

class GCalendarBloc extends Bloc<GCalendarEvent, GCalendarState> {
  GCalendarBloc()
      : super(GCalendarState(
          startDate: DateTime.now().date,
          endDate: DateTime.now().date,
        )) {
    on<GCalendarChangeViewEvent>(_onChangeViewEvent);

    final now = DateTime.now();
    currentTimeNotifier = ValueNotifier<int>(now.minute);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (now.minute != currentTimeNotifier.value) {
        currentTimeNotifier.value = now.minute;
      }
    });
  }

  late ValueNotifier<int> currentTimeNotifier;
  late Timer timer;
  @override
  Future<void> close() {
    timer.cancel();
    currentTimeNotifier.dispose();
    return super.close();
  }

  void _onChangeViewEvent(GCalendarChangeViewEvent event, Emitter<GCalendarState> emit) {
    emit(state.copyWith(viewMode: event.viewMode));
  }
}
