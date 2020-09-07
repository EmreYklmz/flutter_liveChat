import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_lovers/model/user_model.dart';
import 'package:flutter_lovers/services/auth_base.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> currentUser() async {
    try {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return _userFromFirebase(user);
    } catch (e) {
      print("Hata current user: " + e.toString());
      return null;
    }
  }

  User _userFromFirebase(FirebaseUser user) {
    if (user == null)
      return null;
    else
      return User(userID: user.uid);
  }

  @override
  Future<User> signInAnonymously() async {
    try {
      AuthResult result = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(result.user);
    } catch (e) {
      print("signInAnonymously hata: " + e.toString());
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      final _googlesignIn = GoogleSignIn();
      await _googlesignIn.signOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("sign out hata: " + e.toString());
      return null;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        AuthResult result = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.getCredential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));
        FirebaseUser _user = result.user;
        return _userFromFirebase(_user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<User> createUserWithEmailandPsw(String email, String psw) async{
       try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: psw);
      return _userFromFirebase(result.user);
    } catch (e) {
      print("signInAnonymously hata: " + e.toString());
      return null;
    }
    }
  
    @override
    Future<User> signInWithEmailandPsw(String email,String psw) async{
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: psw);
      return _userFromFirebase(result.user);
    } catch (e) {
      print("signInAnonymously hata: " + e.toString());
      return null;
    }
  }
}
