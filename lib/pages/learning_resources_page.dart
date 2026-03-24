import 'package:flutter/material.dart';

enum _Tab { scripts, challenges, guidedTasks }

enum _Difficulty { beginner, intermediate, advanced }

class LearningResourcesScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const LearningResourcesScreen({super.key, this.onBack});

  @override
  State<LearningResourcesScreen> createState() =>
      _LearningResourcesPageState();
}

class _LearningResourcesPageState extends State<LearningResourcesScreen> {
  _Tab _activeTab = _Tab.scripts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: const Color(0xFFF2F4F7),
        child: SafeArea(
          bottom: true,
          child: DefaultTextStyle.merge(
            style: const TextStyle(decoration: TextDecoration.none),
            child: Column(
              children: [
                _header(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _tabBar(),
                        const SizedBox(height: 20),
                        _subTitle(),
                        const SizedBox(height: 14),
                        if (_activeTab == _Tab.scripts) ..._scriptCards(),
                        if (_activeTab == _Tab.challenges) ..._challengeCards(),
                        if (_activeTab == _Tab.guidedTasks) ..._guidedTaskCards(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 22),
      decoration: const BoxDecoration(
        color: Color(0xFF3F7CF4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.onBack,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.chevron_left, color: Colors.white, size: 20),
                Text(
                  'Back',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Learning Resources',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Improve your speaking skills',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          _tabItem('Scripts', _Tab.scripts),
          _tabItem('Challenges', _Tab.challenges),
          _tabItem('Guided Tasks', _Tab.guidedTasks),
        ],
      ),
    );
  }

  Widget _tabItem(String label, _Tab tab) {
    final isActive = _activeTab == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = tab),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF3F7CF4) : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _subTitle() {
    switch (_activeTab) {
      case _Tab.scripts:
        return const Text(
          'Choose a script to practice with',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        );
      case _Tab.challenges:
        return const Text(
          'Test your skills with timed challenges',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        );
      case _Tab.guidedTasks:
        return const Text(
          'Step-by-step exercises to improve your skills',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        );
    }
  }

  // ── Scripts 

  List<Widget> _scriptCards() {
    return [
      _ScriptCard(
        title: 'Self Introduction',
        description: 'A simple introduction speech to help you get started',
        duration: '2 min',
        difficulty: _Difficulty.beginner,
        language: 'English',
        onTap: () {},
      ),
      const SizedBox(height: 12),
      _ScriptCard(
        title: 'Pagpapakilala (Filipino)',
        description: 'Isang simpleng talumpati para sa pagpapakilala',
        duration: '2 min',
        difficulty: _Difficulty.beginner,
        language: 'Filipino',
        onTap: () {},
      ),
      const SizedBox(height: 12),
      _ScriptCard(
        title: 'Product Presentation',
        description: 'Present a product or service effectively',
        duration: '5 min',
        difficulty: _Difficulty.intermediate,
        language: 'English',
        onTap: () {},
      ),
      const SizedBox(height: 12),
      _ScriptCard(
        title: 'Motivational Speech',
        description: 'Inspire and motivate your audience',
        duration: '5 min',
        difficulty: _Difficulty.intermediate,
        language: 'English',
        onTap: () {},
      ),
      const SizedBox(height: 12),
      _ScriptCard(
        title: 'Keynote Address',
        description: 'Deliver a compelling keynote presentation',
        duration: '10 min',
        difficulty: _Difficulty.advanced,
        language: 'English',
        onTap: () {},
      ),
    ];
  }

  // ── Challenges 

  List<Widget> _challengeCards() {
    return [
      _ChallengeCard(
        title: 'Quick Pitch',
        description: 'Deliver a 60-second elevator pitch about yourself',
        durationSeconds: 60,
        difficulty: _Difficulty.beginner,
        targetWpm: '120-140 WPM',
        onTap: () {},
      ),
      const SizedBox(height: 12),
      _ChallengeCard(
        title: 'Impromptu Topic',
        description: 'Speak for 2 minutes on a random topic',
        durationSeconds: 120,
        difficulty: _Difficulty.intermediate,
        targetWpm: '130-150 WPM',
        onTap: () {},
      ),
      const SizedBox(height: 12),
      _ChallengeCard(
        title: 'Clarity Challenge',
        description: 'Speak for 90 seconds without filler words',
        durationSeconds: 90,
        difficulty: _Difficulty.intermediate,
        targetWpm: '120-150 WPM',
        onTap: () {},
      ),
      const SizedBox(height: 12),
      _ChallengeCard(
        title: 'Speed Round',
        description: 'Deliver a 3-minute presentation at optimal pace',
        durationSeconds: 180,
        difficulty: _Difficulty.advanced,
        targetWpm: '140+ WPM',
        onTap: () {},
      ),
      const SizedBox(height: 12),
      _ChallengeCard(
        title: 'Bilingual Switch',
        description: 'Present in English and Filipino',
        durationSeconds: 120,
        difficulty: _Difficulty.advanced,
        targetWpm: '120-150 WPM',
        onTap: () {},
      ),
    ];
  }

  // ── Guided Tasks 

  List<Widget> _guidedTaskCards() {
    return [
      _GuidedTaskCard(
        title: 'Breathing & Projection',
        steps: 6,
        durationMin: 5,
        category: 'Foundation',
        icon: Icons.volume_up,
        onTap: () {},
      ),
      const SizedBox(height: 12),
      _GuidedTaskCard(
        title: 'Articulation Drills',
        steps: 6,
        durationMin: 5,
        category: 'Clarity',
        icon: Icons.chat_bubble_outline,
        onTap: () {},
      ),
      const SizedBox(height: 12),
      _GuidedTaskCard(
        title: 'Pace Control',
        steps: 6,
        durationMin: 5,
        category: 'Timing',
        icon: Icons.access_time,
        onTap: () {},
      ),
      const SizedBox(height: 12),
      _GuidedTaskCard(
        title: 'Energy & Enthusiasm',
        steps: 6,
        durationMin: 5,
        category: 'Delivery',
        icon: Icons.bolt,
        onTap: () {},
      ),
      const SizedBox(height: 12),
      _GuidedTaskCard(
        title: 'Eliminating Fillers',
        steps: 6,
        durationMin: 5,
        category: 'Clarity',
        icon: Icons.chat_bubble_outline,
        onTap: () {},
      ),
      const SizedBox(height: 12),
      _GuidedTaskCard(
        title: 'Body Language',
        steps: 6,
        durationMin: 5,
        category: 'Presence',
        icon: Icons.person_outline,
        onTap: () {},
      ),
    ];
  }


}


// ── Script Card 

class _ScriptCard extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final _Difficulty difficulty;
  final String language;
  final VoidCallback? onTap;

  const _ScriptCard({
    required this.title,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.language,
    this.onTap,
  });

  Color get _difficultyColor {
    switch (difficulty) {
      case _Difficulty.beginner:
        return const Color(0xFF3FBD7A);
      case _Difficulty.intermediate:
        return const Color(0xFF3F7CF4);
      case _Difficulty.advanced:
        return const Color(0xFFB45FD4);
    }
  }

  Color get _difficultyBg {
    switch (difficulty) {
      case _Difficulty.beginner:
        return const Color(0xFFDFF5E8);
      case _Difficulty.intermediate:
        return const Color(0xFFE6EEFF);
      case _Difficulty.advanced:
        return const Color(0xFFF3E6FF);
    }
  }

  String get _difficultyLabel {
    switch (difficulty) {
      case _Difficulty.beginner:
        return 'Beginner';
      case _Difficulty.intermediate:
        return 'Intermediate';
      case _Difficulty.advanced:
        return 'Advanced';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time,
                              size: 13, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            duration,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: _difficultyBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _difficultyLabel,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _difficultyColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          language,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Guided Task Card 

class _GuidedTaskCard extends StatelessWidget {
  final String title;
  final int steps;
  final int durationMin;
  final String category;
  final IconData icon;
  final VoidCallback? onTap;

  const _GuidedTaskCard({
    required this.title,
    required this.steps,
    required this.durationMin,
    required this.category,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Left: icon box ──
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFE6EEFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF3F7CF4),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            // ── Middle: content ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '$steps steps • $durationMin min',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6EEFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3F7CF4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ── Right: chevron ──
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}


class _ChallengeCard extends StatelessWidget {
  final String title;
  final String description;
  final int durationSeconds;
  final _Difficulty difficulty;
  final String targetWpm;
  final VoidCallback? onTap;

  const _ChallengeCard({
    required this.title,
    required this.description,
    required this.durationSeconds,
    required this.difficulty,
    required this.targetWpm,
    this.onTap,
  });

  Color get _difficultyColor {
    switch (difficulty) {
      case _Difficulty.beginner:
        return const Color(0xFF3FBD7A);
      case _Difficulty.intermediate:
        return const Color(0xFF3F7CF4);
      case _Difficulty.advanced:
        return const Color(0xFFB45FD4);
    }
  }

  Color get _difficultyBg {
    switch (difficulty) {
      case _Difficulty.beginner:
        return const Color(0xFFDFF5E8);
      case _Difficulty.intermediate:
        return const Color(0xFFE6EEFF);
      case _Difficulty.advanced:
        return const Color(0xFFF3E6FF);
    }
  }

  String get _difficultyLabel {
    switch (difficulty) {
      case _Difficulty.beginner:
        return 'Beginner';
      case _Difficulty.intermediate:
        return 'Intermediate';
      case _Difficulty.advanced:
        return 'Advanced';
    }
  }

  String get _formattedDuration => '${durationSeconds}s';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Left: content ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      // Duration
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time,
                              size: 13, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            _formattedDuration,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      // Difficulty badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: _difficultyBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _difficultyLabel,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _difficultyColor,
                          ),
                        ),
                      ),
                      // Target WPM
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.speed,
                              size: 13, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            'Target: $targetWpm',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // ── Right: bullseye icon ──
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF3F7CF4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.adjust,
                color: Colors.white,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}