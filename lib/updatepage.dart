import 'package:flutter/material.dart';
import 'package:flutter_crud/model/student_model.dart';
import 'package:flutter_crud/services/api.dart';

class Updatepage extends StatefulWidget {
  final Student student;

  const Updatepage({super.key, required this.student});

  @override
  State<Updatepage> createState() => _UpdatepageState();
}

class _UpdatepageState extends State<Updatepage> {
  late Future<List<Student>> studentsFuture;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late TextEditingController _courseController;
  late String _selectedYear;
  late bool _enrolled;

  final List<String> _year = [
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
  ];

  @override
  void initState() {
    super.initState();

    studentsFuture = Api.getPerson();

    _firstnameController =
        TextEditingController(text: widget.student.firstname);
    _lastnameController = TextEditingController(text: widget.student.lastname);
    _selectedYear = widget.student.year;
    _courseController = TextEditingController(
        text: widget.student.course.toString());
    _enrolled = widget.student.enrolled ?? false;
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _courseController.dispose();
    super.dispose();
  }

void _updateStudent() {
  if (_formKey.currentState!.validate()) {
    Map<String, dynamic> updatedData = {
      'firstname': _firstnameController.text,
      'lastname': _lastnameController.text,
      'course': _courseController.text,        
      'year': _selectedYear,
      'enrolled': _enrolled,
    };

    Api.updateStudent(widget.student.id, updatedData).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Student updated successfully")),
      );

      Navigator.pop(context, true);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update student: $error")),
      );
    });
  }
}


  void _deleteStudent(String studentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Confirmation"),
          content: Text("Are you sure you want to delete this student?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                Navigator.of(context).pop();
                Api.deleteStudent(studentId).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Student deleted successfully!'),
                    ),
                  );
                  Navigator.pop(context, true);
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete student: $error'),
                    ),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Update ${widget.student.firstname} ${widget.student.lastname}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstnameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastnameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a last name';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedYear,
                decoration: InputDecoration(labelText: 'Year'),
                items: _year.map((year) {
                  return DropdownMenuItem(
                    value: year,
                    child: Text(year),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedYear = value!;
                  });
                },
              ),
              TextFormField(
                controller: _courseController,
                decoration: InputDecoration(labelText: 'Course'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the course';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: Text('Enrolled'),
                value: _enrolled,
                onChanged: (bool value) {
                  setState(() {
                    _enrolled = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _updateStudent,
                    child: Text('Update Student'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _deleteStudent(
                          widget.student.id); // Pass the student ID here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('Delete Student'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
