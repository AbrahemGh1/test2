import 'package:flareline_crm/core/theme/crm_colors.dart';
import 'package:flareline_crm/pages/crm_layout.dart';
import 'package:flareline_uikit/components/buttons/button_widget.dart';
import 'package:flareline_uikit/components/forms/search_widget.dart';
import 'package:flareline_uikit/components/forms/select_widget.dart';
import 'package:flareline_uikit/components/tables/table_widget.dart';
import 'package:flareline_uikit/components/tags/tag_widget.dart';
import 'package:flareline_uikit/entity/table_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../models/patient.dart';
import '../../services/data_fetcher.dart';

class PatientsPage extends CrmLayout {
  const PatientsPage({super.key});

  @override
  // TODO: implement isContentScroll
  bool get isContentScroll => false;

  @override
  String breakTabTitle(BuildContext context) {
    // TODO: implement breakTabTitle
    return 'الزوار';
  }

  @override
  Widget contentDesktopWidget(BuildContext context) {
    return ContactsTableWidget();
  }
}

class ContactsTableWidget extends TableWidget<ContactsViewModel> {
  ContactsTableWidget({super.key});

  @override
  // TODO: implement showCheckboxColumn
  bool get showCheckboxColumn => false;

  @override
  Widget toolsWidget(BuildContext context, ContactsViewModel viewModel) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          ScreenTypeLayout.builder(
            desktop: (context) => const SizedBox(
              width: 280,
              child: SearchWidget(
                hintText: "ابحث عن زائر",
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
                Navigator.of(context).pushNamed('/patientProfilePage');
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool isColumnVisible(String columnName, bool isMobile) {
    if (!isMobile) {
      return true;
    }
    if (isMobile) {
      if ('Contact Name' == columnName || 'Lead Score' == columnName) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget? customWidgetsBuilder(BuildContext context,
      TableDataRowsTableDataRows columnData, ContactsViewModel viewModel) {
    if (columnData.columnName == 'leadScore') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
                color: const Color(0xFFF6FFF5),
                borderRadius: BorderRadius.circular(4)),
            child: TagWidget(
              color: const Color(0xFF5ABE1C),
              text: columnData.text ?? '',
            ),
          )
        ],
      );
    }
    return null;
  }

  _pageWidget(BuildContext context, ContactsViewModel viewModel) {
    return Row(
      children: [
        const Text('Showing'),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          width: 80,
          height: 30,
          child: SelectWidget(
            selectionList: const ['10', '20', '50'],
            onDropdownChanged: (value) {
              viewModel.pageSize = int.parse(value);
            },
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        const Text('of'),
        const SizedBox(
          width: 5,
        ),
        const Text(
          '56',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 5,
        ),
        const Text('of'),
        const SizedBox(
          width: 5,
        ),
        const Text('Results')
      ],
    );
  }

  @override
  ContactsViewModel viewModelBuilder(BuildContext context) {
    return ContactsViewModel(context);
  }

  @override
  Widget? actionWidgetsBuilder(BuildContext context,
      TableDataRowsTableDataRows columnData, ContactsViewModel viewModel) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [MoreActionWidget()],
    );
  }
}

class MoreActionWidget extends StatelessWidget {
  const MoreActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: CrmColors.border, width: 1)),
        child: const Icon(
          Icons.more_horiz,
          size: 20,
        ),
      ),
      onTap: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => const ListItems(),
          onPop: () => print('Popover was popped!'),
          direction: PopoverDirection.left,
          width: 150,
          height: 140,
          arrowHeight: 15,
          arrowWidth: 30,
        );
      },
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/patientProfilePage');
            },
            child: Container(
              height: 50,
              color: CrmColors.green.withOpacity(0.5),
              child: const Center(child: Text('تعدبل')),
            ),
          ),
          const Divider(),
          InkWell(
            child: Container(
              height: 50,
              color: CrmColors.orange.withOpacity(0.5),
              child: const Center(child: Text('حذف')),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}

class ContactsViewModel extends BaseTableProvider {
  @override
  String get TAG => 'ContactsViewModel';

  ContactsViewModel(super.context);

  @override
  Future loadData2(BuildContext context) async {
    const headers = [
      "Contact Name",
      "Last Contacted",
      "Company",
      "Contact",
      "Lead Score"
    ];

    List rows = [];

    for (int i = 0; i < 50; i++) {
      List<List<Map<String, dynamic>>> list = [];
      List<Map<String, dynamic>> row = [];
      var id = i;
      var item = {
        'contactName': 'Tom${id}',
        'lastContacted': '1 Feb, 2020',
        'company': 'Starbucks',
        'contact': 'nathan.roberts@example.com',
        'phone': '(201) 555-0124',
        'leadScore': 'Online store',
      };
      row.add(getItemValue('contactName', item));
      row.add(getItemValue('lastContacted', item));
      row.add(getItemValue('company', item));
      row.add(getItemValue('contact', item));
      row.add(getItemValue(
        'Lead Score',
        item,
        dataType: CellDataType.ACTION.type,
      ));
      list.add(row);
      rows.addAll(list);
    }

    Map<String, dynamic> map = {'headers': headers, 'rows': rows};
    TableDataEntity data = TableDataEntity.fromJson(map);
    tableDataEntity = data;
  }

  Future loadData(BuildContext context) async {
    List<Patient> patients = await DataFetcher().fetchPatientsListFromApi(
        "https://3e0d83b0d6314e3eb29a853957875045.api.mockbin.io/");
    const headers = [
      "الاسم",
      "العائلة",
      "المعالج",
      "القسم",
      "طريقة الدقع",
      "التأمين",
      "سعر الجلسة",
      "الجلسات",
      "الرصيد",
      "إجراءات",
    ];
    List rows = [];
    for (Patient p in patients) {
      List<List<Map<String, dynamic>>> list = [];
      List<Map<String, dynamic>> row = [];
      row.add({'text': p.firstName, 'columnName': 'الاسم'});
      row.add({'text': p.lastName, 'columnName': 'العائلة'});
      row.add({'text': p.therapistName, 'columnName': 'المعالج'});
      row.add({'text': p.departmentId.toString(), 'columnName': 'القسم'});
      row.add(
          {'text': p.paymentMethodId.toString(), 'columnName': "طريقة الدقع"});
      row.add({'text': p.insuranceName.toString(), 'columnName': "التأمين"});
      row.add({'text': p.sessionPrice.toString(), 'columnName': "سعر الجلسة"});
      row.add({
        'text': '${p.numberOfPreviousSessions}/${p.numberOfPreviousSessions}',
        'columnName': "الجلسات"
      });
      row.add({'text': p.balance.toString(), 'columnName': "الرصيد"});
      row.add({"dataType": "action", 'columnName': "إجراءات"});
      list.add(row);
      rows.addAll(list);
    }
    Map<String, dynamic> map = {'headers': headers, 'rows': rows};
    TableDataEntity data = TableDataEntity.fromJson(map);
    tableDataEntity = data;
  }

/*
    {
      'text': text,
      'key': key,
      'dataType': dataType,
      'columnName': key,
      'id': item['id'],
    };
     */
}
