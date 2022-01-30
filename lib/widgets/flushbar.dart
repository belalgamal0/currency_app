import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
class FlushbarView{
  showFlushBar({String flushbarMsg,BuildContext context})async{
     await Flushbar(duration: Duration(seconds: 2),message: flushbarMsg)..show(context);
  }
}