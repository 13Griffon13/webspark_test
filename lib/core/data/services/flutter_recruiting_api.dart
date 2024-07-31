import 'package:dio/dio.dart';
import 'package:webspark_task/core/data/models/response_model.dart';
import 'package:webspark_task/core/data/models/result_model.dart';

class FlutterRecruitingApi {
  FlutterRecruitingApi._();

  //Might be a good idea to use getIt but there is no reason to setup
  // it in project of this size
  static FlutterRecruitingApi instance = FlutterRecruitingApi._();

  //Might be a good idea to keep it in separate file
  String _baseUrl = 'https://flutter.webspark.dev';
  final String _getPath = '/flutter/api';
  final String _postPath = '/flutter/api';

  final Dio _dio = Dio();

  void setBaeUrl(String newUrl) => _baseUrl = newUrl;

  Future<ResponseModel> getData() async {
    final response = await _dio.get('$_baseUrl$_getPath');
    return ResponseModel.fromJson(response.data);
  }

  Future<bool> sendData(List<ResultModel> results) async {
    await _dio.post(
      '$_baseUrl$_postPath',
      data: results,
    );
    return true;
  }
}
