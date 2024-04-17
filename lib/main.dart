import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_list_products/services/objectbox_services.dart';
import 'package:login_list_products/view/pages/authentication_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ObjectBox.createDB();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(useMaterial3: true),
      home: AuthenticationPage(),
    );
  }
}
