import 'package:flutter_lovers/locator.dart';
import 'package:flutter_lovers/model/user_model.dart';
import 'package:flutter_lovers/services/auth_base.dart';
import 'package:flutter_lovers/services/fake_auth_service.dart';
import 'package:flutter_lovers/services/firebase_auth_service.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthenticationService _fakeAuthenticationService =
      locator<FakeAuthenticationService>();

  AppMode appMode = AppMode.DEBUG;

  @override
  Future<User> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.currentUser();
    } else {
      return await _firebaseAuthService.currentUser();
    }
  }

  @override
  Future<User> signInAnonymously() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInAnonymously();
    } else {
      return await _firebaseAuthService.signInAnonymously();
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInWithGoogle();
    } else {
      return await _firebaseAuthService.signInWithGoogle();
    }
  }

  @override
  Future<User> createUserWithEmailandPsw(String email, String psw) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.createUserWithEmailandPsw(
          email, psw);
    } else {
      return await _firebaseAuthService.createUserWithEmailandPsw(email, psw);
    }
  }

  @override
  Future<User> signInWithEmailandPsw(String email, String psw) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInWithEmailandPsw(email, psw);
    } else {
      return await _firebaseAuthService.signInWithEmailandPsw(email, psw);
    }
  }
}
