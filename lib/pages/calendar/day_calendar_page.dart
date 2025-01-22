import 'dart:math';

import 'package:flareline_crm/core/theme/crm_colors.dart';
import 'package:flareline_crm/pages/crm_layout.dart';
import 'package:flareline_uikit/components/forms/select_widget.dart';
import 'package:flareline_uikit/components/modal/modal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:textformfield_datetime_range_picker/textformfield_datetime_range_picker.dart';

class DayCalendarPage extends CrmLayout {
  DayCalendarPage({super.key});

  @override
  // TODO: implement backgroundColor
  Color? get backgroundColor => Colors.white;

  @override
  // TODO: implement isContentScroll
  bool get isContentScroll => false;

  @override
  String breakTabTitle(BuildContext context) {
    // TODO: implement breakTabTitle
    return 'اليوم';
  }

  @override
  Widget contentDesktopWidget(BuildContext context) {
    return SfCalendar(
      view: CalendarView.day,
      showTodayButton: true,
      showNavigationArrow: true,
      onTap: (calendarTapDetails) {
        if (calendarTapDetails.targetElement.name == 'calendarCell') {
          ModalDialog.show(
              context: context,
              title: 'حجز موعد',
              titleAlign: Alignment.centerLeft,
              showTitle: true,
              modalType: ModalType.medium,
              showCancel: true,
              width: 600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الاسم',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SelectWidget(
                    selectionList: const [
                      'رامي غزلان',
                      'خالد طناش',
                      'ابراهيم عمري'
                    ],
                    textStyle: const TextStyle(fontSize: 12),
                    onDropdownChanged: (value) {
                      print(value);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'المعالج',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SelectWidget(
                    selectionList: const [
                      'خالد يوسف',
                      'هبة عمر',
                      'ابراهيم محمد'
                    ],
                    textStyle: const TextStyle(fontSize: 12),
                    onDropdownChanged: (value) {
                      print(value);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _infoDivider('الوقت'),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormFieldDateTimeRangePicker(
                    selectedOption: DateTimeOption.timeOnly,
                    initialDate: calendarTapDetails.date,
                    initialStartHour: calendarTapDetails.date?.hour,
                    initialEndHour: calendarTapDetails.date?.hour,
                    titleStartTime: const Text('من',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    titleEndTime: const Text('إلى',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  )
                ],
              ));
        }
      },
      timeSlotViewSettings: const TimeSlotViewSettings(
          numberOfDaysInView: 7,
          minimumAppointmentDuration: Duration(minutes: 30)),
      dataSource: MeetingDataSource(_getDataSource()),
      appointmentBuilder: (context, detail) {
        if (detail.appointments.isEmpty) {
          return const SizedBox.shrink();
        }
        dynamic item = detail.appointments.elementAtOrNull(0);
        if (item is Meeting) {
          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: item.background, borderRadius: BorderRadius.circular(8)),
            child: Text(
              item.eventName,
              style: TextStyle(color: item.textColor, fontSize: 12),
            ),
          );
        }
        return const SizedBox.shrink();
      },
      cellBorderColor: CrmColors.border,
      firstDayOfWeek: 1,
    );
  }

  DateTime getWeekStartDate() {
    final now = DateTime.now();
    final startOfWeek = DateTime(now.year, now.month, now.day);
    final daysToAdd = (startOfWeek.weekday - 1) % 7;
    return startOfWeek.subtract(Duration(days: daysToAdd));
  }

  List<Meeting> _getDataSource() {
    final DateTime today = getWeekStartDate();

    DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    DateTime endTime = startTime.add(const Duration(hours: 2));

    final List<Meeting> meetings = List.generate(20, (i) {
      Meeting meeting;
      if (i % 2 == 0 && i % 4 != 0) {
        meeting = Meeting(' احمد ابراهيم', startTime, endTime,
            Color(0xFFE4F5FF), false, Color(0xFF45B2F2));
      } else if (i % 3 == 0) {
        meeting = Meeting('خالد عمر', startTime, endTime, Color(0xFFFFEAD3),
            false, Color(0xFFED9636));
      } else {
        meeting = Meeting('هبة يوسف', startTime, endTime, Color(0xFFE1F3E8),
            false, Color(0xFF16AC50));
      }
      startTime = startTime.add(Duration(hours: 2 + Random().nextInt(10)));
      endTime = startTime.add(Duration(hours: 3 + Random().nextInt(6)));
      return meeting;
    });

    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay,
      this.textColor);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  Color textColor;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}

_infoDivider(String text) {
  return Row(
    children: [
      const Expanded(
          child: Divider(
        color: CrmColors.border,
      )),
      const SizedBox(width: 10),
      Text(
        text,
        style: const TextStyle(
            color: CrmColors.heading, fontWeight: FontWeight.bold),
      ),
      const SizedBox(width: 10),
      const Expanded(
          child: Divider(
        color: CrmColors.border,
      )),
    ],
  );
}
