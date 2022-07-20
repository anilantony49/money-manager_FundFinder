import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/transaction_models.dart';
import 'package:hive_flutter/hive_flutter.dart';


const _TRANSACTION_DB_NAME= 'TransactionDB';
abstract class TransactionDbfunctions{
  Future<List<transactionModels>>getTransaction();
  Future<void>insertTransaction(transactionModels value);
Future<void>deletetransaction( String transactionId);
}

class TransactionDb implements TransactionDbfunctions{
ValueNotifier<List<transactionModels>> transactionListNotifier=ValueNotifier([]);
  TransactionDb._internal();
  static final TransactionDb singleton = TransactionDb._internal();

  factory TransactionDb() {
    return singleton;
  }
  @override
  Future<void> deletetransaction(String transactionId) {
    // TODO: implement deletetransaction
    throw UnimplementedError();
  }

  @override
  Future<List<transactionModels>> getTransaction()async {
   final _transactionDB=  await  Hive.openBox<transactionModels>(_TRANSACTION_DB_NAME);
   return   _transactionDB.values.toList();

  }

Future<void>refresh()async {
final _allTransactions=await getTransaction();
  _allTransactions.sort((a, b) =>
     
      b.date.compareTo(a.date)
    );
   transactionListNotifier.value.clear();
   transactionListNotifier.value.addAll(_allTransactions);
   
//  await Future.forEach(_allTransactions, (transactionModels category){
 transactionListNotifier.notifyListeners();
//  }); 
   
  }

  @override
  Future<void> insertTransaction(transactionModels value)async {
   final _transactionDB=  await  Hive.openBox<transactionModels>(_TRANSACTION_DB_NAME);

   await _transactionDB.put(value.id,value);
    //  refreshUI();
  }
  
}