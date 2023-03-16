// To parse this JSON data, do
//
//     final myData = myDataFromJson(jsonString);

import 'dart:convert';

MyData myDataFromJson(String str) => MyData.fromJson(json.decode(str));

String myDataToJson(MyData data) => json.encode(data.toJson());

class MyData {
  MyData({
    required this.id,
    required this.admin,
    required this.profilePic,
    required this.mobile,
    required this.expertId,
    required this.fatherName,
  });

  int id;
  Admin admin;
  String profilePic;
  String mobile;
  String expertId;
  String fatherName;

  factory MyData.fromJson(Map<String, dynamic> json) => MyData(
        id: json["id"],
        admin: Admin.fromJson(json["admin"]),
        profilePic: json["profile_pic"],
        mobile: json["mobile"],
        expertId: json["expert_id"],
        fatherName: json["Father_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "admin": admin.toJson(),
        "profile_pic": profilePic,
        "mobile": mobile,
        "expert_id": expertId,
        "Father_name": fatherName,
      };
}

class Admin {
  Admin({
    required this.username,
  });

  String username;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
      };
}
