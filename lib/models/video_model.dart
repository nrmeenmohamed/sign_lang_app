class VideoModel{
  String? name;
  String? link;
  String? categoryId;


  VideoModel({
    this.name,
    this.link,
    this.categoryId
  });

  // retrieve data from firebase
  VideoModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    link = json['link'];
    categoryId = json['categoryId'];
  }

  // add data to firebase
  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'link' : link,
      'categoryId' : categoryId,
    };
  }


}