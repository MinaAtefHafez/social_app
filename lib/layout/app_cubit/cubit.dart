import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social/layout/app_cubit/states.dart';
import 'package:social/models/comment_model.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/post_model.dart';
import 'package:social/models/social_user_model.dart';
import 'package:social/modules/chats/chats_screen.dart';
import 'package:social/modules/feeds/feeds_screen.dart';
import 'package:social/modules/settings/settings_screen.dart';
import 'package:social/modules/users/users_screen.dart';
import 'package:social/shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {

   SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);



  
  SocialUserModel? userModel;

  void getUserDate() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);

      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }



  int currentIndex = 0;
  

  List<Widget>? screens = [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  List<String> titles = ['Home', 'Chats', 'Users', 'Settings'];

  void changeBottomNav(int index) {
    if (index == 2)
      emit(SocialNewPostState());
    else if (index == 0) {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    } else if (index == 3) {
      currentIndex = 2;
      emit(SocialChangeBottomNavState());
    } else if (index == 4) {
      currentIndex = 3;
      emit(SocialChangeBottomNavState());
    }else if ( index == 1 ) {
      currentIndex = index ;
      getUsers();
    }
  }

 
 
  int indexToggle(int index) {
    if (index < 2) return currentIndex;

    return currentIndex + 1;
  }


  
  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      
      emit(SocialProfileImagePickedSuccessState());
      
    } else {

      print('no image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  
  ImageProvider changeProfileImage(profileImage) {
    if (profileImage == null) {
      return NetworkImage('${userModel!.image}');
    }
    return FileImage(profileImage!);
  }

 
 
  File? coverImage;

  Future<void> getCoverImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

 
 
  ImageProvider changeCoverImage(coverImage) {
    if (coverImage == null) return NetworkImage('${userModel!.cover}');

    return FileImage(coverImage);
  }




  Future <void> uploadProfileImage (
   {
     required String name ,
     required String bio ,
     required String phone ,
}
      ) async {

    emit(SocialUserUpdate2LoadingState());


    firebase_storage.FirebaseStorage.instance 
    .ref()
    .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
    .putFile(profileImage!)
    .then((value)  {
       value.ref.getDownloadURL().then((val) {

           updateUser(
             name: name ,
             bio: bio ,
             phone: phone ,
             image: val ,
           );



         emit(SocialUploadProfileImageSuccessState());
       }).catchError((error){
         print(error.toString());
         emit(SocialUploadProfileImageErrorState()) ;
       });
    })
    .catchError((error){
      print(error.toString());
      emit(SocialUploadProfileImageErrorState());
    });

  }

   

    

   Future <void> uploadCoverImage ({

     required String name,
     required String bio ,
     required String phone ,
   }
       )  async {

       emit(SocialUserUpdate2LoadingState());

    firebase_storage.FirebaseStorage.instance
    .ref()
    .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
    .putFile(coverImage!)
    .then((value)  {
       value.ref.getDownloadURL().then((val) {

         updateUser(
             name: name ,
             bio: bio ,
             phone: phone ,
             cover: val
         );

         print (val) ;

         emit(SocialUploadCoverImageSuccessState());
       }).catchError((error){
         print(error.toString());
         emit(SocialUploadCoverImageErrorState()) ;
       });
    })
    .catchError((error){
      print(error.toString());
      emit(SocialUploadCoverImageErrorState());
    });

  }


   Future <void> updateUser  (
   {
      String? name ,
      String? bio ,
      String? phone ,
     String? image ,
     String? cover ,
   }
       ) async {

         emit(SocialUserUpdateLoadingState()) ;
        


           SocialUserModel? model2 = SocialUserModel(
       name: name ,
       phone: phone ,
       bio: bio ,
       image: image?? userModel!.image ,
      cover: cover?? userModel!.cover ,
      email: userModel!.email ,
       isEmailVerified: false,
       uId: uId ,
     );


      FirebaseFirestore.instance
          .collection('users')
          .doc(model2.uId).update(
               model2.toMap()
      ).then((value) {

           getUserDate() ;

      }).catchError((error){

        emit(SocialUserUpdateErrorState());

      });


        }



       
       File? postImage;
  

  Future<void> getPostImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      
      emit(SocialPostImagePickedSuccessState());
      
    } else {
      print('no image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }
      
      
      
      
      
        void uploadPostImage (
   {
      String? dateTime,
      String? text, 
   }
       )  {

         emit(SocialCreatePostLoadingState()) ;
        
         firebase_storage.FirebaseStorage.instance
    .ref()
    .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
    .putFile(postImage!)
    .then((value)  {
       value.ref.getDownloadURL().then((val) {

            createPost(
              dateTime: dateTime ,
              text: text ,
              postImage: val 
            );
          
          removePostImage();
         emit(SocialCreatePostSuccessState());
       }).catchError((error){
         print(error.toString());
         emit(SocialCreatePostErrorState()) ;
       });
    })
    .catchError((error){
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });

 }



        
      void createPost ({
      
      String? dateTime ,
      String? text, 
      String? postImage
         

      }) {


        emit(SocialCreatePostLoadingState());

            PostModel model = PostModel(
              name: userModel!.name ,
              uId:  userModel!.uId ,
              image: userModel!.image ,
              dateTime: dateTime ,
              text:  text ,
              postImage: postImage??''  ,
            ) ;

            
            
          FirebaseFirestore.instance
        .collection('posts')
        
        .add(model.toMap())
        .then((value) {

          getPosts() ;

      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
        


      }


     void removePostImage () {
       postImage = null ;
       emit(SocialRemovePostImageState());
     }



      // Lists

     List <PostModel> posts = [] ;
     List <String> postsId = [] ;
     List <int> likes = [] ;
     List <CommentModel> comments = [] ;
     List <SocialUserModel> users  =[] ;
     List <MessageModel> messages = [] ;
     
      

      bool like = false  ;  


     void getPosts ()
     {

          posts =  [] ;
         FirebaseFirestore.instance
             .collection('posts').orderBy('dateTime')
             .get().then((value) {

                value.docs.forEach((element) {

                    element.reference.collection('likes')
                    .get().then((value) {

                          likes.add(value.docs.length);
                          posts.add(PostModel.fromJson(element.data()));
                          postsId.add(element.id) ;

                           emit(SocialGetPostsSuccessState());
                    }).catchError((error){

                      emit(SocialGetPostsErrorState(error.toString())) ;

                    });

                
                });

                emit(SocialGetPostsSuccessState());

         }).catchError((error){
           
           emit(SocialGetPostsErrorState(error.toString())) ;

         });
     }




       
      
      void likePost ( String postId )
      {


        
        FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId).set(
               {
                 'like' : true
               }
        ).then((value) {

          emit(SocialLikePostSuccessState()) ;

        }).catchError((error){

          emit( SocialLikePostErrorState(error.toString()));
    
        });

      }




     void setCommentPost ({
       String? text ,
       String? postId ,
       int? index
}
) {

       emit(SocialSetCommentPostLoadingState()) ;

       CommentModel model = CommentModel(
         name: userModel!.name  ,
         image:  userModel!.image ,
         text:  text ,
         dateTime: DateTime.now().toString() 

       ) ;

       FirebaseFirestore.instance.collection('posts')
           .doc(postId).collection('comments').add(

                 model.toMap()

       ).then((value) {



           getComments( index: index  ) ;

         emit(SocialSetCommentPostSuccessState()) ;

       }).catchError((error){

         emit(SocialSetCommentPostErrorState(error.toString()));

       });


     }

     void getComments ( {  index  } )
     {

       comments = [] ;



       FirebaseFirestore.instance
       .collection('posts').doc(postsId[index])
       .collection('comments').orderBy('dateTime').get().then((value) {



         value.docs.forEach((element) {
           comments.add( CommentModel.fromJson(element.data()) ) ;

           emit(SocialGetCommentsPostSuccessState()) ;
         });


       }).catchError((error){
         emit(SocialGetCommentsPostErrorState(error.toString())) ;

       }) ;

     }



    void getUsers ()
    {
       users =[] ;

       emit(SocialGetAllUserLoadingState());

       FirebaseFirestore.instance
           .collection('users').get()
           .then((value) {
             value.docs.forEach((element) {
               if ( element.id != userModel!.uId )
               users.add( SocialUserModel.fromJson(element.data())) ;

               emit(SocialGetAllUserSuccessState());

             });

       }).catchError((error){
         emit(SocialGetAllUserErrorState(error.toString())) ;
       }) ;

    }


       void sendMessage (
           {
             required String? receiverId ,
             required String? message
           }
           ) {

       emit( SocialSendMessageLoadingState()  ) ;

       MessageModel model = MessageModel(
           text : message ,
           senderId : userModel!.uId ,
           receiverId : receiverId ,
           dateTime : DateTime.now().toString() ,
       );



       FirebaseFirestore.instance
           .collection('users').doc(userModel!.uId)
           .collection('chats').doc(receiverId)
           .collection('messages').add(
         model.toMap()

       ).then((value) {

         emit(SocialSendMessageSuccessState() ) ;

       }).catchError((error){
         emit(SocialSendMessageErrorState(error.toString()));

       });


       MessageModel model2 = MessageModel(
         text : message ,
         senderId : receiverId ,
         receiverId : userModel!.uId ,
         dateTime : DateTime.now().toString() ,
       );

       FirebaseFirestore.instance
           .collection('users').doc(receiverId)
           .collection('chats').doc(userModel!.uId)
           .collection('messages').add(
           model2.toMap()
       ).then((value) {
         emit(SocialSendMessageSuccessState() ) ;
       }).catchError((error){
         emit(SocialSendMessageErrorState(error.toString()));
       }) ;




       }



       void getMessages (
           String receiverId ,
           ) {

         FirebaseFirestore.instance.collection('users')
             .doc(userModel!.uId).collection('chats')
             .doc(receiverId).collection('messages')
             .orderBy( 'dateTime' )
             .snapshots().listen((event) {

               messages =[] ;

               event.docs.forEach((element) {
                 messages.add( MessageModel.fromJson( element.data() ) ) ;
               }) ;

         });
         emit(SocialGetMessagesSuccessState());

       }


 
   }


