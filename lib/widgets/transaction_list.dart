import 'package:flutter/material.dart';
import 'package:purchases/models/transaction.dart';
import 'package:purchases/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Column(
              children: <Widget>[
                Text(
                  'No Transaction',
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constrains.maxHeight * .6,
                  child: Image.asset(
                    'assets/images/Z.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView(
            children: _transactions
                .map(
                  (e) => TransactionItem(
                    key: ValueKey(e.id),
                    transaction: e,
                    deleteTransaction: _deleteTransaction,
                  ),
                )
                .toList(),
          );
  }
}
