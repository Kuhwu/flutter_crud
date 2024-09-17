import 'package:flutter/material.dart';
import 'package:flutter_crud/services/api.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  bool isEnrolled = false;
  final _formKey = GlobalKey<FormState>();

  var firstNameController = TextEditingController();
  var lastnameController = TextEditingController();
  var courseController = TextEditingController();
  String? selectedYear;

  final List<String> _years = [
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lastnameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a last name';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedYear,
                decoration: InputDecoration(labelText: 'Year'),
                items: _years.map((year) {
                  return DropdownMenuItem(
                    value: year,
                    child: Text(year),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedYear = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a year';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: courseController,
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
                value: isEnrolled,
                onChanged: (bool value) {
                  setState(() {
                    isEnrolled = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var data = {
                      "firstname": firstNameController.text,
                      "lastname": lastnameController.text,
                      "course": courseController.text,
                      "year": selectedYear,
                      "enrolled": isEnrolled.toString(),
                    };

                    Api.addStudent(data).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Student added successfully")),
                      );
                      firstNameController.clear();
                      lastnameController.clear();
                      courseController.clear();
                      setState(() {
                        selectedYear = null;
                        isEnrolled = false;
                      });
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to add student: $error")),
                      );
                    });
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
