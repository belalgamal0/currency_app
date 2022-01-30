
import 'package:currnecy_app/pages/singelton.dart';
import 'package:flutter/material.dart';
import '../home/bloc/home_bloc.dart';

class CurrentRates extends StatefulWidget {
  final String currencyName;
  CurrentRates({this.currencyName});
  @override
  _CurrentRatesState createState() => _CurrentRatesState();
}

class _CurrentRatesState extends State<CurrentRates> {

  @override void initState() {
    super.initState();
    HomeBloc().get(context).getCurrentRates(currencyName: widget.currencyName).then((value){
      setState(() {
        HomeBloc().get(context).loading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Currency Rates")),
      body: Container(
       padding: EdgeInsets.all(25),
        child:  HomeBloc().get(context).loading ? Center(child: CircularProgressIndicator()) : Column(
          children:[
            Text("Current Base Currency is " + Singleton().currency),
            SizedBox(height: 25),
            Expanded(child: ListView.separated(separatorBuilder: (context, index) => Divider(),itemCount: HomeBloc().get(context).currencies.length,itemBuilder: (context, index) => Text(HomeBloc().get(context).currencies[index].name + "  " + HomeBloc().get(context).currencies[index].value.toString())))
          ])));
  }
}