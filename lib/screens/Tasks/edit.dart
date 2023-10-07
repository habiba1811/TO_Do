import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/shared/network/firebase/firebase_manager.dart';

import '../../styles/colors.dart';

class EditTask extends StatefulWidget {
   EditTask({super.key});
  static const String routeName='edit';


  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var selectedDate ;
  var titleController = TextEditingController();
  var detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var args=ModalRoute.of(context)?.settings.arguments as TaskModel;
    titleController.text=args.title;
    detailsController.text=args.description;
   var convertedDate = DateTime.fromMillisecondsSinceEpoch(args.date);
    selectedDate=convertedDate;
    return Scaffold(
      backgroundColor: mintGreen,
      appBar: AppBar(
        title: Text('Edit Task',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: Card(
    elevation: 14,
    margin: EdgeInsets.all(18),
    shape: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide.none
    ),
        child:  Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add New Task',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            TextFormField(
                controller:titleController ,
                decoration: InputDecoration(
                  label: const Text('This is Title'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: primary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: primary,
                    ),
                  ),
                )),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
                controller: detailsController,
                decoration: InputDecoration(
                  label: const Text('Task details'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: primary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: primary,
                    ),
                  ),
                )),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Selected Data',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            InkWell(
              onTap: () {
                selectDate();
              },
              child: Text(
                selectedDate.toString().substring(0, 10),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
           ElevatedButton(
                onPressed: () {
                  TaskModel task = TaskModel(
                      title: titleController.text,
                      description: detailsController.text,
                      date:DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
                  FirebaseManager.addTask(task).then(
                        (value) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Successfuly'),
                            content: const Text('Edit was done'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Thank you"))
                            ],
                          );
                        },
                      );
                    },
                  );
                },
               child: const Text('Save Changes')),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    ),
      ),
    );
  }

  selectDate() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (chosenDate == null) {
      return;
    }
    selectedDate = chosenDate;
    setState(() {});
  }
}
