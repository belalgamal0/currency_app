import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/currency_app/currency_app.dart';
import 'pages/home/bloc/home_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
      providers: [BlocProvider<HomeBloc>(create: (context) => HomeBloc())],
      child: CurrencyApp()));
}

