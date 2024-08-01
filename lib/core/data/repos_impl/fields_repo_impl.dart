import 'dart:async';

import 'package:webspark_task/core/data/models/data_model.dart';
import 'package:webspark_task/core/data/models/result_model.dart';
import 'package:webspark_task/core/data/services/flutter_recruiting_api.dart';
import 'package:webspark_task/core/data/services/path_calculation_service.dart';
import 'package:webspark_task/core/domain/repos/fields_repo.dart';

class FieldsRepoImpl extends FieldsRepo {
  final FlutterRecruitingApi _flutterRecruitingApi =
      FlutterRecruitingApi.instance;

  List<DataModel> _loadedFields = [];

  List<ResultModel> _calculatedFields = [];

  StreamSubscription<ResultModel>? _calculationSubscription;

  @override
  List<ResultModel> calculateLoadedFields({
    void Function(int, int)? onProgress,
  }) {
    _calculationSubscription =
        PathCalculationService.calculate(_loadedFields).listen(
      (result) {
        _calculatedFields.add(result);
        onProgress?.call(_calculatedFields.length, _loadedFields.length);
      },
    );
    return _calculatedFields;
  }

  @override
  List<ResultModel> get calculatedFields => _calculatedFields;

  @override
  List<DataModel> get fields => _loadedFields;

  @override
  Future<List<DataModel>> loadFields({
    void Function(int, int)? onProgress,
  }) async {
    _calculatedFields = [];
    _loadedFields = [];
    final response = await _flutterRecruitingApi.getData(
      onProgress: onProgress,
    );
    if (response.data != null && response.data!.isNotEmpty) {
      _loadedFields = response.data!;
    }
    return _loadedFields;
  }

  @override
  Future<bool> sendResults({void Function(int, int)? onProgress}) async {
    final response = await _flutterRecruitingApi.sendData(
      _calculatedFields,
      onProgress: onProgress,
    );

    return response;
  }

  @override
  void setSourceUrl(String url) {
    _flutterRecruitingApi.setBaeUrl(url);
  }

  @override
  void dispose() {
    _calculationSubscription?.cancel();
  }
}
