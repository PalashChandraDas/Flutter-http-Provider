import 'package:flutter/material.dart';
import 'package:flutter_http/modules/reqresApi/view/reqres_view.dart';
import 'package:flutter_http/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'modules/jsonHolderAPI/provider/json_holder_provider.dart';
import 'modules/reqresApi/provider/reqres_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => JsonHolderProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ReqresProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter HTTP',
      theme: AppTheme.themeData,
      home: const ReqresView(),
    );
  }
}
