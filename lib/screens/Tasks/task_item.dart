import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/shared/network/firebase/firebase_manager.dart';
import 'package:to_do/styles/colors.dart';

import 'edit.dart';

class TasksItem extends StatelessWidget {
  TaskModel task;
   TasksItem(this.task,{super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EditTask.routeName,
            arguments: task,
        );
      },
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none
        ),
        child: Slidable(
          startActionPane: ActionPane(motion: const DrawerMotion(), children:[
            SlidableAction(onPressed: (BuildContext context){
              FirebaseManager.deleteTask(task.id);
            },
              backgroundColor: Colors.red,
              label: 'Delete',
              icon: Icons.delete,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
        SlidableAction(onPressed: (BuildContext context){
        },
            backgroundColor: Colors.blue,
            label: 'Edit',
            icon: Icons.edit,),
          ] ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 80.0,
                  width: 4.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.blue),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title,style: const TextStyle(
                         fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      ),
                      Text(task.description,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF363636),
                      ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    task.isDone=true;
                    FirebaseManager.updateTask(task);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:task.isDone?Colors.green:primary,
                      borderRadius: BorderRadius.circular(12),

                    ),
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 2),
                      child:  task.isDone?Text('Done!',style: TextStyle(color: Colors.white),):Icon(Icons.done,
                      color: Colors.white,
                        size: 30,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
