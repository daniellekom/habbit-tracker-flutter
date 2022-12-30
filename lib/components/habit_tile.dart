import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  const HabitTile({
    Key? key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingsTapped,
    required this.deleteTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              //settings option
              SlidableAction(
                onPressed:settingsTapped,
                backgroundColor: Colors.grey.shade800,
                icon: Icons.settings,

              ),

              //delete option
              SlidableAction(
                onPressed:  deleteTapped,
                backgroundColor: Colors.red.shade900,
                icon: Icons.delete,

              ),

            ],
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children:  [
                //checkbox
                Checkbox(
              value: habitCompleted,
              onChanged: onChanged,
                ),
                //habit name
                 Text(habitName),

              ],
            ),

          ),
        ),
      ),
    );
  }
}
