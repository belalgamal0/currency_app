import '../../../networking/links.dart';
import '../../../model/all_currencies_response.dart';
import '../../../networking/api_provider.dart';
import 'converter_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConverterBloc extends Cubit<ConverterStates> {
  ConverterBloc() : super(ConverterInitialState());
  ConverterBloc get(context) => BlocProvider.of(context);
  ApiProvider _apiProvider = ApiProvider();
  Links _links = Links();
  String firstCurrency;
  String secondCurrency;
  double convertedValue;
  bool loading = false;
  AllCurrenciesResponse allCurrenciesResponse;
  bool currencyConversionValidation() {
    if (firstCurrency != null && secondCurrency != null) {
      return true;
    } else {
      return false;
    }
  }

  selectCurrency({String currencyValue, dynamic dropDownValue}) {
    emit(ConverterLoadinglState());
    currencyValue = dropDownValue;
    emit(ConverterSuccessState());
  }

  convertCurrency() async {
    if (currencyConversionValidation()) {
      loading = true;
      emit(ConverterLoadinglState());

      await _apiProvider.get(path: _links.latestUrl, parameters: {
        'apikey': '8c5bc110-8039-11ec-bc36-2db1378e6b3f',
        'base_currency': "$firstCurrency"
      }).then((value) {
        allCurrenciesResponse = AllCurrenciesResponse.fromJson(value);
        convertedValue = allCurrenciesResponse.data[secondCurrency];

        loading = false;
        emit(ConverterSuccessState());
      });
    }
  }
}
