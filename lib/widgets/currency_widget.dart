import '../pages/currency_home/currency_details_page.dart';
import 'package:flutter/material.dart';

class CurrencyWidget extends StatelessWidget {
  final String currencyName;
  final String rt;
  CurrencyWidget({this.currencyName, this.rt});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CurrencyDetailsPage(currencyName: currencyName)));
        },
        child: Text("$currencyName   $rt"));
  }
}
