import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/transaction_db.dart';
import 'package:flutter_application_1/models/category_models.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../db/category_db.dart';
import '../../models/transaction_models.dart';

final editPurposetextcontroller = TextEditingController();
final editAmoundtextcontroller = TextEditingController();

DateTime? selectedDate;
CategoryType? selectedCategoryType;
CategoryModels? selectedCategoryModel;
String? selectedValue;

class ScreenTransaction extends StatefulWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenTransaction> createState() => _ScreenTransactionState();
}

class _ScreenTransactionState extends State<ScreenTransaction> {
  @override
  Widget build(BuildContext context) {
    TransactionDb.singleton.refresh();
    return ValueListenableBuilder(
        valueListenable: TransactionDb.singleton.transactionListNotifier,
        builder: (BuildContext context, List<transactionModels> newValue,
            Widget? _) {
          return TransactionDb
                  .singleton.transactionListNotifier.value.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          padding: const EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                            final _value = newValue[index];

                            return Slidable(
                              key: Key(_value.id),
                              direction: Axis.horizontal,
                              startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        showfoam(context, _value.purpose);
                                      },
                                      backgroundColor:
                                          Color.fromARGB(255, 118, 121, 126),
                                      //  foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: 'Edit',
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {
                                        TransactionDb.singleton
                                            .deletetransaction(_value.id);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'An item has been deleted')));
                                      },
                                      backgroundColor:
                                          Color.fromARGB(255, 198, 136, 136),
                                      // foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ]),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
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
                                      backgroundColor:
                                          _value.type == CategoryType.expense
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
                          itemCount: newValue.length),
                    ),
                  ],
                )
              : const Center(
                  child: Text(
                    "Tap the '+' icon to add new items",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                );
        });
  }

  String parsedDate(DateTime date) {
    final _date = DateFormat("d\nMMM").format(date);
    return _date;
  }

  showfoam(BuildContext ctx, String? itemkey) async {
    if (itemkey != null) {
      final existingItem = TransactionDb.singleton.transactionListNotifier.value
          .firstWhere((element) => element.purpose == itemkey);

      editPurposetextcontroller.text = existingItem.purpose;
      editAmoundtextcontroller.text = existingItem.amount.toString();
      selectedDate = existingItem.date;
      selectedCategoryType = existingItem.type;
      selectedCategoryModel = existingItem.model;

      showModalBottomSheet(
        context: ctx,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: editPurposetextcontroller,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: 'Purpose'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: editAmoundtextcontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Amount'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton.icon(
                  onPressed: () async {
                    final selectedDatetemp = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now(),
                    );

                    if (selectedDatetemp == null) {
                      return;
                    } else {
                      print(selectedDatetemp.toString());
                      setState(() {
                        selectedDate = selectedDatetemp;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(DateFormat('dd-MM-yyyy').format(selectedDate!))),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Radio(
                      value: CategoryType.income,
                      groupValue: selectedCategoryType,
                      onChanged: (newvalue) {
                        setState(() {
                          selectedCategoryType = CategoryType.income;
                          selectedValue = null;
                        });
                      }),
                  const Text('Income'),
                  Radio(
                      value: CategoryType.expense,
                      groupValue: selectedCategoryType,
                      onChanged: (newvalue) {
                        setState(() {
                          selectedCategoryType = CategoryType.expense;
                          selectedValue = null;
                        });
                      }),
                  const Text('Expanse')
                ]),
              ),
              DropdownButton<String>(
                  hint: const Text('Select Category'),
                  value: selectedValue,
                  items: (selectedCategoryType == CategoryType.income
                          ? CategoryDb().incomeCatogoryNotifier
                          : CategoryDb().expanseCatogoryNotifier)
                      .value
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: () {
                        selectedCategoryModel = e;
                      },
                    );
                  }).toList(),
                  onChanged: (selectedvalue) {
                    setState(() {
                      print(selectedvalue);
                      selectedValue = selectedvalue;
                    });
                  }),
              GestureDetector(
                onTap: () {
                  Navigator.of(ctx).pop();
                },
                child: ElevatedButton(
                    onPressed: () {
                      final updatedItem = transactionModels(
                          id: existingItem.id,
                          amount: double.parse(editAmoundtextcontroller.text),
                          purpose: editPurposetextcontroller.text,
                          isDeleted: false,
                          date: DateTime.parse(selectedDate.toString()),
                          type: selectedCategoryType!,
                          model: selectedCategoryModel!);
                      TransactionDb()
                          .edittransaction(updatedItem, existingItem.id);
                      Navigator.pop(context);

                      TransactionDb()
                          .transactionListNotifier
                          .value
                          .removeWhere((item) => item.id == existingItem.id);
                      TransactionDb()
                          .transactionListNotifier
                          .value
                          .add(updatedItem);

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('An item has been Updated')));
                    },
                    child: const Text('Update')),
              )
            ],
          ),
        ),
      );
    }
  }
}
