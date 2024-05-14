import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:interview_app/databaseHelper/databasehelper.dart';
import 'package:interview_app/models/todoModel.dart';
import 'package:interview_app/screens/todoDetail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TodoModel> todoList = [];

  Future<List<TodoModel>> fetchData() async {
    // Simulate network delay
    todoList = await DatabaseHelper().FetchData();
    return todoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Response"),
      ),
      body: Center(
        child: FutureBuilder<List<TodoModel>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return snapshot.data?.length == null || snapshot.data!.isEmpty
                  ? const Text("No Todo found")
                  : ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return TodoItem(snapshot.data![index]);
                      },
                    ).marginSymmetric(horizontal: 12);
            }
          },
        ),
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final TodoModel todoModel;

  const TodoItem(this.todoModel, {super.key});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: (){
          Get.to(TodoDetail(widget.todoModel),transition: Transition.circularReveal);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: widget.todoModel.completed == true
                  ? Colors.green.withOpacity(0.5)
                  : Colors.red.withOpacity(0.5)),
          alignment: Alignment.center,
          child: Text("${widget.todoModel.title}",textAlign: TextAlign.center,).marginSymmetric(horizontal: 8),
        ),
      ),
    ).marginSymmetric(vertical: 8);
  }
}
