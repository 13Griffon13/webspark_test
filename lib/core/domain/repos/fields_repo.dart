import 'package:webspark_task/core/data/models/data_model.dart';
import 'package:webspark_task/core/data/models/result_model.dart';

abstract class FieldsRepo {
  List<DataModel> get fields;

  List<ResultModel> get calculatedFields;

  Future<List<DataModel>> loadFields({void Function(int, int)? onProgress});

  Future<bool> sendResults({void Function(int, int)? onProgress});

  List<ResultModel> calculateLoadedFields({
    void Function(int, int)? onProgress,
  });

  void setSourceUrl(String url);

  void dispose();
}
