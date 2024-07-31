import 'package:flutter/material.dart';
import 'package:webspark_task/core/data/models/data_model.dart';
import 'package:webspark_task/core/data/models/result_model.dart';
import 'package:webspark_task/core/view/home/details_page.dart';
import 'package:webspark_task/core/view/home/result_page.dart';

//Might be a good idea to use routing library but navigation
//is simple enough
class NavigationRoutes {
  static MaterialPageRoute<ResultPage> resultPage(
    List<ResultModel> results,
    List<DataModel> fields,
  ) =>
      MaterialPageRoute(
          builder: (context) => ResultPage(
                results: results,
                fields: fields,
              ));

  static MaterialPageRoute<DetailsPage> detailsPage(
    DataModel field,
    ResultModel result,
  ) =>
      MaterialPageRoute(
          builder: (context) => DetailsPage(
                dataModel: field,
                resultModel: result,
              ));
}
