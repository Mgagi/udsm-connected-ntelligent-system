import 'package:flutter/material.dart';

import 'screens.dart';
import 'theme.dart';

void main() {
  runApp(const UcisAdminApp());
}

class UcisAdminApp extends StatelessWidget {
  const UcisAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UDSM Mobile Application',
      debugShowCheckedModeBanner: false,
      theme: buildUcisTheme(),
      home: const UcisMobilePrototype(),
    );
  }
}
