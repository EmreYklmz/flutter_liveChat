import 'package:flutter/material.dart';
import 'package:flutter_lovers/common_widget/social_log_in_button.dart';
import 'package:flutter_lovers/model/user_model.dart';
import 'package:flutter_lovers/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

enum FormType { Register, LogIn }

class EmailPswLoginPage extends StatefulWidget {
  @override
  _EmailPswLoginPage createState() => _EmailPswLoginPage();
}

class _EmailPswLoginPage extends State<EmailPswLoginPage> {
  String _email, _psw;
  String _buttonText, _linkText;
  var _formType = FormType.LogIn;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _buttonText = _formType == FormType.LogIn ? "Giris Yap" : "Kayit Ol";
    _linkText = _formType == FormType.LogIn
        ? "Hesabiniz Yok Mu?Kayit Olun"
        : "Hesabiniz Var Mi?Giris Yapin";

    final _userModel = Provider.of<UserModel>(context);

    if (_userModel.user != null) {
      Navigator.of(context).pop();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Giriş / Kayıt"),
        ),
        body: _userModel.state == ViewState.Idle
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            errorText: _userModel.emailErrMsg != null
                                ? _userModel.emailErrMsg
                                : null,
                            prefixIcon: Icon(Icons.mail),
                            hintText: 'Email',
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String typeEmail) {
                            _email = typeEmail;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            errorText: _userModel.pswErrMsg != null
                                ? _userModel.pswErrMsg
                                : null,
                            prefixIcon: Icon(Icons.vpn_key),
                            hintText: 'Sifre',
                            labelText: 'Sifre',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String typePsw) {
                            _psw = typePsw;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SocialLoginButton(
                            buttonText: _buttonText,
                            buttonColor: Theme.of(context).primaryColor,
                            radius: 12,
                            onPressed: () => _formSubmit()),
                        SizedBox(
                          height: 8,
                        ),
                        FlatButton(
                          child: Text(_linkText),
                          onPressed: () => _change(),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  void _formSubmit() async {
    _formKey.currentState.save();
    final _userModel = Provider.of<UserModel>(context, listen: false);

    if (_formType == FormType.LogIn) {
      User _loginUser = await _userModel.signInWithEmailandPsw(_email, _psw);
      if (_loginUser != null)
        print("Oturum acan mail kullanicisi: " + _loginUser.userID.toString());
    } else {
      User _createUser =
          await _userModel.createUserWithEmailandPsw(_email, _psw);
      if (_createUser != null)
        print("Oturum acan mail kullanicisi: " + _createUser.userID.toString());
    }
  }

  void _change() {
    setState(() {
      _formType =
          _formType == FormType.LogIn ? FormType.Register : FormType.LogIn;
    });
  }
}