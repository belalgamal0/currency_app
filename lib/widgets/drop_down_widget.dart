import '../pages/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
class DropDownWidget extends StatefulWidget {
  final String firstCurrency;
  final Function(String test) onChangeResponse;
  DropDownWidget(this.firstCurrency,this.onChangeResponse);
  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
                    hint: widget.firstCurrency == null? Text('Select') : Text(widget.firstCurrency),
                    iconSize: 30.0,
                    items: HomeBloc().get(context).currencies.map((currency) => currency.name).map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val));
                      }).toList(),
                    onChanged: widget.onChangeResponse
                  );
  }
}
