class VideoModel {
  final String description;
  final String title;
  final String fileUrl;
  final String thumbnailUrl;
  final String creatorUid;
  final String creator;
  final int likes;
  final int comments;
  final int createdAt;
  final String id;

  VideoModel({
    required this.id,
    required this.creator,
    required this.description,
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.likes,
    required this.comments,
    required this.creatorUid,
    required this.createdAt,
    required this.title,
  });

  VideoModel.fromJson(Map<String, dynamic> json, String videoId)
      : creator = json['creator'],
        description = json['description'],
        fileUrl = json['fileUrl'],
        thumbnailUrl = json['thumbnailUrl'],
        likes = json['likes'],
        comments = json['comments'],
        creatorUid = json['creatorUid'],
        createdAt = json['createdAt'],
        title = json['title'],
        id = videoId;

  Map<String, dynamic> toJson() {
    return {
      "creator": creator,
      "description": description,
      "fileUrl": fileUrl,
      "thumbnailUrl": thumbnailUrl,
      "likes": likes,
      "comments": comments,
      "creatorUid": creatorUid,
      "createdAt": createdAt,
      "title": title,
      "id": id,
    };
  }
}
