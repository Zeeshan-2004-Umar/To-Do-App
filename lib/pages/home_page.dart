// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:to_do_app/utilities/DailogBox.dart';

// import '../utilities/to_do_list.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

// final _controller = TextEditingController();
//   List TodoList = [
//     ["task 1",false],
//     ["Do excercise",false],
//   ];

//   void checkboxChanged(bool? value,int index){
//     setState(() {
//       TodoList[index][1] = !TodoList[index][1];
//     });
//   }

//   void saveNewTask()
//   {
//     setState(() {
//       TodoList.add([_controller.text, false]);
//       _controller.clear();
//     });
//     Navigator.of(context).pop();
//   }

//   void createNewTask()
//   {
//     showDialog(
//      context: context,
//      builder: (context)
//      {
//       return DailogBox(
//         controller:_controller ,
//         onSave: saveNewTask,
//         onCancel: () => Navigator.of(context).pop(),
//       );
//      },
//      );
//   }

//  void deleteTask(int index)
//  {
//     setState(() {
//       TodoList.removeAt(index);
//     });
//  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        backgroundColor: Colors.yellow[200],
//        appBar: AppBar(
//         backgroundColor: Colors.amber,
//         title : Text("T O   D O   L I S T "),
//         centerTitle: true,
//         elevation: 0,
//        ),
//        floatingActionButton: FloatingActionButton(onPressed: createNewTask,
//        child : Icon(Icons.add),
//        backgroundColor: Colors.amber,),
//        body :ListView.builder(
//         itemCount: TodoList.length,
//         itemBuilder: (context, index) {
//           return ToDoTile(
//             taskname: TodoList[index][0], 
//             taskcompleted: TodoList[index][1], 
//             onChanged: (value) => checkboxChanged(value,index),
//             deleteFunction: (context) => deleteTask(index),
//             );
//         },
//        )
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/utilities/DailogBox.dart';
import 'task.dart';
import '../utilities/to_do_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _box = Hive.box<Task>('tasks');

  void checkboxChanged(bool? value, Task task) {
    setState(() {
      task.completed = value ?? false;
      task.save();
    });
  }

  void saveNewTask() {
    final newTask = Task(name: _controller.text);
    _box.add(newTask);
    _controller.clear();
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DailogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(Task task) {
    setState(() {
      task.delete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("T O   D O   L I S T "),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
      body: ValueListenableBuilder(
        valueListenable: _box.listenable(),
        builder: (context, Box<Task> box, _) {
          final tasks = box.values.toList().cast<Task>();

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ToDoTile(
                taskname: task.name,
                taskcompleted: task.completed,
                onChanged: (value) => checkboxChanged(value, task),
                deleteFunction: (context) => deleteTask(task),
              );
            },
          );
        },
      ),
    );
  }
}
