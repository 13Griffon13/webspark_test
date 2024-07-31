import 'dart:collection';

import 'package:webspark_task/core/data/models/data_model.dart';
import 'package:webspark_task/core/data/models/point.dart';
import 'package:webspark_task/core/data/models/result.dart';
import 'package:webspark_task/core/data/models/result_model.dart';

abstract class PathCalculationService {
  static Stream<ResultModel> calculate(List<DataModel> fields) async* {
    for (final field in fields) {
      final path = _calculatePath(field.start, field.end, field.field);
      final resultModel = ResultModel(
        id: field.id,
        result: Result.fromSteps(
          path,
        ),
      );
      yield resultModel;
    }
  }

  static List<Point> _calculatePath(
    Point start,
    Point target,
    List<String> field,
  ) {
    final visited = <Point>[];
    visited.add(start);
    Map<Point, Point> parents = {};
    Queue<Point> queue = Queue();
    queue.add(start);
    while (queue.isNotEmpty) {
      final point = queue.removeFirst();
      final neighbours = _getNeighbours(point, field, visited);
      if (neighbours.contains(target)) {
        parents[target] = point;
        queue.clear();
      } else {
        for (var neighbour in neighbours) {
          visited.add(neighbour);
          parents[neighbour] = point;
          queue.add(neighbour);
        }
      }
    }

    final path = <Point>[];
    var current = target;
    while (current != start) {
      path.add(current);
      current = parents[current]!;
    }
    path.add(start);
    return path.reversed.toList();
  }

  static List<Point> _getNeighbours(
    Point point,
    List<String> field,
    List<Point> visited,
  ) {
    final neighbours = <Point>[];
    for (final direction in Directions.values) {
      var candidate = Point(
        x: point.x + direction.mask.x,
        y: point.y + direction.mask.y,
      );
      if (candidate.y < field.length && candidate.y >= 0) {
        if (candidate.x < field[point.y + direction.mask.y].length &&
            candidate.x >= 0) {
          if (field[candidate.y][candidate.x] != 'X' &&
              !visited.contains(candidate)) {
            neighbours.add(candidate);
          }
        }
      }
    }
    return neighbours;
  }
}

//Description of available moves
enum Directions {
  up(Point(x: 0, y: 1)),
  down(Point(x: 0, y: -1)),
  left(Point(x: -1, y: 0)),
  right(Point(x: 1, y: 0)),
  upLeft(Point(x: -1, y: 1)),
  upRight(Point(x: 1, y: 1)),
  downLeft(Point(x: -1, y: -1)),
  downRight(Point(x: 1, y: -1));

  final Point mask;

  const Directions(this.mask);
}
