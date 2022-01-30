import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
final navigatorKey = GlobalKey<NavigatorState>();

class CurrencyApp extends StatelessWidget {
  final FirebaseFirestore firebaseFirestore;
  CurrencyApp({this.firebaseFirestore});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        key: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey.shade600)),
            appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey)),
        home: SignInPage());
  }
}
