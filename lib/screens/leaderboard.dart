import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Leaderboard extends StatefulWidget{
  const Leaderboard({Key key}) : super(key: key);
  static MaterialPageRoute get route => MaterialPageRoute(
    builder: (context) => const Leaderboard(),
  );
  @override
  _leaderboardMenu createState() =>_leaderboardMenu();
}

class _leaderboardMenu extends State<Leaderboard> {
 List userName;
 List numberOfStreaks;
 Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Center(
          child: Text('Leaderboard'),
        ),
      ],
    );
  }

  printfuntion(Object value) {
    print(value);
  }
}
