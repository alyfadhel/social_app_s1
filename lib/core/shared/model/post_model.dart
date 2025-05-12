class PostModel {
  final String name;
  final String uId;
  final String image;
  final String text;
  final String dateTime;
  final String postImage;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.text,
    required this.dateTime,
    required this.postImage,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      name: json['name'],
      uId: json['uId'],
      image: json['image'],
      text: json['text'],
      dateTime: json['dateTime'],
      postImage: json['postImage'],
    );
  }

  Map<String,dynamic>toMap(){
    return {
      'name' : name,
      'uId' : uId,
      'image' : image,
      'text' : text,
      'dateTime' : dateTime,
      'postImage' : postImage,
    };
  }
}
