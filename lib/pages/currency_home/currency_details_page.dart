import 'currency_rates.dart';
import '../home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'currency_graph.dart';

class CurrencyDetailsPage extends StatefulWidget {
  final String currencyName;
  final double currencyRt;
  CurrencyDetailsPage({this.currencyName, this.currencyRt});
  @override
  _CurrencyDetailsPageState createState() => _CurrencyDetailsPageState();
}

class _CurrencyDetailsPageState extends State<CurrencyDetailsPage> {
  @override
  void initState() {
    super.initState();
    HomeBloc().get(context).getHistoricalData(selectedCurrency: widget.currencyName).then((value) {
      setState(() {
        HomeBloc().get(context).loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Historical Data of  ${widget.currencyName}")),
        body: Container(
            padding: EdgeInsets.all(25),
            child: HomeBloc().get(context).loading
                ? Center(child: CircularProgressIndicator())
                : Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context) => CurrentRates(currencyName: widget.currencyName)));
                              },
                              child: Text("Set as BASE CURRENCY")),
                          ElevatedButton(
                            child: Text("Graph"),
                            onPressed: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => CurrencyChartPage(dailyData: HomeBloc().get(context).dailyData)));
                            },
                          )
                        ]),
                    SizedBox(height: 25),
                    Expanded(
                        child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            itemBuilder: (context, index) => Text("At  ${HomeBloc().get(context).dailyData[index].dateFormat}  RT is  ${HomeBloc().get(context).dailyData[index].currency.toString()}"),
                            itemCount: HomeBloc().get(context).dailyData.length))
                  ])));
  }
}
