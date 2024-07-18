import 'package:bloc_3_qism/data/model/course.dart';


abstract class CurrencyEvent {}

class GetCurrenciesEvent extends CurrencyEvent {}

class ConvertCurrencyEvent extends CurrencyEvent {
  final double amount;
  final Course course;

  ConvertCurrencyEvent({required this.amount, required this.course});
}

class SearchCurrenciesEvent extends CurrencyEvent {
  final String query;

  SearchCurrenciesEvent({required this.query});
}