


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/app_cubit/cubit.dart';
import 'package:social/layout/app_cubit/states.dart';
import 'package:social/models/post_model.dart';
import 'package:social/modules/comments/comments_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/styles/icon_broken.dart';

class FeedsScreen  extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <SocialCubit,SocialStates>(
         listener: (context,state){} ,
      builder: (context,state){

           var cubit = SocialCubit.get(context);

           return ConditionalBuilder(
               condition: cubit.posts.length > 0 && cubit.userModel != null  ,
               builder: (context) => SingleChildScrollView(
                 physics: BouncingScrollPhysics(),
                 child: Column(
                   children: [
                     Card(
                       clipBehavior: Clip.antiAliasWithSaveLayer,
                       elevation: 5.0,
                       margin: EdgeInsets.all(8.0),
                       child: Stack(
                         alignment: Alignment.bottomLeft,
                         children: [
                           Image(
                             image: NetworkImage(
                               'https://image.freepik.com/free-photo/smiling-happy-indian-student-with-backpack-pointing-his-finger-wall_496169-1532.jpg',
                             ),
                             fit: BoxFit.cover,
                             height: 200.0,
                             width: double.infinity,
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(
                               'communicate with friends',
                               style: TextStyle(
                                   fontWeight: FontWeight.w700, color: Colors.white),
                             ),
                           ),
                         ],
                       ),
                     ),
                     ListView.separated(
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (context, index) => buildPostItem( cubit.posts[index] , context ,index   ),
                       separatorBuilder: (context, index) => SizedBox(
                         height: 10.0,
                       ),
                       itemCount: cubit.posts.length,
                     ),
                     SizedBox(
                       height: 15.0,
                     ),
                   ],
                 ),
               ) ,
               fallback: (context) => Center(child: CircularProgressIndicator())  ,
           );
      } ,
    );



  }

  Widget buildPostItem( PostModel model , context , index  ) => Container(


    height: model.postImage != ''  ? 623 : 260 ,

    width: double.infinity ,

    child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5.0,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        '${model.image}'
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${model.name}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 16.0,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            '${model.dateTime}',
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 11.5),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 17.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey.shade300,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topStart ,
                  child: Text(
                    '${model.text}' ,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, height: 1.3, fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                    top: 5.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                            height: 25.0,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Text(
                                '#software',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 13),
                              ),
                              minWidth: 1.0,
                              padding: EdgeInsets.zero,
                              height: 25.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                            height: 25.0,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Text(
                                '#flutter',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 13),
                              ),
                              minWidth: 1.0,
                              padding: EdgeInsets.zero,
                              height: 25.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                if (model.postImage != '')

                  Expanded(
                    child: Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:  NetworkImage(
                              '${model.postImage}'
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Heart,
                                  color: Colors.red.shade300,
                                  size: 18.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    '${SocialCubit.get(context).likes[index]}',
                                    style: TextStyle(color: Colors.grey.shade600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  IconBroken.Chat,
                                  color: Colors.orange.shade300,
                                  size: 18.0,
                                ),
                                SizedBox(
                                  width: 5,
                                ),

                                Text(
                                  ' comments',
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey.shade300,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          SocialCubit.get(context).getComments(index: index );
                          navigateTo(context, CommentsScreen(index) ) ;
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18.0,
                              backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).userModel!.image}'
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'write a comment ...',
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 11.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                      },
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.red.shade300,
                            size: 18.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Text(
                              'Like',
                              style: TextStyle(color:  Colors.grey.shade600 ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
  );

}