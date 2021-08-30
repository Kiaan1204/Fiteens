
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiteens/objectclasses/userdata.dart';
import 'package:fiteens/objectclasses/workouts.dart';
import 'package:fiteens/screens/auth/decorations_functions.dart';
import 'package:fiteens/screens/homeMenu.dart';
import 'package:fiteens/screens/leaderboard.dart';
import 'package:fiteens/screens/workoutDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:provider/provider.dart';


import 'auth/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

  @override
  _HomeState createState() => _HomeState();
}
  class _HomeState extends State<HomeScreen>{

  List workout;
  FToast fToast;

  @override
  void initState() {
    workout = getWorkouts();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }
  _showToastSuccess() {
    Widget toast;
    toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 5.0,
          ),
          Text("UPDATED DETAILS SUCCESSFULLY"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  _showToastNoDetails() {
    Widget toast;
    toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.close),
          SizedBox(
            width: 5.0,
          ),
          Text("PLEASE UPLOAD YOUR DETAILS"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {

    var userNameController = TextEditingController();
    var nameController = TextEditingController();
    var weightController = TextEditingController();
    Firestore firestore = Firestore.instance;
    final litUser = context.watchSignedInUser();
    String email;
    String curruserid;
    String currUserName;
    String currFullName;
    String currWeight;
    DocumentSnapshot snapshot;
    List uids = new List();
    List names = new List();

    firestore
        .collection('USERS').getDocuments().then((QuerySnapshot querySnapshot) => {
      querySnapshot.documents.forEach((doc) {
        uids.add(doc['UID']);
        names.add(doc['NAME']);

        names.sort();

        
        print(doc['UID']);
      })
    });


    litUser.when(
          (user) => curruserid = user.uid,

      empty: () => Text('Not signed in'),
      initializing: () => Text('Loading'),
    );
    litUser.when(
          (user) => email = user.email,

      empty: () => Text('Not signed in'),
      initializing: () => Text('Loading'),
    );

    firestore.collection("USERS").document(curruserid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists &&  documentSnapshot.data["NAME"] != "" &&  documentSnapshot.data["USERNAME"] != "" ) {
        print('Document data: ${documentSnapshot.data}');
        currFullName = documentSnapshot.data["NAME"];
        currUserName = documentSnapshot.data["USERNAME"];
        currWeight = documentSnapshot.data["CURRENTWEIGHT"];
        userNameController.text = currUserName;
        nameController.text = currFullName;
        weightController.text = currWeight;

        print(currFullName + currUserName + currWeight);
      } else {
        print('Document does not exist on the database');
        _showToastNoDetails();
      }
    });


    Card makeCard(workouts workout) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.lightBlue),
        child: makeListTile(workout),
      ),
    );


    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        //ADD +1 TO ITEM COUNT FOR EVERY NEW WORKOUT ADDED
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(workout[index]);
        },
      ),
    );

    var tabs = [
      Column(
        children: [
          AppBar(
            title: Text('LEADERBOARD'),
          ),
          Center(child:
          Text('COMING SOON')
          )
        ],
      ),

    Scaffold(
          appBar: AppBar(title: Text('HOME'),),
          body: makeBody,
    ),


      Column(
        children: [
          AppBar(
            title: Text('PROFILE'),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              style: TextStyle(
                fontSize:15,
              ),
              decoration:new InputDecoration(
                  hintText: "USERNAME",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  ),
            controller: userNameController,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: TextStyle(
                fontSize:15,
              ),
              decoration:new InputDecoration(
                hintText: "FULL NAME",
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
              ),
              controller: nameController,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: TextStyle(
                fontSize:15,
              ),
              decoration:new InputDecoration(
                hintText: "CURRENT WEIGHT",
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
              ),
              controller: weightController,
              keyboardType: TextInputType.number,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              child:
              Text('UPDATE\nDETAILS'),
              onPressed: ()
              {
                userData data = new userData(curruserid.toString(), nameController.text.toString(), email, 0, weightController.text.toString(),userNameController.text.toString(), false);
                firestore.collection("USERS").document(curruserid)
                    .setData({
                  'UID':data.useruid,
                  'NAME': data.name,
                  'Email':data.email,
                  'Streaks':data.streak,
                  'CURRENTWEIGHT':data.weight,
                  'USERNAME':data.userName
                });
                _showToastSuccess();

                },
              elevation: 10,
            ),
          ),

          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: RaisedButton(
                child:
                Text('SIGN\nOUT'),
                onPressed: () {
                  context.signOut();
                  Navigator.push(context, AuthScreen.route);
                },
                  elevation: 10,
              ),
            ),
          ),
        ],
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("FITEENS")),
        backgroundColor: Colors.lightBlue,
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.assessment),
              title: Text('Leaderboard'),
              backgroundColor: Colors.blue
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              backgroundColor: Colors.blue
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              backgroundColor: Colors.blue
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });

        },
      ),
    );
  }
//ADD WORKOUT TO THE LIST
  List getWorkouts(){
    return[
      workouts(
        workoutName: "NOVICE WORKOUT",
        level: "Novice",
        indicatorValue: 0.10,
        content: "WORKOUT FOR NOVICES",
        NumberofExercises: 6,
      ),

      workouts(
          workoutName: "BEGINNER WORKOUT",
          level: "Beginner",
          indicatorValue: 0.33,
          content: "WORKOUT FOR BEGINNERS",
          NumberofExercises: 6,
      ),

      workouts(
        workoutName: "INTERMEDIATE WORKOUT",
        level: "Intermediate",
        indicatorValue: .66,
        content: "WORKOUT FOR INTERMEDIATES",
        NumberofExercises: 7,
      ),

      workouts(
          workoutName: "WEIGHT WORKOUT: BACK 1",
          level: "Expert",
          indicatorValue: 1,
          content: "WORKOUT WITH WEIGHTS\nPICK A SUITABLE WEIGHT FOR YOU!!",
          NumberofExercises: 8,
      ),

      workouts(
          workoutName: "WEIGHT WORKOUT: CHEST 1",
          level: "Expert",
          indicatorValue: 1,
          content: "WORKOUT WITH WEIGHTS\nPICK A SUITABLE WEIGHT FOR YOU!!",
          NumberofExercises: 10,
      ),

      workouts(
        workoutName: "WEIGHT WORKOUT: ARMS 1",
        level: "Expert",
        indicatorValue: 1,
        content: "WORKOUT WITH WEIGHTS\nPICK A SUITABLE WEIGHT FOR YOU!!",
        NumberofExercises: 10,
      ),

      workouts(
        workoutName: "WEIGHT WORKOUT: LEGS 1",
        level: "Expert",
        indicatorValue: 1,
        content: "WORKOUT WITH WEIGHTS\nPICK A SUITABLE WEIGHT FOR YOU!!",
        NumberofExercises: 10,
      ),

      workouts(
        workoutName: "WEIGHT WORKOUT: SHOULDERS 1",
        level: "Expert",
        indicatorValue: 1,
        content: "WORKOUT WITH WEIGHTS\nPICK A SUITABLE WEIGHT FOR YOU!!",
        NumberofExercises: 10,
      ),
    ];
  }


  ListTile makeListTile(workouts workout) => ListTile(
    contentPadding:
    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24))),
      child: Icon(Icons.fitness_center, color: Colors.white),
    ),
    title: Text(
      workout.workoutName,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),


    subtitle: Row(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
              // tag: 'hero',
              child: LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  value: workout.indicatorValue,
                  valueColor: AlwaysStoppedAnimation(Colors.green)),
            )),
        Expanded(
          flex: 4,
          child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(workout.level,
                  style: TextStyle(color: Colors.white))),
        )
      ],
    ),
    trailing:
    Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
    onTap: () {

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WorkoutDetails(workout: workout,)));
    },
  );
}
