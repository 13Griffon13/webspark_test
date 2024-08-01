part of 'fields_cubit.dart';

@freezed
class FieldsState with _$FieldsState {
  const factory FieldsState.initial() = _Initial;

  const factory FieldsState.loading(double progress) = _Loading;

  const factory FieldsState.calculating(double progress) = _Calculating;

  const factory FieldsState.calculated(
    List<DataModel> fields,
    List<ResultModel> results,
  ) = _Calculated;

  const factory FieldsState.uploading(
    double progress,
  ) = _Uploading;

  const factory FieldsState.uploaded(
    List<DataModel> fields,
    List<ResultModel> results,
  ) = _Uploaded;

  const factory FieldsState.error(String exception) = _Error;
}
