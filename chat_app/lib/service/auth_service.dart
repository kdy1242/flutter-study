
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'db_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // 로그인
  login(String email, String password) {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).catchError((error) {
      // 로그인 실패
      Get.snackbar('로그인 실패', '아이디와 비밀번호를 다시 확인하세요.');
      return error;
    });
  }

  // 로그아웃
  logout() => FirebaseAuth.instance.signOut();

  // 회원가입
  signup(String name, String email, String password) async {
    User user = (await firebaseAuth.createUserWithEmailAndPassword(
    email: email, password: password))
        .user!;
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
    );
    DBService(uid: user.uid).savingUserData(name, email);
  }
}
