import 'package:flareline_crm/helper/therapist.dart';

class DataTransformer {
  // Transform the list of therapists into the required JSON format
  Map<String, dynamic> transformData(List<Therapist> therapists) {
    // Define the headers as specified in the output format
    List<Map<String, dynamic>> headers = [
      {"columnName": "الاسم"},
      {"columnName": "العائلة", "align": "center"},
      {"columnName": "الهاتف", "align": "center"},
      {"columnName": "تاريخ التوظيف", "align": "center"},
      {"columnName": "القسم", "align": "center"},
      {"columnName": "إجراءات", "align": "center"}
    ];

    // Define the rows
    List<List<Map<String, dynamic>>> rows = therapists.map((therapist) {
      return [
        {"columnName": "الاسم", "text": therapist.firstName},
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
          "text": "Department ${therapist.departmentId}",
          "align": "center"
        },
        {"columnName": "إجراءات", "dataType": "action", "align": "center"}
      ];
    }).toList();

    return {
      "headers": headers,
      "rows": rows,
    };
  }
}
