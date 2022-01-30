import 'bloc/auth_bloc.dart';
import 'bloc/auth_states.dart';
import 'sign_up_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthStates>(
            listener: (context, state) {},
            builder: (context, state) => Scaffold(
                appBar: AppBar(title: Text("Log In")),
                body: Container(
                    padding: EdgeInsets.all(15),
                    child: (Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                  hintText: "Enter your email.")),
                          TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Enter your password.")),
                          SizedBox(height: 15),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      AuthBloc().get(context).googleSignInMethod(context: context);
                                    },
                                    child: Text("Google Sign In")),
                                ElevatedButton(
                                    child: Text("Log In"),
                                    onPressed: () {
                                      AuthBloc().get(context).firebaseLogInMethod(emailController: emailController, passwordController: passwordController, context: context);
                                    })
                              ]),
                          SizedBox(height: 20),
                          RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: 'Don\'t have account ? ',
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                style: TextStyle(color: Colors.blue),
                                text: 'Sign Up',
                                recognizer: TapGestureRecognizer()..onTap = () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                                  })
                          ]))
                        ]))))));
  }
}
