import 'package:flutter/material.dart';
import 'package:webspark_task/core/data/models/data_model.dart';
import 'package:webspark_task/core/data/models/point.dart';
import 'package:webspark_task/core/data/models/result_model.dart';
import 'package:webspark_task/themes/app_colors.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    super.key,
    required this.dataModel,
    required this.resultModel,
  });

  final DataModel dataModel;
  final ResultModel resultModel;
  final double _cellSize = 60.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: dataModel.id != resultModel.id
            ? const Center(
                child: Text(
                  'Ids do not match',
                ),
              )
            //TODO(Hrihorii): scroll issues
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //used custom grid for app to support asymmetrical fields
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: dataModel.field.indexed
                        .map(
                          (row) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: row.$2.characters.indexed
                                .map(
                                  (column) => Container(
                                    width: _cellSize,
                                    height: _cellSize,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: _colorSelector(
                                        Point(
                                          x: column.$1,
                                          y: row.$1,
                                        ),
                                        column.$2,
                                      ),
                                    ),
                                    child: Text(
                                      '(${column.$1},${row.$1})',
                                      style: const TextStyle(
                                        //grey so it clearly visible on any
                                        // colored cell
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        )
                        .toList(),
                  ),
                  Text(resultModel.result.path),
                ],
              ),
      ),
    );
  }

  Color _colorSelector(Point point, String value) {
    if (point == dataModel.start) {
      return AppColors.startPoint;
    } else {
      if (point == dataModel.end) {
        return AppColors.endColor;
      } else {
        if (value == 'X') {
          return AppColors.obsticleColor;
        } else {
          if (resultModel.result.steps.contains(point)) {
            return AppColors.pathColor;
          } else {
            return AppColors.emptyColor;
          }
        }
      }
    }
  }
}
