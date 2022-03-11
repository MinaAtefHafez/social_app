

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/app_cubit/cubit.dart';
import 'package:social/layout/app_cubit/states.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/styles/icon_broken.dart';



class NewPostScreen extends StatelessWidget {



  var textController = TextEditingController() ;
 

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit ,SocialStates>(
      listener: ((context, state) {

        if ( state is SocialCreatePostSuccessState ) {
          showToast(
            message: 'Post Added Successfully' ,
            state:  ToastState.SUCCESS
            );
        }

      }) , 
      builder: ( context , state ) {

         
         var cubit = SocialCubit.get(context);
         var userModel = SocialCubit.get(context).userModel ;


        return Scaffold(
        backgroundColor: Colors.white ,
        appBar: AppBar(
          
          iconTheme: IconThemeData(color: Colors.black),
          titleSpacing: 0.0,
          title: Text(
            'Create Post',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
                  
                  Padding(
                    padding: const EdgeInsets.only( right: 15.0  ),
                  
                    child: TextButton(
                      onPressed: (){
                          


                        if ( cubit.postImage == null ) {
                          cubit.createPost(
                            dateTime: DateTime.now().toString() ,
                            text: textController.text  ,
                          );
                        }else {
                          cubit.uploadPostImage(
                            dateTime:  DateTime.now().toString() ,
                            text: textController.text ,
                          );
                        }
                      }, 

                       child: Text('Post')  ,
                          ),
                  ) ,
              
          ],
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
           if ( state is SocialCreatePostLoadingState )
           LinearProgressIndicator() ,
           if ( state is SocialCreatePostLoadingState )
           SizedBox(height: 10 ,) ,

              Row(
               children: [
                 CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                          '${userModel!.image}',
                        ),
                      ),
                      SizedBox( width: 15 , ) ,
                      
                      Text(
                                  'Mina Atef',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                           
               ],
              ) , 
               SizedBox(height: 5,),
               Expanded(
                 flex: 1,
                 child: TextFormField(
                   controller: textController ,
                   decoration: InputDecoration(
                     hintText: 'what is on your mind ... ' ,
                     border: InputBorder.none
                   ) ,
               
                 ),
               ) ,
                
                SizedBox(height: 20.0,) ,
            
               if ( cubit.postImage != null  )
              
                     Expanded(
                       flex: 2 ,
                       child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 400,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(cubit.postImage!) ,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0) ,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                           
                                           cubit.removePostImage();
                                    
                                  },
                                  icon: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.blue.shade800,
                                    child: Icon(
                                     Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                     ),
                  
                  SizedBox(height: 20.0,) ,

                 Row(
                   
                   children: [
                 
                     Expanded(
                       child: TextButton(
                         onPressed: (){
                           cubit.getPostImage() ;
                         },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center ,
                             children: [
                                 
                                 Icon(IconBroken.Image) ,
                                 SizedBox(width: 5.0,) ,
                                 Text('add Photo')
                     
                             ],
                          ) ,
                          
                          ),
                     ),
                   
                     
                     Expanded(
                       child: TextButton(
                         onPressed: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center ,
                             children: [
                                 
                                 Text('#tags') ,
                     
                             ],
                          ) ,
                          
                          ),
                     ),
                   
                   
                   ],
                 ) ,

            ],
          ),
        ),
      );
      } ,
    );
  }
}