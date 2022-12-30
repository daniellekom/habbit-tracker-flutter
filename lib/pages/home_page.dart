import 'package:flutter/material.dart';
import 'package:habbittracker/components/my_alert_dialog.dart';
import 'package:habbittracker/data/habit_database.dart';
import 'package:hive/hive.dart';

import '../components/habit_tile.dart';
import '../components/my_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box('Habit_Database');



  @override
  void initState() {

    // if there is no current habit list && first time opening app
    //then create default data
      if(_myBox.get("CURRENT_HABIT_LIST") == null){
      db.createDefaultData();
      }

      //this is not the first time opening app
      else{
    db.loadData();
      }

      //update the database
      db.updateDataBase();


    super.initState();
  }

  // checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
  }

  // create a new habit
  final _newHabitNameController = TextEditingController();

  void createNewHabit() {
    // show alert dialog for user to enter the new habit details
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(
            hintText: 'Enter Habit Name ',
            controller: _newHabitNameController,
            onSave: saveNewHabit,
            onCancel: cancelNewDialog,
          );
        });
  }

  // save new habit
  void saveNewHabit() {
    // add new habit to todays habit list
    setState(() {
     db.todaysHabitList.add([_newHabitNameController.text, false]);
    });
    //clear textfield
    _newHabitNameController.clear();
    //pop dialog box
    Navigator.of(context).pop();
  }

  // cancel new habit
  void cancelNewDialog() {
    //clear textfield
    _newHabitNameController.clear();
    //pop dialog box
    Navigator.of(context).pop();
  }

  // open habit settings to edit
  void openHabitSettings(int index){
  showDialog(context: context, builder: (context){
    return MyAlertDialog(
      hintText: db.todaysHabitList[index][0],
      controller: _newHabitNameController,
        onSave: () => saveExistingHabit(index),
        onCancel: cancelNewDialog,
    );
  },
  );
  }

  // save existing habit with a new name
  void saveExistingHabit(int index){
    setState(() {
     db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
  }
  //delete habit
  void deleteHabit(int index){
  setState(() {
    db.todaysHabitList.removeAt(index);
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      floatingActionButton: MyFab(onPressed: createNewHabit),
      body: ListView.builder(
          itemCount: db.todaysHabitList.length,
          itemBuilder: (context, index) {
            return HabitTile(
              habitName: db.todaysHabitList[index][0],
              habitCompleted: db.todaysHabitList[index][1],
              onChanged: (value) => checkBoxTapped(value, index),
              settingsTapped: (context) => openHabitSettings(index) ,
              deleteTapped: (context) => deleteHabit(index),
            );
          }),
    );
  }
}
