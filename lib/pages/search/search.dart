import '../home/bloc/home_bloc.dart';
import 'bloc/search_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/currency_widget.dart';
import 'package:flutter/material.dart';
import 'bloc/search_states.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: BlocConsumer<SearchBloc, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
            appBar: AppBar(title: Text("Search")),
            body: Container(
                padding: EdgeInsets.all(20),
                child: Center(
                    child: Column(children: [
                  TextField(onSubmitted: (value) {
                    SearchBloc().get(context).currencySearch(
                        currency: value,
                        allCurrencies: HomeBloc().get(context).currencies);
                  }),
                  SizedBox(height: 20),
                  BlocBuilder<SearchBloc, SearchStates>(
                    buildWhen: (previous, current) => current == SearchSuccessState(),
                    builder: (context, state) => Expanded(
                        child: SearchBloc().get(context).searchResult.isEmpty
                            ? Text(SearchBloc().get(context).searchResultText)
                            : ListView.builder(
                                itemBuilder: (context, index) => CurrencyWidget(
                                    currencyName: SearchBloc().get(context).searchResult[index].name,
                                    rt: SearchBloc().get(context).searchResult[index].value.toString()),
                                itemCount: SearchBloc().get(context).searchResult.length)))])))))
    );
  }
}
