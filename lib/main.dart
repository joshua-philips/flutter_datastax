import 'package:flutter/material.dart';
import 'package:flutter_datastax/members_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    AsyncValue members = ref.watch(membersProvider);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: members.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          skipLoadingOnRefresh: false,
          skipLoadingOnReload: false,
          error: (err, stack) => Text('Error: $err'),
          data: (data) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('$data'),
                  ),
                  ElevatedButton(
                      onPressed: () => ref.refresh(membersProvider.future),
                      child: const Text('Reload'))
                ],
              ),
            );
          },
        )));
  }
}
