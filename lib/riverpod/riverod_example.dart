import 'dart:async';

import 'package:firstapp/riverpod/api_service.dart';
import 'package:firstapp/riverpod/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final nameprovider = Provider((ref) {
  return "Hello";
});

final countProvider = StateProvider<int>((ref) {
  return 0;
});

final counterProvider = StateNotifierProvider<CounterDemoNotifier, int>((ref) {
  return CounterDemoNotifier();
});

final apiProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final userdataProvider = FutureProvider<List<UserModel>>((ref) async {
  return ref.read(apiProvider).getuser();
});

class RiverPodExample extends ConsumerStatefulWidget {
  const RiverPodExample({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RiverPodExampleState();
}

class _RiverPodExampleState extends ConsumerState<RiverPodExample> {
  @override
  Widget build(BuildContext context) {
    final name = ref.watch(nameprovider);
    final count = ref.watch(countProvider);
    final increment = ref.read(countProvider.notifier);

    ref.listen(
      countProvider,
      (previous, next) {
        if (next > 5) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('the value is $next')));
        }
      },
    );

    final counternotifier = ref.watch(countProvider);

    final userData = ref.watch(userdataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('River Pod Example'),
        actions: [
          IconButton(
              onPressed: () {
                ref.invalidate(countProvider);
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name),
            Text(count.toString()),
            FloatingActionButton(
              onPressed: () {
                increment.state++;
              },
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              child: Text('state notifier provider'),
            ),
            Text('$counternotifier'.toString()),
            FloatingActionButton(onPressed: () {
              ref.read(counterProvider.notifier).increment();
            }),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const DataList(),
                  ));
                },
                child: const Text('api post'))
          ],
        ),
      )),
    );
  }
}

class DataList extends ConsumerWidget {
  const DataList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userdata = ref.watch(userdataProvider);
    return Scaffold(
        body: userdata.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: const Text("{data[index].title}"),
              leading: Text('$data[index].id'.toString()),
            );
          },
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }
}

class CounterDemoNotifier extends StateNotifier<int> {
  CounterDemoNotifier() : super(0);
  void increment() {
    state++;
  }
}
