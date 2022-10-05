import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expense Tracker")),
      body: Column(
        children: [
          Card(
            child: Container(
              width: double.infinity,
              height: 120,
              padding: const EdgeInsets.all(5),
              child: const Text("Chart", style: TextStyle(fontSize: 20)),
            ),
          ),
          const Card(
            child: Text("List Of Txn"),
          )
        ],
      ),
    );
  }
}
