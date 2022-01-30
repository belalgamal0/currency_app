import '../currency_home/amount_converter.dart';
import '../../widgets/drop_down_widget.dart';
import 'bloc/converter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'bloc/converter_states.dart';

class CurrencyConverter extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConverterBloc(),
      child: BlocConsumer<ConverterBloc, ConverterStates>(
        listener: (context, state) {
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: Text("Currency Converter")),
          body: Container(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<ConverterBloc, ConverterStates>(
                    buildWhen: (previous, current) =>
                        current == ConverterSuccessState(),
                    builder: (context, state) => DropDownWidget(
                        ConverterBloc().get(context).firstCurrency,
                         (value) {
                      ConverterBloc().get(context).firstCurrency = value;
                      ConverterBloc().get(context).selectCurrency(
                        currencyValue: ConverterBloc().get(context).firstCurrency,
                        dropDownValue: value);
                      ConverterBloc().get(context).convertCurrency();
                    })),
                  Text(" TO "),
                  DropDownWidget(ConverterBloc().get(context).secondCurrency,
                      (value) {
                    ConverterBloc().get(context).secondCurrency = value;
                    ConverterBloc().get(context).selectCurrency(
                        currencyValue:ConverterBloc().get(context).firstCurrency,
                        dropDownValue: value);
                    ConverterBloc().get(context).convertCurrency();
                  })]),
              SizedBox(height: 30),
              BlocBuilder<ConverterBloc, ConverterStates>(
                buildWhen: (previous, current) => current == ConverterSuccessState(),
                builder: (context, state) => Text(ConverterBloc().get(context).convertedValue == null ? "Please enter both currnecy to convert" : ConverterBloc().get(context).loading ? "loading" : ConverterBloc().get(context).firstCurrency + "  is  ${ConverterBloc().get(context).convertedValue}  " + ConverterBloc().get(context).secondCurrency)),
              SizedBox(height: 15),
              ElevatedButton(
                  child: Text("Try amount converter!"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AmountConverterPage()));
                  })])))));
  }
}
