import 'package:flutter/material.dart';
import 'package:flutter_lovers/locator.dart';
import 'package:flutter_lovers/model/user_model.dart';
import 'package:flutter_lovers/repository/user_repository.dart';
import 'package:flutter_lovers/services/auth_base.dart';

enum ViewState { Idle, Busy }

class UserModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  User _user;
  String emailErrMsg;
  String pswErrMsg;

  User get user => _user;
  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<User> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      return _user;
    } catch (e) {
      debugPrint("VievState currentUser hata.");
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInAnonymously() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInAnonymously();
      return _user;
    } catch (e) {
      debugPrint("VievState signInAnonymously hata.");
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool result = await _userRepository.signOut();
      _user = null;
      return result;
    } catch (e) {
      debugPrint("VievState signOut hata.");
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithGoogle();
      return _user;
    } catch (e) {
      debugPrint("VievState signInWithGoogle hata.");
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> createUserWithEmailandPsw(String email, String psw) async {
    try {
      if (!_emailPswControl(email, psw)) return null;

      state = ViewState.Busy;
      _user = await _userRepository.createUserWithEmailandPsw(email, psw);
      return _user;
    } catch (e) {
      debugPrint("VievState createUserWithEmailandPsw hata.");
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInWithEmailandPsw(String email, String psw) async {
    try {
      if (!_emailPswControl(email, psw)) return null;

      state = ViewState.Busy;
      _user = await _userRepository.signInWithEmailandPsw(email, psw);
      return _user;
    } catch (e) {
      debugPrint("VievState signInWithEmailandPsw hata.");
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  bool _emailPswControl(String email, String psw) {
    var result = true;

    if (psw.length < 6) {
      pswErrMsg = "En az 6 karakter olmali";
      result = false;
    } else
      pswErrMsg = null;
    if (!email.contains('@')) {
      emailErrMsg = "Dogru bir mail giriniz.";
      result = false;
    } else
      emailErrMsg = null;

    return result;
  }
}
