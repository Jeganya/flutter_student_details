import 'package:flutter/material.dart';
import 'package:flutter_student_details/student_details_model.dart';

import 'database_helper.dart';
import 'main.dart';
import 'optimized_student_form_screen.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late List<StudentDetailsModel> _studentDetailsList;

  @override
  void initState() {
    super.initState();
    getAllStudentDetails();
  }

  getAllStudentDetails() async {
    _studentDetailsList = <StudentDetailsModel>[];

    var studentDetailRecords =
        await dbHelper.queryAllRows(DatabaseHelper.studentDetailsTable);

    studentDetailRecords.forEach((studentDetail) {
      setState(() {
        print(studentDetail['_id']);
        print(studentDetail['_studentName']);
        print(studentDetail['_mobileNo']);
        print(studentDetail['_emailId']);

        var studentDetailsModel = StudentDetailsModel(
            studentDetail['_id'],
            studentDetail['_studentName'],
            studentDetail['_mobileNo'],
            studentDetail['_emailId']);

        _studentDetailsList.add(studentDetailsModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: _studentDetailsList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  print('---------->Edit or Delete invoked: Send Data');

                  print(_studentDetailsList[index].id);
                  print(_studentDetailsList[index].studentName);
                  print(_studentDetailsList[index].studentMobileNo);
                  print(_studentDetailsList[index].studentEmailID);

                  /*
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditStudentFormScreen(),
                    settings: RouteSettings(
                      arguments: _studentDetailsList[index],
                    ),
                  ));
                   */

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OptimizedStudentFormScreen(),
                    settings: RouteSettings(
                      arguments: _studentDetailsList[index],
                    ),
                  ));
                },
                child: ListTile(
                  title: Text(_studentDetailsList[index].studentName),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('--------------> Launch Student Details Form Screen');
          /*
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => StudentFormScreen()));
                   */

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OptimizedStudentFormScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
