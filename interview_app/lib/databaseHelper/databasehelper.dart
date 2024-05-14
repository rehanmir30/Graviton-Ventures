import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview_app/constants/apiconstants.dart';
import 'package:interview_app/models/todoModel.dart';

import '../widgets/customSnackBar.dart';

class DatabaseHelper {

  Future<List<TodoModel>> FetchData() async {
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    List<TodoModel> todoList = [];
    var url = Uri.parse(APIConstants.baseUrl + APIConstants.todo);
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      for (var item in responseJson) {
        TodoModel levelModel = TodoModel.fromMap(item);
        todoList.add(levelModel);
      }
      return todoList;
    } else {
      CustomSnackbar.show("Failed to fetch todo list", Colors.red);
      return todoList;
    }
  }
}
