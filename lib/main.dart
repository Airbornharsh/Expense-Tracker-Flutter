// ignore_for_file: prefer_is_empty

import 'dart:io';

import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/Chart.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            title: 'Expense Tracker',
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Oswald"),
            home: const MyHomePage(),
          );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: "t1", title: "New Shoes", amount: 17.76, date: DateTime.now()),
    Transaction(
        id: "t2", title: "Keyboard", amount: 24.21, date: DateTime.now()),
    Transaction(id: "t3", title: "Bag", amount: 10.99, date: DateTime.now()),
  ];

  bool clicked = true;
  bool _showChartBt = false;

  void _addNewTransaction(String title, String amount, DateTime date) {
    final temp = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: double.parse(amount),
        date: date);

    setState(() {
      _userTransactions.add(temp);
    });

    Navigator.of(context).pop();
  }

  List<Transaction> get _getRecentTransactions {
    return _userTransactions
        .where((tx) =>
            tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  void startAddNewTransaction(BuildContext Ctx) {
    setState(() {
      if (clicked) {
        clicked = false;
      } else {
        clicked = true;
      }
    });

    showModalBottomSheet(
        context: Ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction, clicked);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              "Expense Tracker",
              style: TextStyle(fontWeight: FontWeight.w100),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                    child: const Icon(Icons.add, size: 32),
                    onTap: () {
                      startAddNewTransaction(context);
                    })
              ],
            ),
          )
        : AppBar(
            title: const Text(
              "Expense Tracker",
              style: TextStyle(fontWeight: FontWeight.w100),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      startAddNewTransaction(context);
                    },
                    icon: const Icon(Icons.add, size: 32)),
              )
            ],
          ) as PreferredSizeWidget;

    final txListWidget = SizedBox(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransactions));

    final pageBody = SafeArea(
      child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        // Card(),
        Column(
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Show Chart"),
                  Switch.adaptive(
                      value: _showChartBt,
                      onChanged: (bool data) {
                        setState(() {
                          _showChartBt = data;
                        });
                      })
                ],
              ),
            if (!isLandscape)
              SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(_getRecentTransactions)),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChartBt
                  ? SizedBox(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.8,
                      child: Chart(_getRecentTransactions))
                  : txListWidget,
          ],
        )
      ])),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () {
                      startAddNewTransaction(context);
                    },
                    child: const Icon(Icons.add, size: 32),
                  ),
          );
  }
}
