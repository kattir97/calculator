import 'package:calculator/my_colors.dart';
import 'package:calculator/providers/result_provider.dart';
import 'package:calculator/providers/user_input_provider.dart';
import 'package:calculator/tabs_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String userInput = ref.watch(userInputProvider);
    final String resultValue = ref.watch(resultProvider);
    return Scaffold(
      backgroundColor: MyColors.screenDark,
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              child: Center(
                child: Text(
                  userInput,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
          ),
          const TabsContainer(),
        ],
      ),
    );
  }
}
