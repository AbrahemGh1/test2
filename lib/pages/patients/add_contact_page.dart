import 'package:flareline_crm/core/theme/crm_colors.dart';
import 'package:flareline_uikit/components/buttons/button_widget.dart';
import 'package:flareline_uikit/components/forms/drop_zone_widget.dart';
import 'package:flareline_uikit/components/forms/outborder_text_form_field.dart';
import 'package:flareline_uikit/components/image/image_widget.dart';
import 'package:flareline_uikit/components/modal/modal_dialog.dart';
import 'package:flareline_uikit/components/tables/table_widget.dart';
import 'package:flareline_uikit/core/mvvm/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import 'date_picker_widget.dart';

class ScrollInjector extends StatelessWidget {
  const ScrollInjector({
    Key? key,
    required this.child,
    required this.groupingType,
  }) : super(key: key);

  final Widget child;
  final GroupingType groupingType;

  @override
  Widget build(BuildContext context) {
    if (groupingType == GroupingType.row) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: child,
      );
    }
    return child;
  }
}

class AddPatientPage extends BaseWidget<AddContactViewModel> {
  AddPatientPage({super.key});

  final controller = GroupButtonController();

  @override
  Widget bodyWidget(
      BuildContext context, AddContactViewModel viewModel, Widget? child) {
    return ButtonWidget(
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
                Row(
                  children: [
                    Expanded(child: textFieldWidget('الاسم', 'first_name.svg')),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: textFieldWidget('العائلة', 'first_name.svg'))
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                textFieldWidget('اسم المستخدم', 'email.svg'),
                const SizedBox(
                  height: 12,
                ),
                textFieldWidget('كلمة المرور', 'lock.svg'),
                const SizedBox(
                  height: 12,
                ),
                textFieldWidget('رقم الهاتف', 'tel.svg'),
                const SizedBox(
                  height: 12,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DatePickerWidget(),
                    ]),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const Text(
                      'القسم',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 12),
                    ScrollInjector(
                      groupingType: GroupingType.wrap,
                      child: GroupButton(
                        buttons: const [
                          'رجال',
                          'نساء',
                          'اطفال',
                        ],
                        controller: GroupButtonController(selectedIndex: 0),
                        options: GroupButtonOptions(
                          selectedShadow: const [],
                          unselectedShadow: const [],
                          unselectedColor: Colors.grey[300],
                          unselectedTextStyle: TextStyle(
                            color: Colors.grey[600],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onSelected: (val, i, selected) =>
                            debugPrint('Button: $val index: $i $selected'),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'أضف صورة لشعار العمل الخاص بجهة الاتصال الخاصة بك',
                    style: TextStyle(color: CrmColors.paragraph, fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 120,
                  child: DropZoneWidget(
                    text: const Text(
                      'Select or Drop File',
                      style: TextStyle(fontSize: 14, color: CrmColors.primary),
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
    );
  }

  Widget textFieldWidget(String hint, String svg) {
    return OutBorderTextFormField(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14, color: CrmColors.paragraph),
        icon: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: ImageWidget(
            imageUrl: 'assets/crm/$svg',
            width: 20,
            height: 20,
          ),
        ));
  }

  @override
  AddContactViewModel viewModelBuilder(BuildContext context) {
    return AddContactViewModel(context);
  }
}

class AddContactViewModel extends BaseTableProvider {
  AddContactViewModel(super.context);

  @override
  Future loadData(BuildContext context) {
    return Future.value({});
  }
}
