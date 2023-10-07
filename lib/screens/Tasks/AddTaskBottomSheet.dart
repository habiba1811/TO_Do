import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/shared/network/firebase/firebase_manager.dart';
import 'package:to_do/styles/colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                controller: titleController,
                decoration: InputDecoration(
                  label: const Text('Task Title'),
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
                controller: descriptionController,
                decoration: InputDecoration(
                  label: const Text('Task description'),
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
              height: 18,
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
              height: 18,
            ),
            ElevatedButton(
                onPressed: () {
                  TaskModel task = TaskModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      date:DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
                  FirebaseManager.addTask(task).then(
                    (value) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Successfuly'),
                            content: const Text('Tasks Added to Firebase'),
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
                child: const Text('Add Task')),
          ],
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
