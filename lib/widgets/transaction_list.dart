import 'package:expense_tracker/models/transaction.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        child: (Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text(
                "List of Transactions",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "Oswald",
                  //  fontWeight: FontWeight.w800
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.414,
              child: SingleChildScrollView( 
                child: Column(
                  children: [
                    ...(transactions.map((tx) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  )),
                                  child: Text(
                                    "\$${tx.amount.toString()}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 2),
                                        child: Text(
                                          tx.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ),
                                      Text(DateFormat().format(tx.date))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })).toList()
                  ],
                ),
              ),
            ),
            // Image.asset(
            //   "assests/images/Dummy1.jpg",
            //   // height: 200,
            //   // width: 300,
            // )
          ],
        )));
  }
}
