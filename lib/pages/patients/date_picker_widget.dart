import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flareline_uikit/core/theme/flareline_colors.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  String label;
  DatePickerWidget({super.key, this.label = "تاريخ التعين"});

  final ValueNotifier<String> dateNotifier = ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () async {
              List<DateTime?>? results = await showCalendarDatePicker2Dialog(
                context: context,
                config: CalendarDatePicker2WithActionButtonsConfig(),
                dialogSize: const Size(325, 400),
                borderRadius: BorderRadius.circular(15),
              );

              dateNotifier.value = (results != null && results!.isNotEmpty
                  ? (results
                          .elementAt(0)
                          ?.toLocal()
                          .toString()
                          .substring(0, 10) ??
                      '')
                  : "");
            },
            child: ValueListenableBuilder(
                valueListenable: dateNotifier,
                builder: (c, val, child) {
                  return Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: FlarelineColors.border, width: 1)),
                      child: Row(
                        children: [
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.calendar_month,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(val),
                          ),
                        ],
                      ));
                }))
      ],
    );
  }
}
