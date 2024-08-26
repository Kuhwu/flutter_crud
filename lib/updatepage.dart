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
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late String _selectedCourse;
  late TextEditingController _yearController;
  late bool _enrolled;

  final List<String> _courses = [
    'BSCE',
    'BSIT',
    'BSBA',
    'BSED',
    'BSARCH',
    'BSCRIM',
    'BSHM'
  ];

  @override
  void initState() {
    super.initState();

    _firstnameController =
        TextEditingController(text: widget.student.firstname);
    _lastnameController = TextEditingController(text: widget.student.lastname);
    _selectedCourse = widget.student.course;
    _yearController = TextEditingController(text: widget.student.year);
    _enrolled = widget.student.enrolled ?? false;
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _updateStudent() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> updatedData = {
        'firstname': _firstnameController.text,
        'lastname': _lastnameController.text,
        'course': _selectedCourse,
        'year': _yearController.text,
        'enrolled': _enrolled,
      };

      Api.updateStudent(widget.student.id, updatedData).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Student updated successfully")),
        );

        Navigator.pop(context, updatedData);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update student: $error")),
        );
      });
    }
  }

  void _deleteStudent() {
    Api.deleteStudent(widget.student.id).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Student deleted successfully")),
      );

      Navigator.pop(context, null);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete student: $error")),
      );
    });
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
                value: _selectedCourse,
                decoration: InputDecoration(labelText: 'Course'),
                items: _courses.map((course) {
                  return DropdownMenuItem(
                    value: course,
                    child: Text(course),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCourse = value!;
                  });
                },
              ),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(labelText: 'Year'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the year';
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
                    onPressed: _deleteStudent,
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
