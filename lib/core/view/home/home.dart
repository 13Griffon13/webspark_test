import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webspark_task/app_sizes/spacing.dart';
import 'package:webspark_task/core/view/fields_cubit/fields_cubit.dart';
import 'package:webspark_task/navigation/routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _urlController =
      TextEditingController(text: 'https://flutter.webspark.dev');

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.homePage),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.padding16px,
          ),
          child: BlocConsumer<FieldsCubit, FieldsState>(
            listener: (context, state) {
              state.mapOrNull(calculated: (calculated) {
                Navigator.of(context).push(NavigationRoutes.resultPage(
                  calculated.results,
                  calculated.fields,
                ));
              });
            },
            builder: (context, state) {
              return state.maybeMap(
                initial: (initial) {
                  return Column(
                    children: [
                      Text(
                        locale.setBaseUrl,
                      ),
                      TextField(
                        controller: _urlController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.compare_arrows),
                          hintText: locale.urlHint,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _startCounting,
                        child: Text(locale.startCountingProcess),
                      )
                    ],
                  );
                },
                loading: (lading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                calculating: (calculating) {
                  return Center(
                    child: CircularProgressIndicator(
                      value: calculating.progress,
                    ),
                  );
                },
                orElse: () {
                  return Container();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _startCounting() {
    context.read<FieldsCubit>().startCalculation(_urlController.text);
  }
}
