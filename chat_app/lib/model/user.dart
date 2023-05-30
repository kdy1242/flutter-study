
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String profileImg;
  final List groups;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.profileImg,
    required this.groups,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'email': this.email,
      'name': this.name,
      'profileImg': this.profileImg,
      'groups': this.groups,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      profileImg: map['profileImg'] as String,
      groups: map['groups'] as List,
    );
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, email: $email, name: $name, profileImg: $profileImg, groups: $groups}';
  }
}
