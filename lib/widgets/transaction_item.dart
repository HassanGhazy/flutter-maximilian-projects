import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:purchases/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required Transaction transaction,
    @required Function deleteTransaction,
  })  : _transactions = transaction,
        _deleteTransaction = deleteTransaction,
        super(key: key);

  final Transaction _transactions;
  final Function _deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  // Color _bgColor;

  // @override
  // void initState() {
  //   const availableColor = [
  //     Colors.red,
  //     Colors.black,
  //     Colors.blue,
  //     Colors.purple
  //   ];
  //   _bgColor = availableColor[Random().nextInt(4)];
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
                child: Text(
              '\$${widget._transactions.amount}',
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
        title: Text(
          widget._transactions.title,
          //     style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMEd().add_jms().format(widget._transactions.date),
          style: TextStyle(color: Colors.grey),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatButton.icon(
                onPressed: () =>
                    widget._deleteTransaction(widget._transactions.id),
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    widget._deleteTransaction(widget._transactions.id)),
      ),
    );
  }
}
