import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_states.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthStates>(
          listener: (context, state) {},
          builder: (context, state) => Scaffold(
              appBar: AppBar(title: Text("Sign Up")),
              body: Container(
                  padding: EdgeInsets.all(15),
                  child: (Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(hintText: "Enter your email.")),
                        TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(hintText: "Enter your password.")),
                        SizedBox(height: 15),
                        ElevatedButton(
                            child: Text("Sign Up"),
                            onPressed: () {
                              AuthBloc().get(context).firebaseSignUpMethod(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context);
                            },
                            )
                      ]))))
        ));
  }
}
