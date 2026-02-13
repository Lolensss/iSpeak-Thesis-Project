import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'progress_page.dart';
import 'result_page.dart';
import 'practice_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DashBoardPage(onStartPractice: () => setState(() => _currentIndex = 1)),
      PracticePage(onFinish: () => setState(() => _currentIndex = 3)),
      const ProgressPage(),
      ResultPage(onBackToHome: () => setState(() => _currentIndex = 0)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _currentIndex == 3
          ? null
          : SizedBox(
              height: 65,
              width: 65,
              child: FittedBox(
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() => _currentIndex = 1);
                  },
                  backgroundColor: const Color(0xFF3F7CF4),
                  elevation: 6,
                  child: const Icon(Icons.mic, size: 28, color: Colors.white),
                ),
              ),
            ),
      bottomNavigationBar: _currentIndex == 3
          ? null
          : BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              color: Colors.white,
              elevation: 8,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Home
                    InkWell(
                      onTap: () => setState(() => _currentIndex = 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            size: 26,
                            color: _currentIndex == 0 ? const Color(0xFF3F7CF4) : Colors.grey,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 11,
                              color: _currentIndex == 0 ? const Color(0xFF3F7CF4) : Colors.grey,
                              fontWeight: _currentIndex == 0 ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 80), 
                    // Progress
                    InkWell(
                      onTap: () => setState(() => _currentIndex = 2),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.show_chart,
                            size: 26,
                            color: _currentIndex == 2 ? const Color(0xFF3F7CF4) : Colors.grey,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Progress',
                            style: TextStyle(
                              fontSize: 11,
                              color: _currentIndex == 2 ? const Color(0xFF3F7CF4) : Colors.grey,
                              fontWeight: _currentIndex == 2 ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
