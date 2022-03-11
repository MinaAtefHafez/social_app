
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/social_user_model.dart';
import 'package:social/modules/register/cubit/states.dart';


class SocialRegisterCubit extends Cubit <SocialRegisterStates> {

  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);





  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {

    emit(SocialRegisterLoadingState());

    try {
      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      userCreate(
          email: email,
          phone: phone,
          name: name,
          uId: user.user!.uid
      );
      emit(SocialRegisterSuccessState());

    } on FirebaseAuthException catch (error) {

      if (error.code == 'weak-password')
        emit(SocialRegisterErrorState('the password is very weak'));
      else if (error.code == 'email-already-in-use')
        emit(SocialRegisterErrorState(
            'the account already exist for this email'));
    }
  }



  void userCreate({
    required String email,
    required String phone,
    required String name,
    required String uId,
  }) {
    SocialUserModel? model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image:
          'https://image.freepik.com/free-photo/horizontal-shot-happy-european-woman-with-curly-blonde-hair-stretches-collar-jumper-wears-leather-jacket-feels-happy-isolated-yellow-background-people-emotions-clothes-concept_273609-57831.jpg?w=1060',
      cover:
          'https://image.freepik.com/free-photo/penne-pasta-tomato-sauce-with-meat-tomatoes-decorated-with-pea-sprouts-dark-table_2829-3411.jpg?w=1060',
      bio: 'write your bio ...',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      print('create success');
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
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
