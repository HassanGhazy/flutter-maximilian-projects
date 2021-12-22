import 'package:flutter/material.dart';
import 'package:purchases/models/transaction.dart';
import 'new_transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransaction = [];

  void _addNewTransaction(String name, double amountTx) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: name,
        amount: amountTx,
        date: DateTime.now());

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        // TransactionList(_userTransaction)
      ],
    );
  }
}
