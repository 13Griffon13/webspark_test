import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark_task/core/data/models/result.dart';

part 'result_model.freezed.dart';
part 'result_model.g.dart';

@freezed
class ResultModel with _$ResultModel {
  const factory ResultModel({
    required String id,
    required Result result,
  }) = _ResultModel;

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);
}
