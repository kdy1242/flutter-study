
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MainController extends GetxController {
  User get user => FirebaseAuth.instance.currentUser!;

}
