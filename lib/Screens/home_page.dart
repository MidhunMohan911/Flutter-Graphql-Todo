import 'package:flutter/material.dart';
import 'package:graphql_todo/Providers/get_task_provider.dart';
import 'package:graphql_todo/Screens/add_todo.dart';
import 'package:provider/provider.dart';

import '../Providers/delete_task_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFetched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Todo'),
        centerTitle: true,
      ),
      body: Consumer<GetTaskProvider>(builder: (context, task, child) {
        if (isFetched == false) {
          task.getTask(true);
          Future.delayed(Duration(seconds: 3), () => isFetched = true);
        }

        return RefreshIndicator(
          onRefresh: () {
            task.getTask(false);
            return Future.delayed(Duration(seconds: 3));
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: const Text('Available Todo'),
                      ),
                      if (task.getResponseData().isEmpty)
                        const Text('No Todo found'),
                      Expanded(
                          child: ListView(
                        children: List.generate(task.getResponseData().length,
                            (index) {
                          final data = task.getResponseData()[index];
                          return ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(data['task']),
                            subtitle: Text(data['timeAdded'].toString()),
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Text(data['id'].toString()),
                            ),
                            trailing: Consumer<DeleteTaskProvider>(
                                builder: (context, delete, child) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (delete.getResponse != '') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(delete.getResponse)));

                                  delete.clear();
                                }
                              });
                              return IconButton(
                                  onPressed: () {
                                    ///Delete task
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: const Text(
                                          "Are you sure you want to delete task?"),
                                      action: SnackBarAction(
                                          label: "Delete Now",
                                          onPressed: () {
                                            delete.deleteTask(
                                                todoId: data['id']);
                                          }),
                                    ));
                                  },
                                  icon: const Icon(Icons.delete));
                            }),
                          );
                        }),
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddTodo(),
            ));
          },
          label: const Text('Add Todo')),
    );
  }
}
