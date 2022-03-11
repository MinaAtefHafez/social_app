
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/app_cubit/cubit.dart';
import 'package:social/layout/app_cubit/states.dart';
import 'package:social/layout/layout_screen.dart';
import 'package:social/modules/login/login_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/network/local/remote/cache_helper.dart';
import 'package:social/shared/network/local/remote/dio_helper.dart';
import 'firebase_options.dart';


 Future <void> firebaseMessagingBackgroundHandler ( RemoteMessage message ) async
 {
          showToast(message: 'onBackgroundMessage', state: ToastState.SUCCESS) ;
 }


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Widget? widget ;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var token = await FirebaseMessaging.instance.getToken() ;

  FirebaseMessaging.onMessage.listen((event) {

  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    showToast(message: 'onMessage', state: ToastState.SUCCESS) ;
    showToast(message: 'onMessageOpenedApp', state: ToastState.SUCCESS) ;
  });


  FirebaseMessaging.onBackgroundMessage( firebaseMessagingBackgroundHandler ) ;


  print (token) ;

  DioHelper.init();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  
  







  if ( uId != null ) {  
    widget = SocialLayoutScreen();  
  }else {
    widget = SocialLoginScreen() ;
  }



  runApp( MyApp( widget ));
}

class MyApp extends StatelessWidget {

  final Widget startWidget ;

   MyApp( this.startWidget) ; 
  

  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) { return SocialCubit()..getUserDate()..getPosts(); },),
      ],
      child: BlocConsumer<SocialCubit,SocialStates>( 
               listener: (context ,state){} ,
               builder: (context ,state) {
                 return MaterialApp(
                  debugShowCheckedModeBanner: false,
                   home: startWidget  ,
             );
          } ,
       ) ,
    );
  }
}




