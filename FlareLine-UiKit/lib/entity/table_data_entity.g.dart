// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableDataEntity _$TableDataEntityFromJson(Map<String, dynamic> json) {
  return TableDataEntity()
    ..headers = (json['headers'] as List<dynamic>?)?.map((e) {
      return e;
    }).toList()
    ..rows = (json['rows'] as List<dynamic>?)
        ?.map((e) => (e as List<dynamic>)
            .map((e) =>
                TableDataRowsTableDataRows.fromJson(e as Map<String, dynamic>))
            .toList())
        .toList();
}

Map<String, dynamic> _$TableDataEntityToJson(TableDataEntity instance) =>
    <String, dynamic>{
      'headers': instance.headers,
      'rows': instance.rows,
    };

TableDataRowsTableDataRows _$TableDataRowsTableDataRowsFromJson(
        Map<String, dynamic> json) =>
    TableDataRowsTableDataRows()
      ..text = json['text'] as String?
      ..dataType = json['dataType'] as String?
      ..tagType = json['tagType'] as String?
      ..columnName = json['columnName'] as String?
      ..align = json['align'] as String?
      ..data = json['data']
      ..id = json['id'] as String?;

Map<String, dynamic> _$TableDataRowsTableDataRowsToJson(
        TableDataRowsTableDataRows instance) =>
    <String, dynamic>{
      'text': instance.text,
      'dataType': instance.dataType,
      'tagType': instance.tagType,
      'columnName': instance.columnName,
      'align': instance.align,
      'data': instance.data,
      'id': instance.id,
    };
