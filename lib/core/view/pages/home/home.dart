import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webspark_task/app_sizes/spacing.dart';
import 'package:webspark_task/core/view/fields_cubit/fields_cubit.dart';
import 'package:webspark_task/core/view/pages/home/widgets/error.dart';
import 'package:webspark_task/core/view/pages/home/widgets/loader.dart';
import 'package:webspark_task/navigation/routes.dart';
import 'package:webspark_task/utils/app_reg_exp.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _urlController =
      TextEditingController(text: 'https://flutter.webspark.dev');

  final GlobalKey<FormState> _formKey = GlobalKey();

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
              state.mapOrNull(uploaded: (uploaded) {
                final cubit = context.read<FieldsCubit>();
                Navigator.of(context).push(NavigationRoutes.resultPage(
                  uploaded.results,
                  uploaded.fields,
                ));
                cubit.reset();
              });
            },
            builder: (context, state) {
              return state.maybeMap(
                initial: (initial) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          locale.setBaseUrl,
                        ),
                        TextFormField(
                          controller: _urlController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.compare_arrows),
                            hintText: locale.urlHint,
                          ),
                          validator: (text) {
                            final exp = RegExp(AppRegExp.urlValidator);
                            final isValid = exp.hasMatch(text ?? '');
                            if (!isValid) {
                              return locale.urlHint;
                            }
                            return null;
                          },
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: _startCounting,
                          child: Text(locale.startCountingProcess),
                        )
                      ],
                    ),
                  );
                },
                loading: (loading) {
                  return Center(
                      child: Loader(
                    title: locale.obtainingData,
                    progress: loading.progress,
                  ));
                },
                calculating: (calculating) {
                  return Center(
                      child: Loader(
                    title: locale.calculating,
                    progress: calculating.progress,
                  ));
                },
                calculated: (calculated) {
                  return Column(
                    children: [
                      Text(locale.loadedAndProcessed),
                      ElevatedButton(
                          onPressed: () {
                            context.read<FieldsCubit>().uploadResults();
                          },
                          child: Text(
                            locale.uploadResults,
                          ))
                    ],
                  );
                },
                uploading: (uploading) {
                  return Loader(
                    title: locale.uploadingResults,
                    progress: uploading.progress,
                  );
                },
                error: (error) {
                  return AppErrorWidget(
                    exception: error.exception,
                    onBackPressed: (context) {
                      context.read<FieldsCubit>().reset();
                    },
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
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      context.read<FieldsCubit>().startCalculation(_urlController.text);
    }
  }
}
