
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/app_cubit/cubit.dart';
import 'package:social/layout/app_cubit/states.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/social_user_model.dart';
import 'package:social/shared/styles/colors.dart';
import 'package:social/shared/styles/icon_broken.dart';


class ChatDetailsScreen extends StatelessWidget {

    SocialUserModel userModel ;
    ChatDetailsScreen(this.userModel);

    var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {

        SocialCubit.get(context).getMessages( userModel.uId! ); 

        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){
          
          } ,
          builder: (context ,state) {

            var cubit = SocialCubit.get(context); 

            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white ) ,
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                          '${userModel.image}'
                      ) ,

                    ) ,
                    SizedBox(width: 15.0,) ,
                    Text('${userModel.name}' , style: TextStyle (
                        fontWeight: FontWeight.bold , fontSize:  17.0
                    ) ,
                    ) ,

                  ],
                ),
              ) ,
              body: ConditionalBuilder(
                condition: cubit.messages.length > 0 ,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [

                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {

                            var message = cubit.messages[index] ;

                            if ( cubit.userModel!.uId == message.senderId  )
                              return myAlign(
                                message
                              ) ;

                            if ( cubit.userModel!.uId != message.senderId )
                              return hisAlign(
                                message
                              ) ;

                            return Text('') ;
                          } ,
                          separatorBuilder: (context , index) => SizedBox(height: 15.0,) ,
                          itemCount: cubit.messages.length  ,

                        ),
                      ) ,

                      Spacer() ,
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300 ,
                            width: 1.0 ,
                          ) ,
                          borderRadius: BorderRadius.circular(15.0) ,
                        ) ,
                        clipBehavior: Clip.antiAliasWithSaveLayer ,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController ,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 13.0 ,color: Colors.grey.shade800  ) ,
                                  border: InputBorder.none ,
                                  hintText: '     type your message here ...',
                                ) ,

                              ),
                            ) ,
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue ,


                              ) ,


                              child: MaterialButton(onPressed: (){
                                cubit.sendMessage(
                                  receiverId: userModel.uId ,
                                  message: messageController.text ,
                                );
                              } ,
                                minWidth: 1.0,
                                child: Icon(
                                  IconBroken.Send ,
                                  color: Colors.white ,
                                  size: 16.0,
                                ) ,
                              ),
                            ) ,
                          ],
                        ),
                      ) ,
                    ],
                  ),
                )  ,
                fallback: (context) => Center(child: CircularProgressIndicator()) ,
              ) ,
            );
          } ,

        );
      }
    );
  }
  
  Widget myAlign ( MessageModel model ) {
     return Align(
       alignment: AlignmentDirectional.centerEnd ,
       child: Container(
         decoration: BoxDecoration(
           color: defaultColor.withOpacity(0.4),
           borderRadius: BorderRadiusDirectional.only(
             bottomStart:  Radius.circular(10) ,
             topStart: Radius.circular(10)  ,
             topEnd:Radius.circular(10) ,
           )  ,
         ) ,
         child: Padding(
           padding: const EdgeInsets.symmetric( vertical: 5.0 ,horizontal: 10.0 ),
           child: Text(model.text!),
         ) ,
       ),
     );

  }

  Widget  hisAlign ( MessageModel model ) {
    return Align(
      alignment: AlignmentDirectional.centerStart ,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd:  Radius.circular(10) ,
            topStart: Radius.circular(10)  ,
            topEnd:Radius.circular(10) ,
          )  ,
        ) ,
        child: Padding(
          padding: const EdgeInsets.symmetric( vertical: 5.0 ,horizontal: 10.0 ),
          child: Text(model.text!),
        ) ,
      ),
    );
  }
  
}
