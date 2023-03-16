class ChatModel {
  ChatModel({
    required this.image,
    required this.about,
    required this.name,
    required this.lastActive,
    required this.isOnline,
    required this.creatingAt,
    required this.pushToken,
    required this.email,
  });
  late final String image;
  late final String about;
  late final String name;
  late final String lastActive;
  late final bool isOnline;
  late final String creatingAt;
  late final String pushToken;
  late final String email;

  ChatModel.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? "";
    about = json['about'] ?? "";
    name = json['name'] ?? "";
    lastActive = json['last_active'] ?? "";
    isOnline = json['is_online'] ?? "";
    creatingAt = json['creating_at'] ?? "";
    pushToken = json['push_token'] ?? "";
    email = json['email'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = name;
    data['last_active'] = lastActive;
    data['is_online'] = isOnline;
    data['creating_at'] = creatingAt;
    data['push_token'] = pushToken;
    data['email'] = email;
    return data;
  }
}
