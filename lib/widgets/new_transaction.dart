import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final nameInput = TextEditingController();
  DateTime _selectedDate;
  final amountInput = TextEditingController();

  void _submited() {
    final _enteredTitle = nameInput.text;
    if (amountInput.text.isEmpty) {
      return;
    }
    final _enteredAmount = double.parse(amountInput.text);

    if (_enteredAmount <= 0 || _enteredTitle.isEmpty || _selectedDate == null) {
      return;
    }

    widget.addTx(_enteredTitle, _enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickDate) {
      if (pickDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            left: 10,
            right: 10,
            top: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                controller: nameInput,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountInput,
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    FlatButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                child: Text('Add Transaction'),
                onPressed: _submited,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
