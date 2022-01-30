
import '../../../networking/links.dart';
import '../../../model/set_base_currency_modeal.dart';
import '../../../model/daily_currency_data_model.dart';
import '../../../model/historical_data_response.dart';
import '../../../model/currency_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/all_currencies_response.dart';
import '../../../networking/api_provider.dart';
import '../../singelton.dart';
import 'home_states.dart';

class HomeBloc extends Cubit<HomeStates> {
  HomeBloc() : super(HomeInitialState());
  HomeBloc get(context) => BlocProvider.of(context);
  Links _links = Links();
  bool loading = false;
  AllCurrenciesResponse allCurrenciesResponse;
  SetBaseCurrencyModel setBaseCurrencyModel;
  List<Currency> currencies;
  ApiProvider _apiProvider = ApiProvider();
  Map<String, String> _queryParameters = <String, String>{
    'apikey': '8c5bc110-8039-11ec-bc36-2db1378e6b3f'
  };
  HistoricalDataCurrneyModel historicalDataCurrneyModel;
  List<DailyCurrencyData> dailyData;
  Map<String,String> historicalDataParameters = {'apikey': '8c5bc110-8039-11ec-bc36-2db1378e6b3f',
  'base_currency':Singleton().currency,"date_from":"2021-01-28","date_to":"2022-01-28"};

  Future getCurrencies() async {
    loading = true;
    emit(HomeLoadingState());
    await _apiProvider.get(path: _links.latestUrl, parameters: _queryParameters).then((value) {
      allCurrenciesResponse = AllCurrenciesResponse.fromJson(value);
      currencies = allCurrenciesResponse.data.entries.map((entry) => Currency(name: entry.key, value: entry.value)).toList();
    });
    
    loading = false;
    emit(HomeSuccessState());
  }


  Future getHistoricalData({String selectedCurrency})async{
    loading = true;
    emit(HomeLoadingState());
    
    await _apiProvider.get(path: _links.historicalUrl, parameters: historicalDataParameters).then((value){
       historicalDataCurrneyModel = HistoricalDataCurrneyModel.fromJson(value);
       dailyData = historicalDataCurrneyModel.data.entries.map((e) => DailyCurrencyData(dateFormat: e.key, currency:e.value[selectedCurrency])).toList();
            });

    loading = false;
    emit(HomeSuccessState());
  }


 
  Future getCurrentRates({String currencyName})async{
    loading = true;
    emit(HomeLoadingState());
    
    await _apiProvider.get(path: _links.latestUrl,parameters: {'apikey': '8c5bc110-8039-11ec-bc36-2db1378e6b3f',
      'base_currency':currencyName}).then((value){
        setBaseCurrencyModel = SetBaseCurrencyModel.fromJson(value);
        currencies = setBaseCurrencyModel.data.entries.map((entry) =>Currency(name: entry.key, value: entry.value)).toList();
          Singleton().currency = currencyName;
    });

    loading = false;
    emit(HomeSuccessState());
  }
}

