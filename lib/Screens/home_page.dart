import 'package:flutter/material.dart';
import 'package:graphql_todo/Screens/add_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Todo'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding:const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    margin:const EdgeInsets.all(20),
                    child:const Text('Available Todo'),
                  ),
                  Expanded(
                    child: ListView(
                      children: List.generate(5, (index) {
                        return ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text('Todo title'),
                          subtitle: const Text('Todo Time'),
                          leading: const CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              //Delete task
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>const AddTodo(),
            ));
          },
          label: const Text('Add Todo')),
    );
  }
}
