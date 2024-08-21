import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "http://192.168.0.8/api/";

  static addStudent(Map sdata) async {
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
}
