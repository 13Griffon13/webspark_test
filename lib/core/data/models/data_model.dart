import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark_task/core/data/models/point.dart';

part 'data_model.freezed.dart';
part 'data_model.g.dart';

@freezed
class DataModel with _$DataModel {
  const factory DataModel({
    required String id,
    required List<String> field,
    required Point start,
    required Point end,
  }) = _DataModel;

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);
}
