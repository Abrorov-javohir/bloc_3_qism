import 'package:bloc_3_qism/services/nbu_courses_http_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_3_qism/blocs/currency_event.dart';
import 'package:bloc_3_qism/blocs/currency_state.dart';
import 'package:stream_transform/stream_transform.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final ConvertationHttpService httpService;

  CurrencyBloc({required this.httpService}) : super(CurrencyInitial()) {
    on<GetCurrenciesEvent>(_onGetCurrencies);
    on<ConvertCurrencyEvent>(_onConvertCurrency);
    on<SearchCurrenciesEvent>(_onSearchCurrencies, transformer: debounce());
  }

  void _onGetCurrencies(
      GetCurrenciesEvent event, Emitter<CurrencyState> emit) async {
    emit(CurrencyLoading());
    try {
      final courses = await httpService.getCurses();
      emit(CurrencyLoaded(courses: courses));
    } catch (e) {
      emit(CurrencyError(message: e.toString()));
    }
  }

  void _onConvertCurrency(
    ConvertCurrencyEvent event,
    Emitter<CurrencyState> emit,
  ) {
    try {
      final convertedAmount = event.amount * event.course.cbPrice;
      emit(
        CurrencyConverted(
          convertedAmount: convertedAmount,
        ),
      );
    } catch (e) {
      emit(
        CurrencyError(
          message: e.toString(),
        ),
      );
    }
  }

  void _onSearchCurrencies(
      SearchCurrenciesEvent event, Emitter<CurrencyState> emit) async {
    emit(CurrencyLoading());
    try {
      final courses = await httpService.getCurses();
      final filteredCourses = courses
          .where((course) =>
              course.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(CurrencyLoaded(courses: filteredCourses));
    } catch (e) {
      emit(CurrencyError(message: e.toString()));
    }
  }

  EventTransformer<T> debounce<T>() {
    return (events, mapper) {
      return events.debounce(const Duration(milliseconds: 300)).switchMap(mapper);
    };
  }
}
