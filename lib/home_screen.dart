import 'package:firstapp/main.dart';
import 'package:firstapp/riverpod/riverod_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameprovider = Provider<String>((ref) {
  return 'welcome to riverpod';
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameprovider);
    final isLightTheme = ref.watch(themeProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Switch(
                value: isLightTheme,
                onChanged: (value) =>
                    ref.read(themeProvider.notifier).state = value,
              ),
              Text(name),
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.green),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.home),
                      Icon(Icons.contact_emergency),
                    ],
                  ),
                ),
              ),
              Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    // border: Border.all(color: Colors.blue, width: 5.0),
                  ),
                  child: Column(
                    children: [
                      const Text('nabin yadav'),
                      Image.asset(
                        'images/2.jpg',
                        height: 100,
                      ),
                      const TextField(),
                      const SizedBox(
                        height: 10,
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        // backgroundColor: const Color.fromARGB(1, 55, 55, 224),
                        tooltip: 'search',
                        child: const Icon(Icons.search),
                      ),
                    ],
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RiverPodExample(),
                        ));
                  },
                  child: const Text('riverpod'))
            ],
          ),
        ));
  }
}
