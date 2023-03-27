import 'package:flutter/material.dart';
import 'package:flutter_application_1/homescreen.dart';
import 'package:flutter_application_1/models/category_models.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/transaction_models.dart';
import 'screens/transaction/transaction_show_textfield.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelsAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelsAdapter());
  }

  if (!Hive.isAdapterRegistered(transactionModelsAdapter().typeId)) {
    Hive.registerAdapter(transactionModelsAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.blueGrey,
              secondary: Colors.grey,
              // surfaceVariant: Colors.amber
              // surface: Colors.deepOrange
              // onSecondary: Colors.cyan
              // onPrimary: Colors.lime,
              // brightness:  Brightness.dark
              // background: Colors.lime
              // secondaryContainer: Colors.amber
            ),
      ),
      // theme: ThemeData(
      //     primarySwatch: Colors.blue,
      //     colorScheme: ColorScheme(
      //         brightness: Brightness.light,
      //         primary: Colors.blue,
      //         onPrimary: Colors.white,
      //         secondary:  Colors.deepPurple,
      //         onSecondary: Colors.white,
      //         error:  Colors.red,
      //         onError:  Colors.white,
      //         background: Colors.grey,
      //         onBackground:Colors.black,
      //         surface: Colors.white,
      //         onSurface: Colors.black,)),
      home: ScreenHome(),
      // initialRoute: 'first',
      routes: {
        'first': (context) => const TransactionTextField(),
      },
    );
  }
}
