abstract class SocialStates{}

class InitialSocialState extends SocialStates{}

class SocialChangeBottomNavState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialStates{}
class SocialGetAllUsersSuccessState extends SocialStates{}
class SocialGetAllUsersErrorState extends SocialStates{
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

// picked profile image
class SocialProfileImagePickedSuccessState extends SocialStates{}
class SocialProfileImagePickedErrorState extends SocialStates{}

// upload profile image

class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}

// picked cover image
class SocialCoverImagePickedSuccessState extends SocialStates{}
class SocialCoverImagePickedErrorState extends SocialStates{}

// // upload Cover image
class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUserUpdateLoadingState extends SocialStates{}
class SocialUserUpdateSuccessState extends SocialStates{}
class SocialUserUpdateErrorState extends SocialStates{
  final String error;

  SocialUserUpdateErrorState(this.error);
}

// Create Post

class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}

// picked post Image
class SocialPostImagePickedSuccessState extends SocialStates{}
class SocialPostImagePickedErrorState extends SocialStates{}

// upload post image
class SocialUploadPostImageSuccessState extends SocialStates{}
class SocialUploadPostImageErrorState extends SocialStates{}

class SocialRemovePostState extends SocialStates{}

// get Posts

class SocialGetPostsLoadingState extends SocialStates{}
class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  final String error;

  SocialGetPostsErrorState(this.error);
}

// like post

class SocialGetLikePostsSuccessState extends SocialStates{}
class SocialGetLikePostsErrorState extends SocialStates{
  final String error;

  SocialGetLikePostsErrorState(this.error);
}

class SocialGetNumberLikePostsSuccessState extends SocialStates{}
class SocialGetNumberLikePostsErrorState extends SocialStates{
  final String error;

  SocialGetNumberLikePostsErrorState(this.error);
}

// send message

class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{
  final String error;

  SocialSendMessageErrorState(this.error);
}

class SocialGetMessageSuccessState extends SocialStates{}


