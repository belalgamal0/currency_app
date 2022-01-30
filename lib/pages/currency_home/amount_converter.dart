import '../../widgets/drop_down_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/currency_bloc.dart';
import 'bloc/currency_states.dart';

class AmountConverterPage extends StatefulWidget {

  @override
  _AmountConverterPageState createState() => _AmountConverterPageState();
}

class _AmountConverterPageState extends State<AmountConverterPage> {
  String first;
  TextEditingController converterFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrencyBloc(),
      child: BlocConsumer<CurrencyBloc, CurrencyStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text("Amount Converter"),
          ),
          body: Container(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropDownWidget(CurrencyBloc().get(context).firstCurrency,
                      (value) {
                    setState(() {
                      CurrencyBloc().get(context).firstCurrency = value;
                    });
                  }),
                  Expanded(child: TextField(
                          controller: converterFieldController,
                          keyboardType: TextInputType.number)),
                  Column(
                    children: [
                      DropDownWidget(CurrencyBloc().get(context).convertedFirst,
                          (value) {
                            setState(() {
                              CurrencyBloc().get(context).convertedFirst = value;
                        });
                      }),
                      DropDownWidget(
                          CurrencyBloc().get(context).convertedSecond, (value) {
                        setState(() {
                          CurrencyBloc().get(context).convertedSecond = value;
                        });
                      })])]),
              ElevatedButton(
                  child: Text("Convert"),
                  onPressed: () async {
                    CurrencyBloc().get(context).convertAmont(amount: converterFieldController.text);
                  }),
              SizedBox(height: 15),
              BlocBuilder<CurrencyBloc, CurrencyStates>(buildWhen: (previous, current) => current == CurrencySuccessState(),
                  builder: (context, state) => Column(
                      children: CurrencyBloc().get(context).viewedCurrencies,
                      crossAxisAlignment: CrossAxisAlignment.start))])))));
  }
}
