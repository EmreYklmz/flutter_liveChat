import 'package:flutter/material.dart';
import 'package:flutter_lovers/model/user_model.dart';
import 'package:provider/provider.dart';
import '../viewmodel/user_model.dart';

class HomePage extends StatelessWidget {
  final User user;

  HomePage({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: ()=> _signOut(context),
            child: Text(
              "Çıkış Yap",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        title: Text("Ana Sayfa"),
      ),
      body: Center(
        child: Text("Hoşgeldiniz ${user.userID}"),
      ),
    );
  }

  Future<bool> _signOut(BuildContext context) async {
     final _userModel = Provider.of<UserModel>(context, listen: false);
    bool result = await _userModel.signOut();
    return result;
  }
}
