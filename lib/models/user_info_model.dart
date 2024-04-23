class UserModel{
  String? username;
  String? email;
  String? age;
  String? image;
  String? userId;


  UserModel({
    this.username,
    this.email,
    this.age,
    this.image,
    this.userId,
});


  // retrieve data from firebase
  UserModel.fromJson(Map<String, dynamic> json){
    username = json['username'];
    email = json['email'];
    age = json['age'];
    image = json['image'];
    userId = json['userId'];
  }

  // add data to firebase
  Map<String, dynamic> toMap(){
    return {
      'username' : username,
      'email' : email,
      'age' : age,
      'image' : image,
      'userId' : userId,
    };
  }

}