import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_crud/model/student_model.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "http://192.168.0.9:3000/api/";

  // POST API
  static Future<void> addStudent(Map<String, dynamic> sdata) async {
    sdata['enrolled'] = sdata['enrolled'].toString();

    print(sdata);
    var url = Uri.parse(baseUrl + "add_student");

    try {
      final res = await http.post(url, body: sdata);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print("Upload Failed");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // GET API
  static Future<List<Student>> getPerson() async {
    List<Student> students = [];

    var url = Uri.parse(baseUrl + "get_student");

    try {
      final res = await http.get(url);
      print(
          'GET Response: ${res.body}'); // Debugging line to print the response

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(
            'Decoded Response: $data'); // Debugging line to print the decoded data

        // Check if the correct key is used
        if (data['students'] != null) {
          data['students'].forEach((value) {
            students.add(Student(
              firstname: value['firstname'],
              lastname: value['lastname'],
              course: value['course'],
              year: value['year'],
              enrolled: value['enrolled'] ==
                  'true', // Adjust according to API response
            ));
          });
        }

        return students;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
