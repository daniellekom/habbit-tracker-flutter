import 'package:flutter/material.dart';
import 'package:habbittracker/components/my_alert_dialog.dart';

import '../components/habit_tile.dart';
import '../components/my_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //data structure for todays list
  List todaysHabitList = [
    // [habit name, isHabitCompleted?]
    ['Morning Run', false],
    ['Read Book', false],
    ['Code App', false],
  ];

  // checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todaysHabitList[index][1] = value;
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
      todaysHabitList.add([_newHabitNameController.text, false]);
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
    return MyAlertDialog(controller: _newHabitNameController,
        onSave: () => saveExistingHabit(index),
        onCancel: cancelNewDialog,
    );
  },
  );
  }

  // save existing habit with a new name
  void saveExistingHabit(int index){
    setState(() {
      todaysHabitList[index][0] = _newHabitNameController.text;

    });
  }
  //delete habit
  void deleteHabit(int index){
  setState(() {
    todaysHabitList.removeAt(index);
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      floatingActionButton: MyFab(onPressed: createNewHabit),
      body: ListView.builder(
          itemCount: todaysHabitList.length,
          itemBuilder: (context, index) {
            return HabitTile(
              habitName: todaysHabitList[index][0],
              habitCompleted: todaysHabitList[index][1],
              onChanged: (value) => checkBoxTapped(value, index),
              settingsTapped: (context) => openHabitSettings(index) ,
              deleteTapped: (context) => deleteHabit(index),
            );
          }),
    );
  }
}
