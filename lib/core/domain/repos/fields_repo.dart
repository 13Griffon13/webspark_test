import 'package:webspark_task/core/data/models/data_model.dart';
import 'package:webspark_task/core/data/models/result_model.dart';

abstract class FieldsRepo {
  List<DataModel> get fields;

  List<ResultModel> get calculatedFields;

  Future<List<DataModel>> loadFields();

  Future<bool> sendResults();

  Stream<ResultModel> calculateLoadedFields();

  void setSourceUrl(String url);

  void dispose();
}
