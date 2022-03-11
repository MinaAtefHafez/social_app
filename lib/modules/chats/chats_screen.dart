

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/app_cubit/cubit.dart';
import 'package:social/layout/app_cubit/states.dart';
import 'package:social/models/social_user_model.dart';
import 'package:social/modules/chat_details/chat_details_screen.dart';
import 'package:social/shared/components/components.dart';


class ChatsScreen  extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context , state){} ,
      builder: (context ,state) {

          var cubit = SocialCubit.get(context) ;

          return ConditionalBuilder(
            condition: cubit.users.length > 0 ,

            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),

              child: ListView.separated(
                itemBuilder: (context, index) => buildChatItem( cubit.users[index] ,context )  ,
                separatorBuilder: (context,index) => myDivider() ,
                itemCount: cubit.users.length ,
                physics: BouncingScrollPhysics() ,


              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()) ,
          );

      },
    );
  }

  Widget buildChatItem ( SocialUserModel model ,context ) => InkWell(
    onTap: (){
      navigateTo( context ,  ChatDetailsScreen(model));
    } ,
    child: Row(
      children: [
        CircleAvatar(
          radius: 30.0 ,
          backgroundImage: NetworkImage(
            '${model.image}'
          ) ,
        ) ,
        SizedBox(width: 15.0,) ,

        Text('${model.name}' , style: TextStyle( fontWeight: FontWeight.bold ,color: Colors.black ) , ),
      ],
    ),
  );

}