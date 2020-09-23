import 'package:flutter/material.dart';
import 'package:flutter_app/week5/student.dart';

enum AddStudentType { EDIT, CREATE }

class AddStudentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddStudentScreenState();
  }

  static PageRoute getPage({AddStudentType type, Student student}) {
    return MaterialPageRoute(
      builder: (context) => AddStudentScreen(),
      settings: RouteSettings(arguments: {"type": type, "student": student}),
    );
  }
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  Student _student;
  bool _isCreate;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arg = ModalRoute.of(context).settings.arguments;
    _isCreate = arg["type"] == AddStudentType.CREATE;
    _student = _isCreate
        ? Student(DateTime.now().millisecondsSinceEpoch)
        : arg["student"];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(
                flex: 2,
              ),
              Text(
                _isCreate ? "Add student" : "Edit student",
                style: TextStyle(fontSize: 20),
              ),
              Spacer(
                flex: 1,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Student name"),
                onChanged: (value) {
                  _student.name = value;
                },
                initialValue: _student.name,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Class name",
                ),
                initialValue: _student.className,
                onChanged: (value) {
                  _student.className = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Student grades",
                ),
                initialValue: _student.grades,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _student.grades = value;
                },
              ),
              Spacer(
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    child: Text(_isCreate ? "Add" : "Update"),
                    onPressed: () {
                      Navigator.of(context).pop(_student);
                    },
                  ),
                  RaisedButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
