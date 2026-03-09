import 'package:flutter/material.dart';
import 'pages/dashboard_page.dart';
import 'pages/progress_page.dart';
import 'pages/result_page.dart';
import 'pages/practice_page.dart';
import 'pages/learning_resources_page.dart';
import 'pages/splash_screen.dart';
import 'theme/app_theme.dart';
import 'transitions/page_transitions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iSpeak',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppTheme.primaryColor,
        scaffoldBackgroundColor: AppTheme.backgroundColor,
        fontFamily: AppTheme.fontFamily,
        textTheme: AppTheme.textTheme,  
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ModernPageTransitionsBuilder(),
            TargetPlatform.iOS: ModernPageTransitionsBuilder(),
          },
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/main': (context) => const MainPage(),
      },
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
      DashBoardPage(
        onStartPractice: () => setState(() => _currentIndex = 1),
        onLearningResources: () => setState(() => _currentIndex = 4),
      ),
      PracticePage(
        onFinish: () => setState(() => _currentIndex = 3),
      ),
      const ProgressPage(),
      ResultPage(
        onBackToHome: () => setState(() => _currentIndex = 0),
      ),
      LearningResourcesScreen(
        onBack: () => setState(() => _currentIndex = 0),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool hideBars = _currentIndex == 3;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: hideBars
          ? null
          : SizedBox(
              height: 65,
              width: 65,
              child: FittedBox(
                child: FloatingActionButton(
                  onPressed: () => setState(() => _currentIndex = 1),
                  backgroundColor: const Color(0xFF3F7CF4),
                  elevation: 6,
                  child: const Icon(Icons.mic, size: 28, color: Colors.white),
                ),
              ),
            ),
      bottomNavigationBar: hideBars
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
                    _buildNavItem(Icons.home, 'Home', 0),
                    const SizedBox(width: 80),
                    _buildNavItem(Icons.show_chart, 'Progress', 2),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _currentIndex == index;

    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 26,
            color: isSelected ? const Color(0xFF3F7CF4) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isSelected ? const Color(0xFF3F7CF4) : Colors.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}