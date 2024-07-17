import 'package:bloc_3_qism/blocs/currency_bloc.dart';
import 'package:bloc_3_qism/blocs/currency_state.dart';
import 'package:bloc_3_qism/data/model/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversionResultScreen extends StatelessWidget {
  final double amount;
  final Course course;

  ConversionResultScreen({required this.amount, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Conversion Result")),
      body: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          if (state is CurrencyConverted) {
            return Center(
              child: Text(
                "${amount} ${course.cbPrice} = ${state.convertedAmount} UZS",
                style: TextStyle(fontSize: 24),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}