import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/transaction_db.dart';
import 'package:flutter_application_1/models/category_models.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../models/transaction_models.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDb.singleton.refresh();
    return ValueListenableBuilder(
        valueListenable: TransactionDb.singleton.transactionListNotifier,
        builder: (BuildContext context, List<transactionModels> newValue,
            Widget? _) {
          return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final _value = newValue[index];

                return Slidable(
                  key: Key(_value.id),
                  direction: Axis.horizontal,
                  startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {}),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            TransactionDb.singleton
                                .deletetransaction(_value.id);
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ]),
                  child: Card(
                      elevation: 0,
                      child: ListTile(
                        title: Text(
                          'Rs.${_value.amount}',
                        ),
                        subtitle: Text(_value.purpose),
                        leading: CircleAvatar(
                          child: Text(
                            parsedDate(_value.date),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: _value.type == CategoryType.expense
                              ? Colors.red
                              : Colors.green,
                          radius: 50,
                        ),
                      )),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: newValue.length);
        });
  }

  String parsedDate(DateTime date) {
    final _date = DateFormat("d\nMMM").format(date);
    return _date;
  }
}
