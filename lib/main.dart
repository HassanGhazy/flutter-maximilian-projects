import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:purchases/widgets/chart.dart';
import 'package:purchases/widgets/new_transaction.dart';
import 'package:purchases/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.purple,
        primarySwatch: Colors.purple,
        textTheme: ThemeData.light().textTheme.copyWith(
              button: TextStyle(color: Colors.white),
            ),
      ),
      home: MyHomePage(title: 'Dept Book'),
    );
  }
}

final List<Transaction> _userTransaction = [];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String idtx) {
    setState(() {
      _userTransaction.removeWhere((e) => e.id == idtx);
    });
  }

  void _addNewTransaction(String name, double amountTx, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: name,
        amount: amountTx,
        date: chosenDate);

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  _buildLandscapeContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Show Chart'),
        Switch(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            })
      ],
    );
  }

  _buildPortaitContent(MediaQueryData mediaQuery, AppBar appBar) {
    return Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            .3,
        child: Chart(_resentTransaction));
  }

  bool _showChart = false;
  List<Transaction> get _resentTransaction {
    return _userTransaction.where((e) {
      return e.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context))
      ],
    );
    final txListWedgit = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            .7,
        child: TransactionList(_userTransaction, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape) _buildLandscapeContent(),
            if (!isLandScape)
              _buildPortaitContent(mediaQuery, appBar),
            if (!isLandScape)
              txListWedgit,
            if (isLandScape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          .7,
                      child: Chart(_resentTransaction))
                  : txListWedgit
            // UserTransaction(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context)),
    );
  }
}
