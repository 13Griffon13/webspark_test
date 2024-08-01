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

  Future<void> startCalculation(String url) async {
    try {
      _fieldsRepo.setSourceUrl(url);
      emit(const FieldsState.loading(0.0));
      await _fieldsRepo.loadFields(
        onProgress: (value, total) {
          emit(FieldsState.loading(value / total));
        },
      );
      emit(const FieldsState.calculating(0.0));
      _fieldsRepo.calculateLoadedFields(
        onProgress: (value, total) {
          emit(FieldsState.calculating(value / total));
          if (value / total == 1.0) {
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

  Future<void> uploadResults() async {
    try {
      await state.mapOrNull(calculated: (calculated) async {
        emit(const FieldsState.uploading(0.0));
        final isSuccess =
            await _fieldsRepo.sendResults(onProgress: (value, total) {
          emit(
            FieldsState.uploading(
              value / total,
            ),
          );
        });
        if (isSuccess) {
          emit(
            FieldsState.uploaded(
              _fieldsRepo.fields,
              _fieldsRepo.calculatedFields,
            ),
          );
        } else {
          emit(const FieldsState.error(''));
        }
      });
    } on Exception catch (e) {
      emit(FieldsState.error(e.toString()));
    }
  }

  void reset() {
    emit(const FieldsState.initial());
  }
}
