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

  final StreamController<ResultModel> _calculationController =
      StreamController();

  StreamSubscription<ResultModel>? _calculationSubscription;

  @override
  Stream<ResultModel> calculateLoadedFields() {
    _calculationSubscription =
        PathCalculationService.calculate(_loadedFields).listen(
      (result) {
        _calculatedFields.add(result);
        _calculationController.add(result);
      },
    );
    return _calculationController.stream;
  }

  @override
  List<ResultModel> get calculatedFields => _calculatedFields;

  @override
  List<DataModel> get fields => _loadedFields;

  @override
  Future<List<DataModel>> loadFields() async {
    final response = await _flutterRecruitingApi.getData();
    if (response.data != null && response.data!.isNotEmpty) {
      _loadedFields = response.data!;
    }
    return _loadedFields;
  }

  @override
  Future<bool> sendResults() async {
    await _flutterRecruitingApi.sendData(_calculatedFields);

    return true;
  }

  @override
  void setSourceUrl(String url) {
    _flutterRecruitingApi.setBaeUrl(url);
  }

  @override
  void dispose() {
    _calculationSubscription?.cancel();
    _calculationController.close();
  }
}
