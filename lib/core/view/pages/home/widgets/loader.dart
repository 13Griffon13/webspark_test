import 'package:flutter/material.dart';
import 'package:webspark_task/app_sizes/spacing.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
    required this.title,
    required this.progress,
  });

  final String title;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
        ),
        const SizedBox(
          height: Spacing.padding8px,
        ),
        CircularProgressIndicator(
          value: progress == 0.0 ? null : progress,
        ),
        Text('${(progress * 100).toStringAsFixed(2)}%')
      ],
    );
  }
}
