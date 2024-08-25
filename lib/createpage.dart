import 'package:flutter/material.dart';
import 'package:flutter_crud/services/api.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  bool isEnrolled = false;

  var firstNameController = TextEditingController();
  var lastnameController = TextEditingController();
  var yearController = TextEditingController();
  String? selectedCourse;
  //var enrolledController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.greenAccent])),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white54),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 70, right: 70),
                    child: TextField(
                      controller: firstNameController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 70, right: 70),
                    child: TextField(
                      controller: lastnameController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 70, right: 70),
                    child: DropdownButtonFormField<String>(
                      value: selectedCourse,
                      items: <String>[
                        'BSCE',
                        'BSIT',
                        'BSBA',
                        'BSED',
                        'BSARCH',
                        'BSCRIM',
                      ].map((String year) {
                        return DropdownMenuItem<String>(
                          value: year,
                          child: Text(
                            year,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        hintText: 'Course',
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      dropdownColor: Colors.white,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCourse = newValue;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 70, right: 70),
                    child: TextField(
                      controller: yearController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Year',
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 70, right: 70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Enrolled',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Switch(
                          value: isEnrolled,
                          onChanged: (bool value) {
                            setState(() {
                              isEnrolled = value;
                            });
                          },
                          activeColor: Colors.black,
                          activeTrackColor: Colors.green.shade400,
                          inactiveThumbColor: Colors.black,
                          inactiveTrackColor: Colors.red.shade400,
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  ElevatedButton(
                      onPressed: () {
                        var data = {
                          "firstname": firstNameController.text,
                          "lastname": lastnameController.text,
                          "year": yearController.text,
                          "course": selectedCourse,
                          "enrolled": isEnrolled,
                        };

                        Api.addStudent(data);
                      },
                      child: Text("Submit")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
