import 'package:flareline_uikit/components/buttons/button_widget.dart';
import 'package:flareline_uikit/components/forms/outborder_text_form_field.dart';
import 'package:flareline_uikit/components/forms/search_widget.dart';
import 'package:flareline_uikit/components/forms/select_widget.dart';
import 'package:flareline_uikit/components/modal/modal_dialog.dart';
import 'package:flareline_uikit/components/tables/table_widget.dart';
import 'package:flareline_uikit/entity/table_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/theme/crm_colors.dart';
import '../../models/patient.dart';
import '../../services/data_fetcher.dart';
import '../crm_layout.dart';
import 'date_picker_widget.dart';

class PatientsProfilePage extends CrmLayout {
  final int patientId;
  final ValueNotifier<String> selectedPaymentMethod = ValueNotifier('نقد');

  PatientsProfilePage({super.key, required this.patientId});

  @override
  Widget contentDesktopWidget(BuildContext context) {
    return FutureBuilder<Patient>(
      future: DataFetcher().fetchPatientFromApi(patientId),
      // Fetch patient data asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator while waiting for data
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot.error);
          // Show error message if data fetching fails
          Future.delayed(Duration.zero, () {
            // This ensures the Snackbar is shown after the build method completes
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${snapshot.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
          return const Center(child: Text('Failed to load data'));
        } else if (snapshot.hasData) {
          // Once data is fetched, display the patient profile
          Patient patient = snapshot.data!;

          return Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoDivider('معلومات المريض'),
                const SizedBox(height: 40),
                Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "ألاسم",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: 200,
                            height: 50,
                            child: OutBorderTextFormField(
                              initialValue: patient
                                  .firstName, // Set initial value from fetched patient data
                            ),
                          ),
                        ],
                      ),
                    ), // Text label in Arabic
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 125,
                          child: ButtonWidget(
                            btnText: 'حفظ',
                            color: Colors.green,
                            textColor: Colors.white,
                            borderColor: Colors.green,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          width: 125,
                          child: ButtonWidget(
                            btnText: 'الغاء',
                            onTap: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "العائلة",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: OutBorderTextFormField(
                          initialValue: patient
                              .lastName, // Set initial value from fetched patient data
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'القسم',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: SelectWidget(
                          selectionList: const ['رجال', 'نساء', 'اطفال'],
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'طريقة الدفع',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 24),
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: ValueListenableBuilder<String>(
                        valueListenable: selectedPaymentMethod,
                        builder: (BuildContext context, String value,
                            Widget? child) {
                          return SelectWidget(
                            selectionList: const ['تأمين', 'نقد'],
                            textStyle: const TextStyle(fontSize: 12),
                            onDropdownChanged: (value) {
                              selectedPaymentMethod.value = value;
                              print(value);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 30),
                    ValueListenableBuilder<String>(
                      valueListenable: selectedPaymentMethod,
                      builder:
                          (BuildContext context, String value, Widget? child) {
                        String labelString =
                            value == 'تأمين' ? 'نسبة التأمين' : 'سعر الجلسة';
                        return Text(labelString);
                      },
                    ),
                    const SizedBox(width: 20),
                    const SizedBox(
                      width: 100,
                      height: 50,
                      child: OutBorderTextFormField(
                        initialValue:
                            '10', // Set initial value from fetched patient data
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'المعالج',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: SelectWidget(
                          selectionList: const [
                            'محمد شخاترة',
                            'هبة يوسف',
                            'خالد عمر',
                            'رائد الحمدي'
                          ],
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      "عدد الجلسات",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: OutBorderTextFormField(
                        initialValue: '2'
                            .toString(), // Set initial value from fetched patient data
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    _textField(
                      'الملاحظات الطبية',
                      'يعاني من الام الظهر والمرفق',
                      maxlines: 5,
                      false,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 100),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      patient.balance.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                _infoDivider('تاريخ الجلسات'), // Text label in Arabic
                SizedBox(
                  height: 500,
                  child: SessionHistoryTable(),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 125,
                      child: ButtonWidget(
                        btnText: 'حفظ',
                        color: Colors.green,
                        textColor: Colors.white,
                        borderColor: Colors.green,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                        width: 125,
                        child: ButtonWidget(
                          btnText: 'الغاء',
                          //type: ButtonType.primary.type,
                        )),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No patient data found.'));
        }
      },
    );
  }
}

class SessionHistoryTable extends TableWidget<SessionHistoryModel> {
  SessionHistoryTable({super.key});
  final ValueNotifier<String> selectedPaymentMethod = ValueNotifier('نقد');
  @override
  // TODO: implement showCheckboxColumn
  bool get showCheckboxColumn => false;

  @override
  Widget toolsWidget(BuildContext context, SessionHistoryModel viewModel) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          ScreenTypeLayout.builder(
            desktop: (context) => const SizedBox(
              width: 280,
              child: SearchWidget(
                hintText: "ابحث جلسة",
              ),
            ),
            mobile: (context) => const SizedBox.shrink(),
            tablet: (context) => const SizedBox.shrink(),
          ),
          const Spacer(),
          SizedBox(
              width: 150,
              height: 48,
              child: ButtonWidget(
                btnText: 'اضافة +',
                type: ButtonType.primary.type,
                onTap: () {
                  ModalDialog.show(
                      context: context,
                      title: 'اضافة جلسة',
                      titleAlign: Alignment.centerLeft,
                      showTitle: true,
                      modalType: ModalType.medium,
                      showCancel: true,
                      width: 600,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'المعالج',
                            ),
                            const SizedBox(height: 10.0),
                            SelectWidget(selectionList: const [
                              'محمد شخاتره',
                              'هبة يوسف',
                              'رائد الحمدي'
                            ]),
                            const SizedBox(height: 20.0),
                            DatePickerWidget(
                              label: 'تاريخ الجلسة',
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "طريقة الدفع",
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              //width: 400,
                              child: SelectedPaymentMethod(
                                  selectedPaymentMethod: selectedPaymentMethod),
                            ),
                            const SizedBox(height: 20),
                            FittedBox(
                              child: Row(
                                children: [
                                  _textField(
                                    'الملاحظات الطبية',
                                    'لا يوجد اي ملاحظات طبية',
                                    maxlines: 5,
                                    false,
                                  ),
                                ],
                              ),
                            ),
                          ]));
                },
              )),
        ],
      ),
    );
  }

/*
      "تاريخ الجلسة",
      "المعالج",
      "القسم",
      "طريقة الدقع",
      "التأمين",
      "سعر الجلسة",
      "الملاحظات",
 */
  @override
  SessionHistoryModel viewModelBuilder(BuildContext context) {
    return SessionHistoryModel(context);
  }
}

class SelectedPaymentMethod extends StatefulWidget {
  const SelectedPaymentMethod({
    super.key,
    required this.selectedPaymentMethod,
  });

  final ValueNotifier<String> selectedPaymentMethod;

  @override
  State<SelectedPaymentMethod> createState() => _SelectedPaymentMethodState();
}

class _SelectedPaymentMethodState extends State<SelectedPaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: widget.selectedPaymentMethod,
      builder: (BuildContext context, String value, Widget? child) {
        String labelString = value == 'نقد' ? 'سعر الجلسة' : 'نسبة التأمين';
        return Row(
          children: [
            SizedBox(
              width: 100,
              child: SelectWidget(
                selectionList: const ['نقد', 'تأمين'],
                textStyle: const TextStyle(fontSize: 12),
                onDropdownChanged: (value) {
                  widget.selectedPaymentMethod.value = value;
                  print(value);
                },
              ),
            ),
            const SizedBox(width: 20),
            Text(labelString),
            const SizedBox(width: 15),
            const SizedBox(
              width: 50,
              child: OutBorderTextFormField(
                hintText: '10',
              ),
            )
          ],
        );
      },
    );
  }
}

class SessionHistoryModel extends BaseTableProvider {
  @override
  String get TAG => 'SessionHistoryModel';

  SessionHistoryModel(super.context);

  Future loadData(BuildContext context) async {
    List<Patient> patients = await DataFetcher().fetchPatientsListFromApi(
        "https://b66e3c022c014808844fee17a71ba232.api.mockbin.io/");
    const headers = [
      "تاريخ الجلسة",
      "المعالج",
      "القسم",
      "طريقة الدفع",
      "التأمين",
      "سعر الجلسة",
      "الملاحظات",
    ];
    List rows = [];
    for (Patient p in patients) {
      List<List<Map<String, dynamic>>> list = [];
      List<Map<String, dynamic>> row = [];
      row.add({'text': '16-12-2024', 'columnName': "الجلسات"});
      row.add({'text': p.therapistName, 'columnName': 'المعالج'});
      row.add({'text': p.departmentId.toString(), 'columnName': 'القسم'});
      row.add(
          {'text': p.paymentMethodId.toString(), 'columnName': "طريقة الدفع"});
      row.add({'text': p.insuranceName.toString(), 'columnName': "التأمين"});
      row.add({'text': p.sessionPrice.toString(), 'columnName': "سعر الجلسة"});

      row.add({"dataType": "action", 'columnName': "الملاحظات"});
      list.add(row);
      rows.addAll(list);
    }
    Map<String, dynamic> map = {'headers': headers, 'rows': rows};
    TableDataEntity data = TableDataEntity.fromJson(map);
    tableDataEntity = data;
  }
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

_textField(String s, String initialValue, bool isMobile, {int? maxlines = 1}) {
  if (isMobile) {
    return OutBorderTextFormField(
      initialValue: initialValue,
      maxLines: maxlines,
    );
  }
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(s),
      const SizedBox(width: 20),
      SizedBox(
        width: 400,
        child: OutBorderTextFormField(
          initialValue: initialValue,
          maxLines: maxlines,
          textStyle: const TextStyle(fontSize: 14, color: CrmColors.paragraph),
        ),
      ),
    ],
  );
}
