class UserProfileModel {
  final String email;
  final String name;
  final String uid;
  final String bio;
  final String link;

  UserProfileModel({
    required this.email,
    required this.name,
    required this.uid,
    required this.bio,
    required this.link,
  });

  UserProfileModel.empty()
      : uid = '',
        email = '',
        name = '',
        bio = '',
        link = '';
  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        name = json['name'],
        bio = json['bio'],
        link = json['link'];
  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "bio": bio,
      "link": link,
    };
  }
}
