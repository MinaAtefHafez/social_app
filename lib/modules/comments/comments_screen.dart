
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/app_cubit/cubit.dart';
import 'package:social/layout/app_cubit/states.dart';
import 'package:social/models/comment_model.dart';
import 'package:social/models/social_user_model.dart';



class CommentsScreen  extends StatelessWidget {

  int index ;

  CommentsScreen( this.index ) ;

  var commentController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context ,state) {} ,
      builder: (context,state) {

        var cubit = SocialCubit.get(context);


        return Scaffold(
          backgroundColor: Colors.white ,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text('Comments' , style: TextStyle( color: Colors.black  ) , ) ,
            elevation:  0.0 ,
            titleSpacing: 0.0 ,
            backgroundColor: Colors.white ,
            actions: [
              Padding(
                padding: const EdgeInsets.only( right: 15.0 ),
                child: TextButton(onPressed: (){

                  SocialCubit.get(context).setCommentPost(
                      text: commentController.text ,
                      postId: SocialCubit.get(context).postsId[index] ,
                      index: index ,

                  ) ;
                }, child: Text('Post') ),
              ) ,
            ],
          ) ,
         
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end ,
              children: [

                if ( state is SocialSetCommentPostLoadingState )
                  Align(
                      alignment: AlignmentDirectional.topCenter ,
                      child: LinearProgressIndicator()
                  ) ,



                Expanded(
            child: ListView.separated(
              itemBuilder: (context ,index) => buildCommentItem( cubit.comments[index]  ) ,
              separatorBuilder: (context , index) => SizedBox(height: 22,) ,
              itemCount: cubit.comments.length ,
              physics: BouncingScrollPhysics() ,
            ),
          ),



                Container(
                  width: double.infinity ,
                  height: 33.0,
                  child: TextFormField(
                    controller: commentController ,
                    decoration: InputDecoration(
                      border: InputBorder.none ,
                      hintText: 'what is on your mind ...' ,
                    ) ,
                  ) ,
                ) ,
              ],
            ),
          ) ,
        );
      } ,

    ) ;
  }

  Widget buildCommentItem ( CommentModel model  ) {

    return Row(
      children: [
        CircleAvatar(
          radius: 28.0 ,
          backgroundImage: NetworkImage(
              '${model.image}'
          ) ,
        ) ,
        SizedBox(width: 10 ,) ,
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200 ,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8) ,
              bottomRight: Radius.circular(8) ,
              topRight: Radius.circular(8) ,

            ) ,
          ) ,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                Text ( '${model.name} '  ,style:  TextStyle( fontWeight: FontWeight.bold ), ) ,
                SizedBox(height: 7,) ,
                Text('${model.text}' , style: TextStyle( fontSize: 16 ) , ) ,
              ],
            ),
          ),
        ) ,
      ],

    ) ;

  }

}
