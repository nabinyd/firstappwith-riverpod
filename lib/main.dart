// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
//import 'package:firstapp/splash_screen.dart';
// import 'package:firstapp/home_screen.dart';
import 'package:firstapp/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider<bool>((ref) {
  return true;
});
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isLightTheme ? ThemeData.light() : ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}
