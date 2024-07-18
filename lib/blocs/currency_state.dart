import 'package:bloc/bloc.dart';
import 'package:bloc_3_qism/data/model/course.dart';

abstract class CurrencyState {}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List<Course> courses;

  CurrencyLoaded({required this.courses});
}

class CurrencyConverted extends CurrencyState {
  final double convertedAmount;

  CurrencyConverted({required this.convertedAmount});
}

class CurrencyError extends CurrencyState {
  final String message;

  CurrencyError({required this.message});
}


