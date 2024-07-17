import 'package:bloc_3_qism/blocs/currency_bloc.dart';
import 'package:bloc_3_qism/blocs/currency_event.dart';
import 'package:bloc_3_qism/blocs/currency_state.dart';
import 'package:bloc_3_qism/data/model/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Valyuta Konvertatsiya")),
      body: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          if (state is CurrencyInitial) {
            context.read<CurrencyBloc>().add(GetCurrenciesEvent());
            return Center(child: CircularProgressIndicator());
          } else if (state is CurrencyLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CurrencyLoaded) {
            return ListView.builder(
              itemCount: state.courses.length,
              itemBuilder: (context, index) {
                final course = state.courses[index];
                return ListTile(
                  title: Text(course.title),
                  subtitle: Text(course.cbPrice.toString()),
                  onTap: () => _showConversionDialog(context, course),
                );
              },
            );
          } else if (state is CurrencyError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _showConversionDialog(BuildContext context, Course course) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _controller = TextEditingController();
        return AlertDialog(
          title: Text("Convert ${course.title}"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Summani kiriting"),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                final amount = double.parse(_controller.text);
                context
                    .read<CurrencyBloc>()
                    .add(ConvertCurrencyEvent(amount: amount, course: course));
                Navigator.of(context).pop();
              },
              child: Text("Convert"),
            ),
          ],
        );
      },
    );
  }
}
