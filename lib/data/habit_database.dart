//reference our box

import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box('Habit_Database');

class HabitDatabase {
  List todaysHabitList =[];

  // create intitial default data
  void createDefaultData(){
    todaysHabitList = [
      ['Run',false],
      ['Read',false],
    ];
  }

  // load data if it already exists
  void loadData() {

  }

  //update database
  void updateDataBase(){

  }

}