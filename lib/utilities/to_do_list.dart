import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ToDoTile extends StatelessWidget {
  final String taskname;
  final bool taskcompleted;
  Function(bool?)? onChanged; 
  Function(BuildContext)? deleteFunction;

  ToDoTile({super.key,
  required this.taskname,
  required this.taskcompleted,
  required this.onChanged,
  required this.deleteFunction,
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:20.0,right: 20.0,top: 20.0),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(onPressed: deleteFunction,
          icon : Icons.delete,
          backgroundColor: Colors.red.shade500, 
          borderRadius : BorderRadius.circular(12))
        
        ]),
        child: Container(
          padding : EdgeInsets.all(25),
          // ignore: sort_child_properties_last
          child: Row(
            children: [
              Checkbox(value: taskcompleted, onChanged: onChanged,
              activeColor: Colors.black,),
              Text(
                taskname,
                style : TextStyle(
                  decoration: taskcompleted 
                  ?TextDecoration.lineThrough
                  :TextDecoration.none)),
            ],
          ),
          decoration: BoxDecoration(color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}