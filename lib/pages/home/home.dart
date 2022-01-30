
import 'package:currnecy_app/pages/converter/converter.dart';
import 'package:currnecy_app/pages/search/search.dart';
import 'package:currnecy_app/widgets/currency_widget.dart';
import 'package:flutter/material.dart';

import 'bloc/home_bloc.dart';

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}



class _HomeAppState extends State<HomeApp> {

  @override
  void initState() {
    super.initState();
     HomeBloc().get(context).getCurrencies().then((value){
       setState((){
         HomeBloc().get(context).loading = false;
       });
     });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            title: Text("Home"),
            actions: [
              IconButton(
                  onPressed: () {

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  SearchScreen(
                            //AmountConverterPage(currency: HomeBloc().get(context).currencies)
                            )));
                  },
                  icon: Icon(Icons.search))
            ],
        ),
        body: Container(
            padding: EdgeInsets.all(25),
            child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CurrencyConverter()));
                }, child: Text("Convert Currency")),]),
              SizedBox(height: 20),
                HomeBloc().get(context).loading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
                            itemBuilder: (context, index) => CurrencyWidget(currencyName: HomeBloc().get(context).currencies[index].name,rt: HomeBloc().get(context).currencies[index].value.toString()),
                            itemCount: HomeBloc().get(context).currencies.length))
              ],
            )),
        ),
      
          
    );
  }
}





