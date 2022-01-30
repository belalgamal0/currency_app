import '../../model/daily_currency_data_model.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CurrencyChartPage extends StatefulWidget {
  final List<DailyCurrencyData> dailyData;
  CurrencyChartPage({this.dailyData});
  _CurrencyChartPageState createState() => _CurrencyChartPageState();
}

class _CurrencyChartPageState extends State<CurrencyChartPage> {
  List<charts.Series<DailyCurrencyData, DateTime>> seriesLineData  = <charts.Series<DailyCurrencyData, DateTime>>[];
  generateChartData() {
    seriesLineData.add(charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.blue.shade300),
        id: "Currency RT",
        data: widget.dailyData,
        domainFn: (DailyCurrencyData sales, _) => DateTime.parse(sales.dateFormat),
        measureFn: (DailyCurrencyData sales, _) => sales.currency));
  }

  @override
  void initState() {
    super.initState();
    generateChartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Chart')),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Center(
                child: Column(children: <Widget>[
              Expanded(
                  child: charts.TimeSeriesChart(seriesLineData,
                      defaultRenderer: charts.LineRendererConfig(includeArea: true, stacked: true),
                      animate: true,
                      animationDuration: Duration(seconds: 2)))
            ]))));
  }
}
