import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_crud/model/student_model.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "http://192.168.0.9:3000/api/";

  // POST API - Add Student
  static Future<void> addStudent(Map<String, dynamic> sdata) async {
    sdata['enrolled'] =
        sdata['enrolled'].toString();

    var url = Uri.parse(baseUrl + "add_student");

    try {
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(sdata),
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print('Student added: $data');
      } else {
        print("Upload Failed: ${res.body}");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // GET API - Get Students
  static Future<List<Student>> getPerson() async {
    List<Student> students = [];

    var url = Uri.parse(baseUrl + "get_student");

    try {
      final res = await http.get(url);
      print('GET Response: ${res.body}');

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print('Decoded Response: $data');

        if (data['students'] != null) {
          data['students'].forEach((element) {
            students.add(Student.fromJson(element));
          });
        }
      } else {
        print("Failed to fetch students: ${res.body}");
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return students;
  }

  // PUT API - Update Student
  static Future<void> updateStudent(
      int id, Map<String, dynamic> updatedData) async {
    updatedData['enrolled'] = updatedData['enrolled'].toString();

    var url = Uri.parse(baseUrl + "update_student/$id");

    try {
      final res = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedData),
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print('Update Response: $data');
      } else {
        print("Update Failed: ${res.body}");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
