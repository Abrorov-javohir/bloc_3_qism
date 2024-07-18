import 'package:bloc_3_qism/services/nbu_courses_http_services.dart';
import 'package:bloc_3_qism/ui/currency_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_3_qism/blocs/currency_bloc.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrencyBloc(httpService: ConvertationHttpService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CurrencyScreen(),
      ),
    );
  }
}
