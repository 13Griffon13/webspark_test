import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark_task/core/data/models/data_model.dart';
import 'package:webspark_task/core/data/models/result_model.dart';
import 'package:webspark_task/core/domain/repos/fields_repo.dart';

part 'fields_cubit.freezed.dart';
part 'fields_state.dart';

class FieldsCubit extends Cubit<FieldsState> {
  FieldsCubit(
    this._fieldsRepo,
  ) : super(const FieldsState.initial());

  final FieldsRepo _fieldsRepo;
  StreamSubscription? _progressSubscription;

  Future<void> startCalculation(String url) async {
    try {
      emit(const FieldsState.loading());
      _fieldsRepo.setSourceUrl(url);
      await _fieldsRepo.loadFields();
      _progressSubscription = _fieldsRepo.calculateLoadedFields().listen(
        (event) {
          final progress =
              _fieldsRepo.calculatedFields.length / _fieldsRepo.fields.length;
          emit(FieldsState.calculating(progress));
          if (progress >= 1) {
            emit(
              FieldsState.calculated(
                _fieldsRepo.fields,
                _fieldsRepo.calculatedFields,
              ),
            );
          }
        },
      );
    } on Exception catch (e) {
      emit(FieldsState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _progressSubscription?.cancel();
    return super.close();
  }
}
