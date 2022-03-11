
abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdate2LoadingState extends SocialStates {}


 // CREATE POST
 
class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}


 // Likes

 class SocialLikePostSuccessState extends SocialStates {}

 class SocialLikePostErrorState extends SocialStates {

   final String error;

  SocialLikePostErrorState(this.error);
 }


 // Comments

class SocialSetCommentPostLoadingState extends SocialStates {}

class SocialSetCommentPostSuccessState extends SocialStates {}

class SocialSetCommentPostErrorState extends SocialStates {
  final String error ;

  SocialSetCommentPostErrorState(this.error);

}

class SocialGetCommentsPostLoadingState extends SocialStates {}

class SocialGetCommentsPostSuccessState extends SocialStates {}

class SocialGetCommentsPostErrorState extends SocialStates {
  final String error ;

  SocialGetCommentsPostErrorState(this.error);
}

// Chats

class SocialGetAllUserLoadingState extends SocialStates {}

class SocialGetAllUserSuccessState extends SocialStates {}

class SocialGetAllUserErrorState extends SocialStates {
  final String error;

  SocialGetAllUserErrorState(this.error);
}

class SocialSendMessageLoadingState extends SocialStates {}

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {
  final String error ;

  SocialSendMessageErrorState(this.error);
}

class SocialGetMessagesSuccessState extends SocialStates {}




