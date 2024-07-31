part of 'fields_cubit.dart';

@freezed
class FieldsState with _$FieldsState {
  const factory FieldsState.initial() = _Initial;

  const factory FieldsState.loading() = _Loading;

  const factory FieldsState.calculating(double progress) = _Calculating;

  const factory FieldsState.calculated(
    List<DataModel> fields,
    List<ResultModel> results,
  ) = _Calculated;

  const factory FieldsState.error(String exception) = _Error;
}
