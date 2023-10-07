import 'package:flutter/material.dart';
import 'package:to_do/styles/colors.dart';

import '../screens/Tasks/AddTaskBottomSheet.dart';
import '../screens/settings.dart';
import '../screens/Tasks/tasks.dart';

class HomeLayout extends StatefulWidget {
   const HomeLayout({super.key});
  static const String routeName='home';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index=0;
  List<Widget>tabs=[ TasksTab(), SettingsTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: mintGreen,
      appBar:AppBar(
        titleSpacing: 30,
        title: const Text('ToDo List'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showAddTaskBottomSheet();
      },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.white,
            width: 3.0
          )
        ),
      child: const Icon(Icons.add,color: Colors.white,size: 30,),

      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        notchMargin: 8.0,
        shape: const CircularNotchedRectangle(
        ),
        child: BottomNavigationBar(
          elevation: 0,
            currentIndex: index,
            onTap: (value) {
              index=value;
              setState(() {

              });
            },
            items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list),label: '',),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: ''),

        ]),
      ),
      body: tabs[index],
    );
  }
  showAddTaskBottomSheet(){

   showModalBottomSheet(
     isScrollControlled: true,
     context: context, builder: (context) {
     return  Padding(
       padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
       child: const AddTaskBottomSheet(),
     );
   },);
  }
}
