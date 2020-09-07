import 'package:flutter_lovers/model/user_model.dart';

abstract class AuthBase {
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<bool> signOut();
  Future<User> signInWithGoogle();
  Future<User> signInWithEmailandPsw(String email, String psw);
  Future<User> createUserWithEmailandPsw(String email, String psw);
}
