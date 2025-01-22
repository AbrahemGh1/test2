import 'package:flareline_uikit/components/buttons/button_widget.dart';
import 'package:flareline_uikit/components/forms/drop_zone_widget.dart';
import 'package:flareline_uikit/components/forms/outborder_text_form_field.dart';
import 'package:flareline_uikit/components/image/image_widget.dart';
import 'package:flareline_uikit/components/modal/modal_dialog.dart';
import 'package:flareline_uikit/components/tables/table_widget.dart';
import 'package:flareline_uikit/entity/table_data_entity.dart';
import 'package:flutter/material.dart';

import '../../core/theme/crm_colors.dart';
import '../crm_layout.dart';
import '../patients/date_picker_widget.dart';

class CostPage extends CrmLayout {
  const CostPage({super.key});

  // TODO: implement backgroundColor
  Color? get backgroundColor => Colors.white;

  @override
  String breakTabTitle(BuildContext context) {
    return "المصارف";
  }

  @override
  Widget contentDesktopWidget(BuildContext context) {
    // TODO: implement contentDesktopWidget
    return SizedBox(height: 400, width: 1000, child: SessionHistoryTable());
  }
}

class SessionHistoryTable extends TableWidget<SessionHistoryModel> {
  SessionHistoryTable({super.key});

  @override
  // TODO: implement showCheckboxColumn
  bool get showCheckboxColumn => false;

  @override
  SessionHistoryModel viewModelBuilder(BuildContext context) {
    return SessionHistoryModel(context);
  }

  Widget? toolsWidget(BuildContext context, SessionHistoryModel viewModel) {
    return SizedBox(
      child: Row(
        children: [
          SizedBox(
            width: 150,
            height: 48,
            child: ButtonWidget(
              btnText: 'اضافة +',
              type: ButtonType.primary.type,
              onTap: () {
                ModalDialog.show(
                    context: context,
                    title: 'اضافة',
                    titleAlign: Alignment.centerLeft,
                    showTitle: true,
                    modalType: ModalType.medium,
                    showCancel: true,
                    width: 600,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: textFieldWidget(
                            'اسم امصروف',
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                            height: 50, child: textFieldWidget('التفاصيل')),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 150,
                                child: DatePickerWidget(
                                  label: '',
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const SizedBox(
                                width: 150,
                                height: 50,
                                child: OutBorderTextFormField(
                                  keyboardType: TextInputType.number,
                                  hintText: 'المبلغ',
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: CrmColors.paragraph),
                                ),
                              )
                            ]),
                        const Divider(
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: const Text(
                            'أضف فاتورة',
                            style: TextStyle(
                                color: CrmColors.paragraph, fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 120,
                          child: DropZoneWidget(
                            text: const Text(
                              'حدد الملف أو أسقطه',
                              style: TextStyle(
                                  fontSize: 14, color: CrmColors.primary),
                            ),
                            icon: const ImageWidget(
                              imageUrl: 'assets/crm/upload.svg',
                              width: 23,
                              height: 23,
                            ),
                          ),
                        )
                      ],
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget textFieldWidget(String hint) {
    return OutBorderTextFormField(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14, color: CrmColors.paragraph),
    );
  }

  @override
  Widget? customWidgetsBuilder(BuildContext context,
      TableDataRowsTableDataRows columnData, SessionHistoryModel viewModel) {
    if (columnData.columnName == 'فواتير') {
      return _billsInCell(columnData.text ?? '');
    }
    return null;
  }

  Widget? _billsInCell(String text) {
    // Split the input string by spaces
    List<String> bills = text.split(' ');

    // Create a list of widgets (each Text widget wrapped in an InkWell for click functionality)
    List<Widget> textWidgets = bills.map((bill) {
      return InkWell(
        onTap: () {
          // Handle the tap (e.g., print the bill or perform an action)
          print('Tapped on: $bill');
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            bill,
            style: const TextStyle(
              color: Color(0xFF3B82F6),
              fontFamily: 'almarai',
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }).toList();

    // Return the Wrap widget containing the list of Text widgets
    return Wrap(
      children: textWidgets,
    );
  }
}

class SessionHistoryModel extends BaseTableProvider {
  @override
  String get TAG => 'SessionHistoryModel';

  SessionHistoryModel(super.context);

  Future loadData(BuildContext context) async {
    //List<Patient> patients = await DataFetcher().fetchPatientsListFromApi();
    const headers = ["التاريخ", "الاسم", "مقدار", "تفاصيل", "فواتير"];
    List rows = [];
    for (int i = 0; i < 10; i++) {
      List<List<Map<String, dynamic>>> list = [];
      List<Map<String, dynamic>> row = [];
      row.add({'text': '1-2-2024', 'columnName': "التاريخ"});
      row.add({'text': 'رواتب', 'columnName': 'الاسم'});
      row.add({'text': '2350 JD', 'columnName': 'مقدار'});
      row.add({'text': 'راتب شهر 2', 'columnName': "تفاصيل"});
      row.add({
        'text': 'فاتورة123 فاتورة24',
        'columnName': "فواتير",
        'dataType': 'custom'
      });
      list.add(row);
      rows.addAll(list);
    }
    Map<String, dynamic> map = {'headers': headers, 'rows': rows};
    TableDataEntity data = TableDataEntity.fromJson(map);
    tableDataEntity = data;
  }
}
