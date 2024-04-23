class ReviewListModel{
  String? videoWord;
  String? videoUrl;
  String? reviewListId;




  ReviewListModel({
    this.videoWord,
    this.videoUrl,
    this.reviewListId,

  });

  // retrieve data from firebase
  ReviewListModel.fromJson(Map<String, dynamic> json){
    videoWord = json['videoWord'];
    videoUrl = json['videoUrl'];
    reviewListId = json['reviewListId'];


  }

  // add data to firebase
  Map<String, dynamic> toMap(){
    return {
      'videoWord' : videoWord,
      'videoUrl' : videoUrl,
      'reviewListId' : reviewListId,
    };
  }


}