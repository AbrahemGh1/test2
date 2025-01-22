import 'dart:math';

import '../models/therapist.dart';

class DataTransformer {
  // Transform the list of therapists into the required JSON format
  Map<String, dynamic> transformData(List<Therapist> therapists) {
    // Define the headers as specified in the output format
    List<Map<String, dynamic>> headers = [
      {"columnName": "الاسم", "align": "center"},
      {"columnName": "العائلة", "align": "center"},
      {"columnName": "الهاتف", "align": "center"},
      {"columnName": "تاريخ التوظيف", "align": "center"},
      {"columnName": "القسم", "align": "center"},
      {"columnName": "إجراءات", "align": "center"}
    ];
    List<List<Map<String, dynamic>>> rows = therapists.map((therapist) {
      return [
        {
          "columnName": "الاسم",
          "data": {
            "name": therapist.firstName,
            "avatar": _getRandomImagePath()
          },
          "dataType": "custom",
          "align": "center"
        },
        {
          "columnName": "العائلة",
          "text": therapist.lastName,
          "align": "center"
        },
        {
          "columnName": "الهاتف",
          "text": therapist.phoneNumber,
          "align": "center"
        },
        {
          "columnName": "تاريخ التوظيف",
          "text": therapist.hiringDate,
          "align": "center"
        },
        {
          "columnName": "القسم",
          "text": departmentIdAsAString(therapist),
          "align": "center",
          "dataType": "custom",
        },
        {"columnName": "إجراءات", "dataType": "action", "align": "center"}
      ];
    }).toList();

    return {
      "headers": headers,
      "rows": rows,
    };
  }

  String departmentIdAsAString(Therapist therapist) {
    if (therapist.departmentId == 1) {
      return "رجال";
    } else if (therapist.departmentId == 2) {
      return "اطفال";
    }
    return "نساء";
  }

  _getRandomImagePath() {
    return 'assets/profile_image/therapist_profile_picture_${generateRandomNumber()}.jpg';
  }

  int generateRandomNumber() {
    return Random().nextInt(4) + 1; // Generates a random number between 1 and 4
  }
}
