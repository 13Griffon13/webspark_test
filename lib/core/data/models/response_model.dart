import 'package:freezed_annotation/freezed_annotation.dart';

import 'data_model.dart';

part 'response_model.freezed.dart';
part 'response_model.g.dart';

@freezed
class ResponseModel with _$ResponseModel {
  const factory ResponseModel(
      {required bool error,
      required String message,
      List<DataModel>? data}) = _ResponseModel;

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);
}
