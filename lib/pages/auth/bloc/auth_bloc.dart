import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currnecy_app/widgets/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../model/user_model.dart';
import '../../home/home.dart';
import 'auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Cubit <AuthStates>{
    AuthBloc() : super(AuthInitialState());
    AuthBloc get(context) => BlocProvider.of(context);
    UserModel userModel = UserModel();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final GoogleSignIn  googleSignIn = GoogleSignIn();

  bool userCredentialValidation({TextEditingController emailController, TextEditingController passwordController}){
    if(emailController.text != "" && passwordController.text != ""){
      return true;
    }else{
      return false;
    }
  }
     firebaseLogInMethod({TextEditingController emailController, TextEditingController passwordController,BuildContext context}) async{
       if(userCredentialValidation(emailController: emailController,passwordController: passwordController)){
        await firebaseAuth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value){
          createAndSaveUser(userName: value.user.displayName,userEmail: value.user.email,context: context);
        }).onError((error, stackTrace){
            FlushbarView().showFlushBar(context: context,flushbarMsg: error.toString());
        });
       }
  }
  createUser({String userName, String userEmail}){
    userName = userModel.name;
    userEmail = userModel.email;
  }
  Future saveUserToFireStore({String userName,String userEmail,BuildContext context})async{
    firestore.collection("users").add({"name":"$userName","email":"$userEmail"}).then((value){
      loginSuccess(context: context);
      });
  }
  googleSignInMethod({BuildContext context}) async{
    await googleSignIn.signIn().then((value){
        createAndSaveUser(userName: value.displayName,userEmail: value.email,context: context);
        });
  }
  loginSuccess({BuildContext context}){
    Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => HomeApp()),(route) => false);
    }
    firebaseSignUpMethod({String email, String password,BuildContext context}) async{
    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value){
        createAndSaveUser(userName: value.user.displayName,userEmail: value.user.email,context: context);
        }).onError((error, stackTrace){
            FlushbarView().showFlushBar(context: context,flushbarMsg: error.toString());
        });   
  }
  createAndSaveUser({String userName,String userEmail,BuildContext context})async{
    createUser(userName: userName,userEmail: userEmail);
    await saveUserToFireStore(userName: userModel.name,userEmail: userModel.email).then((value){
      loginSuccess(context: context);
  });
  }
}