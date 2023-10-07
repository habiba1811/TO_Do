import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do/screens/Tasks/task_item.dart';
import 'package:to_do/shared/network/firebase/firebase_manager.dart';
import 'package:to_do/styles/colors.dart';

class TasksTab extends StatefulWidget {
  static const String routeName='tasks';

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
   DateTime selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            selectedDate=date;
            setState(() {

            });
          },
          leftMargin: 20,
          monthColor: primary,
          dayColor: Colors.black54,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: primary,
          dotsColor: Colors.white,
          selectableDayPredicate: (date) => date.day != 23,
          locale: 'en_ISO',
        ),
        Expanded(
          child: StreamBuilder(stream: FirebaseManager.getTasks(selectedDate), builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasError){
              return const Center(child: Text('Somthing Went Wrong'));
            }
           var tasks=snapshot.data?.docs.map((doc) => doc.data()).toList()??[];

           return ListView.builder(itemBuilder: (context, index) {
              return TasksItem(tasks[index]);
            },itemCount: tasks.length,);

          },)
        )
      ],
    );
  }
}
