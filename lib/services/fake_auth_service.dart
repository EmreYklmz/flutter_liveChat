import 'package:flutter_lovers/model/user_model.dart';
import 'package:flutter_lovers/services/auth_base.dart';

class FakeAuthenticationService implements AuthBase {
  String userID = "234234234234324";

  @override
  Future<User> currentUser() async {
    return await Future.value(User(userID: userID));
  }

  @override
  Future<User> signInAnonymously() async {
    return await Future.delayed(
        Duration(seconds: 2), () => User(userID: userID));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<User> signInWithGoogle() async {
    return await Future.delayed(
        Duration(seconds: 2), () => User(userID: "google_user_id"));
  }

  @override
  Future<User> createUserWithEmailandPsw(String email, String psw) async {
    return await Future.delayed(
        Duration(seconds: 2), () => User(userID: "created_user_id"));
  }

  @override
  Future<User> signInWithEmailandPsw(String email, String psw) async {
    return await Future.delayed(
        Duration(seconds: 2), () => User(userID: "signIn_user_id"));
  }
}
