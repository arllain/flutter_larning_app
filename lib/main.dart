import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning_app/app_blocs.dart';
import 'package:flutter_learning_app/app_events.dart';
import 'package:flutter_learning_app/pages/sign_in/sign_in.dart';
import 'package:flutter_learning_app/pages/welcome/bloc/welcome_bloc.dart';
import 'package:flutter_learning_app/pages/welcome/welcome.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_states.dart';

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
          create: (context) => WelcomeBloc(),
        ),
        BlocProvider(
          create: (context) => AppBlocs(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
            ),
            home: const Welcome(),
            routes: {
              'myHomePage': (context) => const MyHomePage(),
              'signIn': (context) => const SignIn(),
            }),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Center(child: BlocBuilder<AppBlocs, AppStates>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  "${BlocProvider.of<AppBlocs>(context).state.counter}",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            );
          },
        )),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              heroTag: "heroTag1",
              onPressed: () =>
                  BlocProvider.of<AppBlocs>(context).add(Decrement()),
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ), // This trailing co
            FloatingActionButton(
              heroTag: "heroTag2",
              onPressed: () =>
                  BlocProvider.of<AppBlocs>(context).add(Increment()),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ), // This trailing co
          ],
        ));
  }
}
