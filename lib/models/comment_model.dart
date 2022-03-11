

class CommentModel {
  String? image ;
  String? name ;
  String? text ;
  String? dateTime ;


  CommentModel( { this.name , this.image , this.text , this.dateTime } ) ;


  CommentModel.fromJson ( Map <String, dynamic> json ) {
     name = json['name'] ;
     image = json['image'] ;
     text = json['text'] ;

  }


  Map <String,dynamic> toMap () {
    return {
      'name' : name ,
      'image' : image ,
      'text' : text ,
      'dateTime' : dateTime
    };
  }


}