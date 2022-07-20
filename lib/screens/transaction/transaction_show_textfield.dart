import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/category_db.dart';
import 'package:flutter_application_1/models/transaction_models.dart';

import '../../db/transaction_db.dart';
import '../../models/category_models.dart';

import 'package:intl/intl.dart';

final purposetextcontroller = TextEditingController();
final amoundtextcontroller = TextEditingController();
const routeName = 'first';

DateTime? _selectedDate;
CategoryType? _selectedCategoryType;
CategoryModels? _selectedCategorModel;
String? _selectedValue;

class TransactionTextField extends StatefulWidget {
  const TransactionTextField({Key? key}) : super(key: key);

  @override
  State<TransactionTextField> createState() => _TransactionTextFieldState();
}

class _TransactionTextFieldState extends State<TransactionTextField> {
  @override
  Widget build(BuildContext context) {
    CategoryDb.singleton.refreshUI();
    return Scaffold(
      appBar: AppBar(
        title: const Text('MONEY MANAGER'),
        centerTitle: true,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: purposetextcontroller,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(hintText: 'Purpose'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: amoundtextcontroller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Amount'),
          ),
        ),
        TextButton.icon(
            onPressed: () async {
              final _selectedDatetemp = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now());

              if (_selectedDatetemp == null) {
                return;
              } else {
                print(_selectedDatetemp.toString());
                setState(() {
                  _selectedDate = _selectedDatetemp;
                });
              }
            },
            icon: const Icon(Icons.calendar_today),
            label: Text(_selectedDate == null
                ? 'Select Date'
                : DateFormat('dd-MM-yyyy').format(_selectedDate!))),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Radio(
                value: CategoryType.income,
                groupValue: _selectedCategoryType,
                onChanged: (newvalue) {
                  setState(() {
                    _selectedCategoryType = CategoryType.income;
                    _selectedValue = null;
                  });
                }),
            const Text('Income'),
            Radio(
                value: CategoryType.expense,
                groupValue: _selectedCategoryType,
                onChanged: (newvalue) {
                  setState(() {
                    _selectedCategoryType = CategoryType.expense;
                    _selectedValue = null;
                  });
                }),
            const Text('Expanse')
          ]),
        ),
        DropdownButton<String>(
            hint: const Text('Select Category'),
            value: _selectedValue,
            items: (_selectedCategoryType == CategoryType.income
                    ? CategoryDb().incomeCatogoryNotifier
                    : CategoryDb().expanseCatogoryNotifier)
                .value
                .map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text(e.name),
                onTap: () {
                  _selectedCategorModel = e;
                },
              );
            }).toList(),
            onChanged: (selectedvalue) {
              setState(() {
                print(selectedvalue);
                _selectedValue = selectedvalue;
              });
            }),
        ElevatedButton(
            onPressed: () {
              addTransaction(context);
            },
            child: const Text('Add'))
      ]),
    );
  }

  Future<void> addTransaction(context) async {
    final _purpose = purposetextcontroller.text;
    final _amount = amoundtextcontroller.text;
    if (_purpose.isEmpty) {
      return;
    }
    if (_amount.isEmpty) {
      return;
    }
    if (_selectedValue == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    if (_selectedCategorModel == null) {
      return;
    }
    final _parsesdAmount = double.tryParse(_amount);
    if (_parsesdAmount == null) {
      return;
    }
    final _transaction = transactionModels(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: _parsesdAmount,
      purpose: _purpose,
      isDeleted: false,
      date: _selectedDate!,
      type: _selectedCategoryType!,
      model: _selectedCategorModel!,
    );
    await TransactionDb.singleton.insertTransaction(_transaction);
    print(_transaction.toString());
    Navigator.of(context).pop();
    TransactionDb.singleton.refresh();
  }
}
