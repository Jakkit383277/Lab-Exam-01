import 'package:flutter/material.dart';
import 'home_screen.dart';

// AI-ASSISTED: PageView onboarding + Navigator
class OnboardingScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const OnboardingScreen({super.key, required this.onToggleTheme});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  int page = 0;

  Widget pageItem(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 120),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }

  void goHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) =>
            HomeScreen(onToggleTheme: widget.onToggleTheme),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (i) => setState(() => page = i),
        children: [
          pageItem("Track Products", Icons.inventory),
          pageItem("Know Expiry Date", Icons.calendar_month),
          pageItem("Get Alert", Icons.notifications),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(page == 2 ? "Start" : "Next"),
        icon: const Icon(Icons.arrow_forward),
        onPressed: () {
          if (page == 2) {
            goHome(); // ✅ ใช้ context ที่ถูกต้อง
          } else {
            controller.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
    );
  }
}
