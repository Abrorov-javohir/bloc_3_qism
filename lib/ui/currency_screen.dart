import 'package:bloc_3_qism/blocs/currency_bloc.dart';
import 'package:bloc_3_qism/blocs/currency_event.dart';
import 'package:bloc_3_qism/blocs/currency_state.dart';
import 'package:bloc_3_qism/data/model/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyScreen extends StatelessWidget {
  const CurrencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Courses",
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                context
                    .read<CurrencyBloc>()
                    .add(SearchCurrenciesEvent(query: value));
              },
              decoration: const InputDecoration(
                hintText: "Search for a currency",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<CurrencyBloc, CurrencyState>(
              builder: (context, state) {
                if (state is CurrencyInitial) {
                  context.read<CurrencyBloc>().add(GetCurrenciesEvent());
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CurrencyLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CurrencyLoaded) {
                  return ListView.builder(
                    itemCount: state.courses.length,
                    itemBuilder: (context, index) {
                      final course = state.courses[index];
                      return ListTile(
                        title: Text(course.title),
                        subtitle: Text("${course.cbPrice.toString()} sum"),
                        onTap: () {
                          _showResult(context, course);
                        },
                      );
                    },
                  );
                } else if (state is CurrencyConverted) {
                  return Center(
                      child: Column(
                    children: [
                      TextField(),
                      AlertDialog(
                        title: const Text("Converted Amount"),
                        content: Text(
                            "Converted amount: ${state.convertedAmount.toString()} UZS"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const CurrencyScreen();
                                  },
                                ),
                              );
                              context
                                  .read<CurrencyBloc>()
                                  .add(GetCurrenciesEvent());
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    ],
                  ));
                } else if (state is CurrencyError) {
                  return Center(
                    child: Text(
                      state.message,
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("Valyuta kurinmadi"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showResult(BuildContext context, Course course) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text("Convert ${course.title}"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Summani kiriting"),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                final amount = double.parse(controller.text);
                context
                    .read<CurrencyBloc>()
                    .add(ConvertCurrencyEvent(amount: amount, course: course));
                Navigator.of(context).pop();
              },
              child: const Text("Convert"),
            ),
          ],
        );
      },
    );
  }
}
