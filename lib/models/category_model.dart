class CategoryModel{
  String? name;
  String? image;
  String? categoryId;


  CategoryModel({
    this.name,
    this.image,
    this.categoryId
  });

  // retrieve data from firebase
  CategoryModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    image = json['image'];
    categoryId = json['categoryId'];
  }

  // add data to firebase
  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'image' : image,
      'categoryId' : categoryId,
    };
  }


}