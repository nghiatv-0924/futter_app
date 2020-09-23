import 'package:flutter/material.dart';
import 'package:flutter_app/week5/add_student_screen.dart';
import 'package:flutter_app/week5/student.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List<Student> _students;

  @override
  void initState() {
    super.initState();
    _students = List<Student>.generate(
      10,
      (index) => Student.fullInfo(
        index,
        "nghia",
        "android",
        "10",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return _itemStudent(_students[index]);
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              thickness: 1,
            );
          },
          itemCount: _students.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueAccent,
        onPressed: () async {
          final student = await Navigator.of(context).push(
            AddStudentScreen.getPage(type: AddStudentType.CREATE),
          );
          if (student != null) {
            setState(() {
              _students.add(student);
            });
          }
        },
      ),
    );
  }

  Widget _itemStudent(Student student) {
    return InkWell(
      onTap: () async => _editStudent(student),
      onLongPress: () => _deleteStudent(student),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 60),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.all(8),
              width: 50,
              height: 50,
              child: Text(
                student.name[0].toUpperCase(),
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    student.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    student.className ?? "",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                student.grades,
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editStudent(Student student) async {
    final result = await Navigator.of(context).push(
      AddStudentScreen.getPage(type: AddStudentType.EDIT, student: student),
    );
    if (result != null) {
      setState(() {});
    }
  }

  Future<void> _deleteStudent(Student student) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Do you want delete this student?"),
          actions: [
            RaisedButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            RaisedButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
    if (result == true) {
      setState(() {
        _students.removeWhere((e) => e.id == student.id);
      });
    }
  }
}
