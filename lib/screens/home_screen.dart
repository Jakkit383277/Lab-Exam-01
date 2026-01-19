import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

// AI-ASSISTED: Home Wrapper
class HomeScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  const HomeScreen({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Expiry Tracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: onToggleTheme,
          )
        ],
      ),
      body: const DashboardScreen(),
    );
  }
}
