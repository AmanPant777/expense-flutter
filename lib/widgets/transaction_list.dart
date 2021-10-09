import 'package:expense/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transaction;
  final Function deletTx;
  TransactionList(this._transaction,this.deletTx);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: _transaction.isEmpty
            ? Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'No Transaction Added ',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 300,
                    child: Image.asset(
                      'assets/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text('\$${_transaction[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        '${_transaction[index].title}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(_transaction[index].date)),
                      trailing: IconButton(
                          onPressed: ()=>deletTx(_transaction[index].id), icon: Icon(Icons.delete)),
                    ),
                  );
                },
                itemCount: _transaction.length,
              ));
  }
}
