

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/login/login_screen.dart';
import 'package:social/modules/register/cubit/register_cubit.dart';
import 'package:social/modules/register/cubit/states.dart';
import 'package:social/shared/components/components.dart';



class SocialRegisterScreen extends StatelessWidget {
  
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) { 
      return SocialRegisterCubit() ;
     },

     child: BlocConsumer<SocialRegisterCubit , SocialRegisterStates>(
       listener: (context ,state){
         if (state is SocialRegisterErrorState) {
            showToast(
              message: state.error,
              state: ToastState.ERROR,
            );
          } else if (state is SocialRegisterSuccessState) {
            showToast(
                    message: 'you are Registered Successfully',
                    state: ToastState.SUCCESS)
                .then((value) {
              navigateAndFinish(context, SocialLoginScreen());
            });
          }
       } ,
       builder: (context ,state ){
         return Scaffold(
            appBar: AppBar(
              title: Text('Social App'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'register now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            prefixIcon: Icon(Icons.person),
                          ),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty)
                              return ' please , name must not be empty ';

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            labelText: 'Email Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please , enter your email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.email_outlined),
                            suffixIcon: IconButton(
                              icon:
                                  Icon(SocialRegisterCubit.get(context).suffix),
                              onPressed: () {
                                SocialRegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please , enter your password';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {},
                          obscureText:
                              SocialRegisterCubit.get(context).isPassword,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            labelText: 'Phone',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            prefixIcon: Icon(Icons.phone),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'please , phone must not be empty ';

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          height: 45,
                          width: double.infinity,
                          child: ConditionalBuilder(
                            condition: state is! SocialRegisterLoadingState,
                            builder: (context) => MaterialButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              child: Text('Register'),
                              color: Colors.blue,
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
       } ,
     ) ,
      
    );
  }
}