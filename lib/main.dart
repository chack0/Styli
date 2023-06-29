// FLUTTER IMPORTS
import 'package:flutter/material.dart';

// PACKAGE IMPORTS
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styli_test/application/image_grid/image_grid_cubit.dart';

// PROJECT IMPORTS
import 'package:styli_test/presentation/app_base.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          // Given for fetching the images from API using cubit.
          create: (context) => ImageGridCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AppBase(), // Base screen of the application.
      ),
    );
  }
}
