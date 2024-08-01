import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.exception,
    required this.onBackPressed,
  });

  final String exception;
  final void Function(BuildContext context) onBackPressed;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(locale.somethingWentWrong),
        Text('${locale.details}:'),
        Text(
          exception,
        ),
        TextButton(
          onPressed: () {
            onBackPressed(context);
          },
          child: Text(locale.back),
        ),
      ],
    );
  }
}
