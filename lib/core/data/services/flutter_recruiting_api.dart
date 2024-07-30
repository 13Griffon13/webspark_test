import 'package:dio/dio.dart';

class FlutterRecruitingApi {
  FlutterRecruitingApi._();

  static FlutterRecruitingApi instance = FlutterRecruitingApi._();

  //Might be a good idea to keep it in separate file
  final String _baseUrl = 'https://flutter.webspark.dev';
  final String _getPath = '/flutter/api';
  final String _postPath = '/flutter/api';

  final Dio _dio = Dio();
}
