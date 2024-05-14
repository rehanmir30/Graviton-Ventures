import 'package:flutter/material.dart';
import 'package:interview_app/models/todoModel.dart';

class TodoDetail extends StatefulWidget {
  final TodoModel todoModel;
  const TodoDetail(this.todoModel,{super.key});

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Title: ${widget.todoModel.title}"),
            Text("Todo id: ${widget.todoModel.id}"),
            Text("Todo user id: ${widget.todoModel.userId}"),
            Text("Todo status: ${widget.todoModel.completed==true?"Completed":"In Complete"}"),
          ],
        ),
      ),
    );
  }
}
