import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiteens/objectclasses/exercise.dart';
import 'package:fiteens/objectclasses/userdata.dart';
import 'package:fiteens/objectclasses/workouts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class WorkoutDetails extends StatelessWidget {
  final workouts workout;
  WorkoutDetails({Key key, this.workout}) : super(key: key);


  Widget build(BuildContext context) {
    int time;
    String curruserid;
    // userData user;
    int streak;
    final litUser = context.watchSignedInUser();
    litUser.when(
          (user) => curruserid = user.uid,

      empty: () => Text('Not signed in'),
      initializing: () => Text('Loading'),
    );

    List exercises;
    exercises = getExercises(workout);
    int len = exercises.length;

    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Colors.white,
            value: workout.indicatorValue,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 60.0),
        Center(
          child: Icon(
            Icons.fitness_center,
            color: Colors.white,
            size: 40.0,
          ),
        ),
        Container(
          width: 90.0,
        ),
        SizedBox(height: 10.0),
        Center(
          child: Text(
           workout.workoutName,
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        ),
        SizedBox(height: 2.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      workout.level,
                      style: TextStyle(color: Colors.white),
                    ))),

            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(),
                    child: Text(
                      workout.content,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ))),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.blue),
          child: Center(
            child: topContentText,
          ),
        ),


        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );


    final bottomContent = Container(
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: len,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(exercises[index]);
            },
        ),
      ),
    );


    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('PLEASE SET UP YOUR ACCOUNT TO ACCESS THIS FEATURE'),
      ),
    );
  }

    List getExercises(workouts workout) {

      if(workout.workoutName == "NOVICE WORKOUT") {
        return [
          ExerciseDetails(
              exerciseName: "WALL PUSH UP",
              reps: "30",
              sets: "2"),
          ExerciseDetails(
              exerciseName: "BENCH SQUAT",
              reps: "30",
              sets: "2"),
          ExerciseDetails(
              exerciseName: "LYING KNEE TUCK",
              reps: "10",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "BEGINNER BRIDGE",
              reps: "30 seconds",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "TRIPOD",
              reps: "30 seconds",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "FROG STAND",
              reps: "30 seconds",
              sets: "3"),
        ];
      }
      else if(workout.workoutName == "BEGINNER WORKOUT"){
        return [
          ExerciseDetails(
              exerciseName: "PUSH UP",
              reps: "20",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "FULL SQUAT",
              reps: "20",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "SPLIT SQUAT",
              reps: "10 each leg",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "LYING LEG RAISE",
              reps: "10",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "STRAIGHT BRIDGE",
              reps: "30 seconds",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "HEADSTAND",
              reps: "30 seconds",
              sets: "3"),
        ];
      }
      else if(workout.workoutName == "INTERMEDIATE WORKOUT"){
        return [
          ExerciseDetails(
              exerciseName: "CLOSE PUSH UP",
              reps: "20",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "UNEVEN PUSH UP",
              reps: "10 each side",
              sets: "2"),
          ExerciseDetails(
              exerciseName: "ASSISTED PISTOL",
              reps: "10 each leg",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "SIDE-TO-SIDE SQUAT",
              reps: "10 each leg",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "FULL BRIDGE",
              reps: "30 seconds",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "ELBOW LEVER",
              reps: "30 seconds",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "HANDSTAND",
              reps: "30 seconds",
              sets: "3"),
        ];
      }

      else if(workout.workoutName == "WEIGHT WORKOUT: BACK 1"){
        return [
          ExerciseDetails(
              exerciseName: "PULL UPS",
              reps: "TILL FAILURE",
              sets: "4"),
          ExerciseDetails(
              exerciseName: "ONE ARM ROW",
              reps: "15-12-8 [INCREASE WEIGHT]",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "CURL BAR ROW",
              reps: "10",
              sets: "4"),
          ExerciseDetails(
              exerciseName: "LAT EXTENSION",
              reps: "15-12-8-8 [INCREASE WEIGHT]",
              sets: "1"),
          ExerciseDetails(
              exerciseName: "INCLINE DUMBBELL ROW",
              reps: "10",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "DEADLIFTS",
              reps: "15-12-8-8 [INCREASE WEIGHT]",
              sets: "1"),
          ExerciseDetails(
              exerciseName: "DUMBBELL SHRUG",
              reps: "10",
              sets: "4"),
        ];
      }
      else if(workout.workoutName == "WEIGHT WORKOUT: CHEST 1"){
        return [
          ExerciseDetails(
              exerciseName: "DUMBBELL PRESS",
              reps: "15-12-8  [INCREASE WEIGHT]",
              sets: "4"),
          ExerciseDetails(
              exerciseName: "ALTERNATING DUMBBELL PRESS",
              reps: "12",
              sets: "4"),
          ExerciseDetails(
              exerciseName: "ALTERNATING DUMBBELL PRESS",
              reps: "15-12-8 [INCREASE WEIGHT]\n8-12-15 [DECREASE WEIGHT]",
              sets: "4"),
          ExerciseDetails(
              exerciseName: "FLAT BENCH FLY",
              reps: "12",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "CHEST PRESS",
              reps: "5",
              sets: "5"),
          ExerciseDetails(
              exerciseName: "DECLINE PUSH UP",
              reps: "10",
              sets: "3"),
        ];
      }
      else if(workout.workoutName == "WEIGHT WORKOUT: ARMS 1"){
        return [
          ExerciseDetails(
              exerciseName: "DUMBBELL CURL",
              reps: "15-12-8 [INCREASE WEIGHT]\n8-12-15 [DECREASE WEIGHT]",
              sets: "1"),
          ExerciseDetails(
              exerciseName: "SEATED DUMBBELL TRICEP EXTENSION",
              reps: "15-12-8-8",
              sets: "1"),
          ExerciseDetails(
              exerciseName: "CURL BAR CURL",
              reps: "5",
              sets: "5"),
          ExerciseDetails(
              exerciseName: "LAYING CURL BAR TRICEP EXTENSION",
              reps: "15-12-8-8",
              sets: "1"),
          ExerciseDetails(
              exerciseName: "DUMBBELL HAMMER CURL",
              reps: "15-12-8 [INCREASE WEIGHT]\n8-12-15 [DECREASE WEIGHT]\n[EACH ARM]",
              sets: "1"),
          ExerciseDetails(
              exerciseName: "LEANING DUMBBELL TRICEP EXTENSION",
              reps: "15-12-8 [INCREASE WEIGHT]\n8-12-15 [DECREASE WEIGHT]\n[EACH ARM]",
              sets: "1"),
        ];
      }
      else if(workout.workoutName == "WEIGHT WORKOUT: LEGS 1"){
        return [
          ExerciseDetails(
              exerciseName: "2 WAY LUNGE",
              reps: "12->10->8 [EACH LEG INCREASING WEIGHT]",
              sets: "1"),
          ExerciseDetails(
              exerciseName: "DUMBBELL SQUAT",
              reps: "15-12-8 [INCREASE WEIGHT]\n8-12-15 [DECREASE WEIGHT]",
              sets: "1"),
          ExerciseDetails(
              exerciseName: "2 WAY SUMO SQUAT",
              reps: "10",
              sets: "5"),
          ExerciseDetails(
              exerciseName: "CURL BAR SPLIT SQUAT",
              reps: "15-12-8 [INCREASE WEIGHT]\n8-12-15 [DECREASE WEIGHT]\n[EACH LEG] ",
              sets: "1"),
          ExerciseDetails(
              exerciseName: "STRAIGHT LEG DEADLIFT",
              reps: "15-12-8-8[INCREASE WEIGHT]",
              sets: "1"),
          ExerciseDetails(
              exerciseName: "STRAIGHT LEG CALF RAISE",
              reps: "50 [BOTH LEGS]",
              sets: "1"),
        ];
      }
      else if(workout.workoutName == "WEIGHT WORKOUT: SHOULDERS 1"){
        return [
          ExerciseDetails(
              exerciseName: "ARNOLD PRESS",
              reps: "15-12-8-8 [INCREASE WEIGHT]",
              sets: "1"),
          ExerciseDetails(
              exerciseName: "THREE PART LATERAL RAISE",
              reps: "10",
              sets: "4"),
          ExerciseDetails(
              exerciseName: "CURL BAR UPRIGHT ROW",
              reps: "12",
              sets: "4"),
          ExerciseDetails(
              exerciseName: "ONE ARM FRONT RAISE",
              reps: "15-12-8 [INCREASE WEIGHT]",
              sets: "1"),
          ExerciseDetails(
              exerciseName: "TWO ARM RAISE AND TWIST",
              reps: "10",
              sets: "3"),
          ExerciseDetails(
              exerciseName: "REVERSE FLY",
              reps: "15-12-8-8 [INCREASE WEIGHT]",
              sets: "1"),

        ];
      }
    }




  Card makeCard(ExerciseDetails details) => Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: makeListTile(details),
    ),
  );



  ListTile makeListTile(ExerciseDetails details) => ListTile(
    contentPadding:
    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24)
          )
      ),
       child: Icon(Icons.arrow_right, color: Colors.white),
    ),
    title: Text(
      details.exerciseName,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    subtitle: Row(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
              child:
                    Text("REPS:"+details.reps)
            )
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Container(
              child:
              Text("SETS:"+details.sets)
            ),
          ),

        )
      ],
    ),
    // trailing:
    // Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
  );
}



