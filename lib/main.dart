import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webio/provider/zk_login_provider.dart';
import 'package:webio/zk_login_page.dart';

import 'data/storage_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ZkLoginStorageManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const ZkLoginPage(),
    );
  }
}
