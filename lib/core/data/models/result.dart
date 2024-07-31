import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark_task/core/data/models/point.dart';

part 'result.freezed.dart';
part 'result.g.dart';

@freezed
class Result with _$Result {
  const factory Result({
    required List<Point> steps,
    required String path,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  factory Result.fromSteps(List<Point> steps) {
    var finalPath = '';
    for (final step in steps) {
      finalPath += '(${step.y},${step.x})';
      if (step != steps.last) {
        finalPath += '->';
      }
    }
    return Result(steps: steps, path: finalPath);
  }
}
