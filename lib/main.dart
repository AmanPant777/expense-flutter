import 'package:expense/transaction.dart';
import 'package:expense/widgets/Chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personel Expense',
      theme: ThemeData(primarySwatch: Colors.purple, accentColor: Colors.amber),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Personel Expense'),
        ),
        body: App(),
      ),
    );
  }
}

class App extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<App> {
  final List<Transaction> _userTransaction = [
    Transaction(
        id: '1', title: 'Laptop Shopping', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: '2', title: 'Cloth Shopping', amount: 68.99, date: DateTime.now()),
  ];
  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate);

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      return _userTransaction.removeWhere((tx)=>tx.id==id);
    });
  }

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 130,
            child: Chart(_recentTransaction),
          ),
          TransactionList(_userTransaction,_deleteTransaction),
          FloatingActionButton(
            onPressed: () => startAddNewTransaction(context),
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
