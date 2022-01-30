import '../../../networking/links.dart';
import '../../../model/currency_model.dart';
import '../../../model/set_base_currency_modeal.dart';
import '../../../networking/api_provider.dart';
import 'package:flutter/material.dart';
import 'currency_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyBloc extends Cubit<CurrencyStates> {
  CurrencyBloc() : super(CurrencyInitialState());
  CurrencyBloc get(context) => BlocProvider.of(context);
  ApiProvider _apiProvider = ApiProvider();
  Links _links = Links();
  String firstCurrency;
  String convertedFirst, convertedSecond, convertedThird;
  SetBaseCurrencyModel setBaseCurrencyModel;
  List<Currency> dailyData;
  List<Currency> selectedValues = [];
  double firstConverted, secondConverted;
  List<Widget> viewedCurrencies = [];
  convertAmont({String amount}) async {
    emit(CurrencyLoadingState());
    await _apiProvider.get(path: _links.latestUrl, parameters: {
      'apikey': '8c5bc110-8039-11ec-bc36-2db1378e6b3f',
      'base_currency': firstCurrency
    }).then((value) {
      setBaseCurrencyModel = SetBaseCurrencyModel.fromJson(value);
      dailyData = setBaseCurrencyModel.data.entries.map((entry) => Currency(name: entry.key, value: entry.value)).toList();
      selectedValues.clear();
      viewedCurrencies.clear();
      dailyData.forEach((element) {
        if (element.name == convertedFirst || element.name == convertedSecond) {
          selectedValues.add(element);
        }
      });
      convertedCurrenciesWidget(double.parse(amount));
      emit(CurrencySuccessState());
    });
  }

  convertedCurrenciesWidget(double amount) {
    if (selectedValues.isNotEmpty) {
      for (var i = 0; i < selectedValues.length; i++) {
        viewedCurrencies.add(Text("Amount of $amount $firstCurrency is ${amount * selectedValues[i].value} in ${selectedValues[i].name} "));
      }
    }
  }
}
