import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_lovers/app/sign_in/email_psw_login_signin.dart';
import 'package:flutter_lovers/common_widget/social_log_in_button.dart';
import 'package:flutter_lovers/model/user_model.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/user_model.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Lovers"),
          elevation: 0,
        ),
        backgroundColor: Colors.grey.shade200,
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Oturum Açın",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              SizedBox(
                height: 8,
              ),
              SocialLoginButton(
                buttonColor: Colors.white,
                buttonText: "Gmail İle Giriş Yap",
                textColor: Colors.black,
                buttonIcon: Image.asset("images/google-logo.png"),
                onPressed: () => _signInWithGoogle(context),
              ),
              SocialLoginButton(
                buttonColor: Color(0xFF334D92),
                buttonText: "Facebook İle Giriş Yap",
                buttonIcon: Image.asset("images/facebook-logo.png"),
                onPressed: () {},
              ),
              SocialLoginButton(
                buttonText: "Email ve Şifre İle Giriş Yap",
                textColor: Colors.white,
                buttonIcon: Icon(
                  Icons.email,
                  size: 32,
                  color: Colors.white,
                ),
                onPressed: () => _emailAndPswLogin(context),
              ),
              SocialLoginButton(
                buttonText: "Misafir Girişi",
                textColor: Colors.white,
                buttonColor: Colors.teal,
                buttonIcon: Icon(
                  Icons.supervised_user_circle,
                  size: 32,
                  color: Colors.white,
                ),
                onPressed: () => _userLogin(context),
              ),
            ],
          ),
        ));
  }

  void _userLogin(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    User _user = await _userModel.signInAnonymously();
    print("Oturum acan misafir kullanici: " + _user.userID.toString());
  }

  void _signInWithGoogle(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    User _user = await _userModel.signInWithGoogle();
    if (_user != null)
      print("Oturum acan gmail kullanicisi: " + _user.userID.toString());
  }

  void _emailAndPswLogin(BuildContext contex) {
    Navigator.of(contex).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EmailPswLoginPage(),
      ),
    );
  }
}
