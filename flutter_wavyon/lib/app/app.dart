import 'package:flutter/material.dart';

import '../widgets/app_shell.dart';
import 'theme.dart';

class WavyonApp extends StatelessWidget {
  const WavyonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wavyon Flutter Draft',
      debugShowCheckedModeBanner: false,
      theme: buildWavyonTheme(),
      home: const WavyonShell(),
    );
  }
}
