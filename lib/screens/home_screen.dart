import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_mobile/providers/navbar_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bodies = [
      const Center(
        child: Text('Hello From Home'),
      ),
      const Center(
        child: Text('Hello From Favorite'),
      ),
      const Center(
        child: Text('Hello From Settings'),
      ),
    ];

    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavbar,
        onTap: (value) {
          ref.read(indexBottomNavbarProvider.notifier).update((state) => value);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Setting'
          ),
        ],
      ),
      body: bodies[indexBottomNavbar],
    );
  }
}