import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class HomeMenu extends StatefulWidget{
  const HomeMenu({Key key}) : super(key: key);
  static MaterialPageRoute get route => MaterialPageRoute(
    builder: (context) => const HomeMenu(),
  );
  @override
  _homeMenu createState() =>_homeMenu();
}

class _homeMenu extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    final user = context.getSignedInUser();
    return Column(
      children: [
        Center(
          child: RaisedButton(
          onPressed: (){ context.signOut();}
          ),
        ),
      ],
    );

  }



}