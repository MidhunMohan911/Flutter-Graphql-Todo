import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_todo/Providers/add_task_provider.dart';
import 'package:graphql_todo/Providers/get_task_provider.dart';
import 'package:graphql_todo/Screens/home_page.dart';
import 'package:provider/provider.dart';

import 'Providers/delete_task_provider.dart';

void main() async {
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddTaskProvider()),
        ChangeNotifierProvider(create: (context) => GetTaskProvider()),
        ChangeNotifierProvider(create: (_) => DeleteTaskProvider())
      ],
      child: MaterialApp(
        title: 'Graphql Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
