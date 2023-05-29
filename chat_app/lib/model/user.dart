
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String profileImg;
  final List<String> groups;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.profileImg,
    required this.groups,
  });

  factory UserModel.fromFirebase(User? firebaseUser) {
    if (firebaseUser == null) return UserModel(uid: '', email: '', name: '', profileImg: '', groups: []);

    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      name: firebaseUser.displayName!,
      profileImg: firebaseUser.photoURL!,
      groups: [],
    );
  }

  Future<void> saveToFirestore() async {
    try {
      final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
      await userRef.set({
        'email': email,
        'name': name,
        'profileImg': profileImg,
        'groups': groups,
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<UserModel?> fromFirestore(String uid) async {
    try {
      final userSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userSnapshot.exists) {
        final userData = userSnapshot.data()!;
        return UserModel(
          uid: uid,
          email: userData['email'],
          name: userData['name'],
          profileImg: userData['profileImg'],
          groups: List<String>.from(userData['groups']),
        );
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
