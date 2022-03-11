

 import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/layout_screen.dart';
import 'package:social/modules/login/cubit/login_cubit.dart';
import 'package:social/modules/login/cubit/states.dart';
import 'package:social/modules/register/register_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/network/local/remote/cache_helper.dart';


class SocialLoginScreen extends StatelessWidget {
   
    var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();




   @override
   Widget build(BuildContext context) {
      return BlocProvider(create: (BuildContext context) { 
        return SocialLoginCubit() ;
       },
       child: BlocConsumer<SocialLoginCubit ,SocialLoginStates>(
         listener: (context, state) {
           if (state is SocialLoginErrorState) {
            showToast(
              message: state.error,
              state: ToastState.ERROR,
            );
          } else if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              uId = CacheHelper.getData(key: 'uId');

              navigateAndFinish(context, SocialLayoutScreen());

            });
          }
         },
         builder: (context ,state) {



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
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'login now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: Icon(Icons.email_outlined),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),
                              hoverColor: Colors.blue),
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
                                    Icon(SocialLoginCubit.get(context).suffix),
                                onPressed: () {
                                  SocialLoginCubit.get(context)
                                      .changePasswordVisibility();
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),
                              hoverColor: Colors.blue),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please , enter your password';
                            }
                            return null;
                          },
                          obscureText: SocialLoginCubit.get(context).isPassword,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          height: 45,
                          width: double.infinity,
                          child: ConditionalBuilder(
                            condition: state is! SocialLoginLoadingState,
                            builder: (context) => MaterialButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: Text('LOGIN'),
                              color: Colors.blue,
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, SocialRegisterScreen());
                              },
                              child: Text('Register'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
         } , 
       ),

      );



   }
 }