class UserProfileModel {
  final String email;
  final String name;
  final String uid;
  final String bio;
  final String link;
  final bool hasAvatar;

  UserProfileModel({
    required this.hasAvatar,
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
        link = '',
        hasAvatar = false;
  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        name = json['name'],
        bio = json['bio'],
        link = json['link'],
        hasAvatar = json['hasAvatar'] ?? false;
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "bio": bio,
      "link": link,
      "hasAvatar": hasAvatar,
    };
  }

  UserProfileModel copyWith({
    String? email,
    String? name,
    String? uid,
    String? bio,
    String? link,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      hasAvatar: hasAvatar ?? this.hasAvatar,
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      bio: bio ?? this.bio,
      link: link ?? this.link,
    );
  }
}
