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
     required this.id,
  });
  late  String image;
  late  String about;
  late  String name;
  late  String lastActive;
  late  bool isOnline;
  late  String creatingAt;
  late  String pushToken;
  late  String email;
  late  String id;

  ChatModel.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? "";
    about = json['about'] ?? "";
    name = json['name'] ?? "";
    lastActive = json['last_active'] ?? "";
    isOnline = json['is_online'] ?? "";
    creatingAt = json['creating_at'] ?? "";
    pushToken = json['push_token'] ?? "";
    email = json['email'] ?? "";
     id = json['id'] ?? "";
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
    data['id'] = id;
    return data;
  }
}
