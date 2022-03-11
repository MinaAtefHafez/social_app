import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social/shared/styles/colors.dart';



ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:  AppBarTheme(
      titleSpacing: 20.0,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white, statusBarBrightness: Brightness.light),
      titleTextStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
      elevation: 0.0,
      iconTheme:  IconThemeData(color: Colors.white)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);

ThemeData lightTheme =  ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white, statusBarBrightness: Brightness.dark),
      titleTextStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
);
