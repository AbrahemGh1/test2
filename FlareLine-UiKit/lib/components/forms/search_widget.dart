library flareline_uikit;

import 'package:flareline_uikit/components/forms/outborder_text_form_field.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController? controller;

  final String hintText;

  const SearchWidget({super.key, this.controller, this.hintText = 'ابحث'});

  @override
  Widget build(BuildContext context) {
    return OutBorderTextFormField(
      icon: const Icon(
        Icons.search_rounded,
        color: Color(
          0xFF68738D,
        ),
        size: 24,
      ),
      hintText: hintText,
      controller: controller,
    );
  }
}
