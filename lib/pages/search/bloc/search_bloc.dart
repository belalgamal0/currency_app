import '../../../model/currency_model.dart';
import 'search_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Cubit<SearchStates> {
  SearchBloc() : super(SearchInitalState());
  SearchBloc get(context) => BlocProvider.of(context);
  bool loading = false;
  List<Currency> searchResult = [];
  String searchResultText = "Search for currencies!";

  currencySearch({String currency, List<Currency> allCurrencies}) {
    loading = true;
    emit(SearchLoadingState());

    searchResult.clear();
    allCurrencies.forEach((element) {
      if (element.name.contains(currency.toUpperCase())) {
        searchResult.add(element);
      }
      if (searchResult.isEmpty) {
        searchResultText = "No Currency Found!";
      }

      loading = false;
    });
    emit(SearchSuccessState());
  }
}
