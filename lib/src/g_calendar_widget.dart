import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_calendar/src/bloc/g_calendar_bloc.dart';
import 'package:g_calendar/src/settings/header_view_settings.dart';
import 'package:g_calendar/src/settings/time_slot_view_settings.dart';
import 'package:g_calendar/src/util/date_time_util.dart';

import 'data/enum_type/enums.dart';
import 'settings/calendar_theme.dart';
import 'show_log.dart';
import 'view/calendar_view.dart';
import 'view/current_time_indicator.dart';
import 'view/time_ruler_view.dart';

class GCalendarWidget extends StatelessWidget {
  const GCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GCalendarBloc(),
      child: _GCalendarBody(),
    );
  }
}

class _GCalendarBody extends StatefulWidget {
  const _GCalendarBody({
    super.key,
    this.theme = const CalendarTheme.light(),
    this.timeSlotViewSettings,
    this.headerViewSettings = const HeaderViewSettings(),
  });
  final CalendarTheme theme;
  final TimeSlotViewSettings? timeSlotViewSettings;
  final HeaderViewSettings headerViewSettings;

  @override
  State<_GCalendarBody> createState() => __GCalendarBodyState();
}

class __GCalendarBodyState extends State<_GCalendarBody> {
  late ScrollController timeScrollController;
  late ScrollController dayScrollController;

  late TimeSlotViewSettings timeSlotViewSettings;

  @override
  void initState() {
    super.initState();
    timeSlotViewSettings = widget.timeSlotViewSettings ?? TimeSlotViewSettings();
    timeScrollController = ScrollController();
    dayScrollController = ScrollController();
    dayScrollController.addListener(_listenDayScrollController);
  }

  @override
  void dispose() {
    dayScrollController.removeListener(_listenDayScrollController);
    timeScrollController.dispose();
    dayScrollController.dispose();
    super.dispose();
  }

  void _listenDayScrollController() {
    if (!dayScrollController.hasClients) return;
    final offset = dayScrollController.offset;
    showLog('offset: $offset');
    // timeScrollController.jumpTo(offset);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        final timeRulerSize = timeSlotViewSettings.timeRulerSize;
        final headerViewHeight = widget.headerViewSettings.headerViewHeight;
        return Container(
          color: widget.theme.backgroundColor,
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: headerViewHeight,
                width: width,
                child: Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: timeRulerSize),
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.center,
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
                      child: Text('+'),
                    ),
                    Flexible(
                      child: BlocBuilder<GCalendarBloc, GCalendarState>(
                        buildWhen: (p, c) => p.viewMode != c.viewMode,
                        builder: (context, state) {
                          switch (state.viewMode) {
                            case CalendarViewMode.day:
                              //   return SingleChildScrollView(
                              //     child: Column(
                              //       mainAxisSize: MainAxisSize.min,
                              //       children: [
                              //         Text(
                              //           DateTimeUtil.formatDateTimeToString(
                              //             datetime: DateTime.now(),
                              //             pattern: DateTimePattern.dayPattern,
                              //           ).toUpperCase(),
                              //           style: widget.headerViewSettings.dayTextStyle,
                              //         ),
                              //         Container(
                              //           padding: const EdgeInsets.all(12),
                              //           decoration: const BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: Colors.blueAccent,
                              //           ),
                              //           child: Text(
                              //             DateTime.now().day.toString(),
                              //             style: widget.headerViewSettings.dateTextStyle,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   );
                              // case CalendarViewMode.week:
                              double headerCellWidth = min(
                                max((width - timeRulerSize) / 7,
                                    widget.headerViewSettings.headerCellWidth),
                                (width - timeRulerSize) / 3,
                              );
                              final date = List.generate(
                                7,
                                (index) => DateTime.now().date.add(Duration(days: index)),
                              );
                              return ListView.builder(
                                itemCount: date.length,
                                scrollDirection: Axis.horizontal,
                                controller: dayScrollController,
                                itemBuilder: (context, index) => SizedBox(
                                  width: headerCellWidth,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          DateTimeUtil.formatDateTimeToString(
                                            datetime: date[index],
                                            pattern: DateTimePattern.dayPattern,
                                          ).toUpperCase(),
                                          style: widget.headerViewSettings.dayTextStyle,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blueAccent,
                                          ),
                                          child: Text(
                                            date[index].day.toString(),
                                            style: widget.headerViewSettings.dateTextStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );

                            default:
                              return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final calendarView = constraints.maxWidth - timeRulerSize;
                    final totalTimeRulerHeight = timeSlotViewSettings.totalTimeRulerHeight;
                    double headerCellWidth = min(
                      max((width - timeRulerSize) / 7, widget.headerViewSettings.headerCellWidth),
                      (width - timeRulerSize) / 3,
                    );
                    return RawScrollbar(
                      controller: timeScrollController,
                      thumbVisibility: true,
                      thickness: 8,
                      radius: const Radius.circular(8),
                      thumbColor: Colors.grey.shade400,
                      child: Scrollbar(
                        controller: dayScrollController,
                        thumbVisibility: true,
                        trackVisibility: true,
                        thickness: 8,
                        radius: const Radius.circular(8),
                        // thumbColor: Colors.grey.shade400,

                        scrollbarOrientation: ScrollbarOrientation.bottom,

                        child: ListView(
                          primary: false,
                          controller: timeScrollController,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Stack(
                              children: [
                                Row(
                                  children: [
                                    CustomPaint(
                                      size: Size(timeRulerSize, totalTimeRulerHeight),
                                      painter: TimeRulerView(
                                        timeSlotViewSettings: timeSlotViewSettings,
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomPaint(
                                        size: Size(calendarView, totalTimeRulerHeight),
                                        painter: CalendarView(
                                          timeSlotViewSettings: timeSlotViewSettings,
                                          headerCellWidth: headerCellWidth,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  left: timeSlotViewSettings.timeRulerSize,
                                  child: CustomPaint(
                                    size: Size(calendarView, totalTimeRulerHeight),
                                    painter: CurrentTimeIndicator(
                                        timeSlotViewSettings: timeSlotViewSettings,
                                        repaintNotifier:
                                            context.read<GCalendarBloc>().currentTimeNotifier,
                                        showCurrentTimeText: false,
                                        todayTextColor: Colors.white,
                                        todayHighlightColor: Colors.redAccent),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
