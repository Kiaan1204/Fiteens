
class userData {
   String _useruid;
   String _name;
   String _email;
   int _streak;
   String _weight;
   String _userName;
   bool _hasCompletedWorkout;


  userData(this._useruid, this._name, this._email, this._streak, this._weight, this._userName, this._hasCompletedWorkout);

  String get useruid => _useruid;

  set useruid(String value) {
    _useruid = value;
  }

  int get streak => _streak;

  set streak(int value) {
    _streak = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

   String get weight => _weight;

   set weight(String value) {
     _weight = value;
   }

   String get   userName => _userName;

   set userName(String value) {
     _userName = value;
   }

   bool get hasCompletedWorkout => _hasCompletedWorkout;

   set hasCompletedWorkout(bool value){
     _hasCompletedWorkout = value;
   }

}

