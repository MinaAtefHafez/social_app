

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/login/cubit/states.dart';


class SocialLoginCubit extends Cubit <SocialLoginStates> {

   SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);





  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(SocialLoginLoadingState());

    try {
      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      emit(SocialLoginSuccessState(user.user!.uid));
    } on FirebaseAuthException catch (error) {
      emit(SocialLoginErrorState(error.code.toString()));
    }
  }







  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibilityState());
  }


   
   
}