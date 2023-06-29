// FLUTTER IMPORTS.
import 'dart:async';
import 'package:flutter/material.dart';

// PROJECT IMPORTS.
import 'package:styli_test/presentation/screens/grid_view_page/grid_view.dart';
import 'package:styli_test/presentation/screens/splash_screen/splash_screen.dart';

class AppBase extends StatefulWidget {
  const AppBase({Key? key}) : super(key: key);

  @override
  State<AppBase> createState() => _AppBaseState();
}

class _AppBaseState extends State<AppBase> {
  @override
  void initState() {
    // Setting a delay for splashcreen. After 2 seconds page is redirected to grid view page.
    Timer(
      const Duration(seconds: 2),
      () async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const GirdView(),
            ),
            (route) => false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
