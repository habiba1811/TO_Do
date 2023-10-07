import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do/models/task_model.dart';

class FirebaseManager {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection('Tasks')
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task) async {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    return getTasksCollection()
        .where('date', isEqualTo:DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }
  static Future<void> deleteTask(String taskId){
    return getTasksCollection().doc(taskId).delete();
  }
  static Future<void> updateTask(TaskModel model)async {
    getTasksCollection().doc(model.id).update(model.toJson());
  }
}
