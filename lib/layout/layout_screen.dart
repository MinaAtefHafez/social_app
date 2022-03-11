

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/app_cubit/cubit.dart';
import 'package:social/layout/app_cubit/states.dart';
import 'package:social/modules/posts/new_post_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/styles/icon_broken.dart';


class SocialLayoutScreen extends StatelessWidget {
  
     

  @override
  Widget build(BuildContext context) {

    return 

     BlocConsumer<SocialCubit ,SocialStates>(
       listener: (context ,state){
         if (state is SocialNewPostState ) {
           navigateTo(context, NewPostScreen() ) ;
         }
       } ,
       builder: (context ,state) {
         var cubit = SocialCubit.get(context);
         return Scaffold(
           
      appBar: AppBar(
        backgroundColor: Colors.white ,
              title: Text(
                cubit.titles[cubit.currentIndex] ,
                style: TextStyle(color: Colors.black),
              ) ,
            ),

             bottomNavigationBar: BottomNavigationBar(
               backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey.shade500,
            elevation: 0.0,
             currentIndex: cubit.indexToggle(cubit.currentIndex) ,
                 items: [
                   BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Settings'),

                 ],
                   
                   onTap: (index){
                     cubit.changeBottomNav(index);
                   } , 
                
             ) ,

             body: cubit.screens![cubit.currentIndex] ,

            
    );
       } ,
    
          
    );
  
  }
}