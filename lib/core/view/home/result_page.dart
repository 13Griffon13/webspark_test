import 'package:flutter/material.dart';
import 'package:webspark_task/core/data/models/data_model.dart';
import 'package:webspark_task/core/data/models/result_model.dart';
import 'package:webspark_task/navigation/routes.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.results,
    required this.fields,
  });

  final List<ResultModel> results;
  final List<DataModel> fields;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(results[index].result.path),
              onTap: () {
                final field = fields
                    .where((element) => element.id == results[index].id)
                    .single;
                Navigator.of(context).push(
                  NavigationRoutes.detailsPage(
                    field,
                    results[index],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
