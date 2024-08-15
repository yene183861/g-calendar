import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_calendar/src/bloc/g_calendar_bloc.dart';

import 'data/enum_type/enums.dart';
import 'settings/calendar_theme.dart';
import 'show_log.dart';

class GCalendarWidget extends StatelessWidget {
  const GCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GCalendarBloc(),
      child: const _GCalendarBody(),
    );
  }
}

class _GCalendarBody extends StatefulWidget {
  const _GCalendarBody({
    super.key,
    this.theme = const CalendarTheme.light(),
  });
  final CalendarTheme theme;

  @override
  State<_GCalendarBody> createState() => __GCalendarBodyState();
}

class __GCalendarBodyState extends State<_GCalendarBody> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 2),
                    color: Colors.black26,
                    blurRadius: 2,
                  ),
                  BoxShadow(
                    offset: Offset(-2, -2),
                    color: Colors.black26,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
            BlocBuilder<GCalendarBloc, GCalendarState>(
              buildWhen: (p, c) => p.viewMode != c.viewMode,
              builder: (context, state) {
                switch (state.viewMode) {
                  case CalendarViewMode.day:
                    return Container();
                  default:
                    return Container();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
