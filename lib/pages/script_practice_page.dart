import 'dart:async';
import 'package:flutter/material.dart';

// ─── Data Model ───────────────────────────────────────────────────────────────

class ScriptData {
  final String title;
  final String description;
  final String duration;
  final String level;
  final String language;
  final String fullContent;
  final List<String> tips;

  const ScriptData({
    required this.title,
    required this.description,
    required this.duration,
    required this.level,
    required this.language,
    required this.fullContent,
    required this.tips,
  });
}

const List<ScriptData> scriptLibrary = [
  ScriptData(
    title: 'Self Introduction',
    description: 'A simple introduction speech to help you get started',
    duration: '2 min',
    level: 'Beginner',
    language: 'English',
    fullContent:
        "Good morning everyone! My name is [Your Name], and I'm delighted to have this opportunity to introduce myself. I am currently working as a [Your Profession], and I have been passionate about [Your Interest] for the past [Number] years. What drives me every day is the opportunity to learn something new and contribute meaningfully to my field. I believe that effective communication is the cornerstone of success in any endeavor. In my free time, I enjoy [Your Hobbies], which help me maintain a healthy work-life balance and keep me energized. Thank you for taking the time to listen. I look forward to connecting with all of you!",
    tips: [
      'Practice reading the script out loud several times',
      'Focus on your pace - aim for 120-150 words per minute',
      'Use natural pauses at punctuation marks',
      'Emphasize key points with vocal variety',
    ],
  ),
  ScriptData(
    title: 'Pagpapakilala (Filipino)',
    description: 'Isang simpleng talumpati para sa pagpapakilala',
    duration: '2 min',
    level: 'Beginner',
    language: 'Filipino',
    fullContent:
        "Magandang umaga sa inyong lahat! Ako si [Pangalan Mo], at natutuwa akong mayroon akong pagkakataong ipakilala ang aking sarili. Kasalukuyan akong nagtatrabaho bilang [Propesyon Mo], at matagal ko nang hilig ang [Interes Mo]. Ang nagtutulak sa akin araw-araw ay ang pagkakataong matuto ng bagong kaalaman at makapag-ambag nang makahulugan sa aking larangan. Sa aking libreng oras, mahilig akong [Libangan Mo], na tumutulong sa akin na mapanatili ang balanseng buhay. Salamat sa inyong pakikinig. Inaasahan kong makakasama ko kayong lahat!",
    tips: [
      'Practice reading the script out loud several times',
      'Focus on your pace - aim for 100-130 words per minute',
      'Use natural pauses at punctuation marks',
      'Emphasize key points with vocal variety',
    ],
  ),
  ScriptData(
    title: 'Product Presentation',
    description: 'Present a product or service effectively',
    duration: '5 min',
    level: 'Intermediate',
    language: 'English',
    fullContent:
        "Good afternoon, everyone. Today I am excited to present to you a product that I believe will make a significant difference in your daily lives. The solution we have developed addresses a very real problem that many of you have encountered. Our product combines cutting-edge technology with an intuitive user experience, making it accessible to everyone. What sets us apart from the competition is our commitment to quality and continuous improvement. We have tested this extensively with real users, and the feedback has been overwhelmingly positive. I invite you to ask questions as we go, and I look forward to demonstrating how this can truly transform your experience.",
    tips: [
      'Know your product inside and out before presenting',
      'Practice transitions between sections smoothly',
      'Maintain eye contact with your audience',
      'Use pauses for emphasis on key features',
    ],
  ),
  ScriptData(
    title: 'Motivational Speech',
    description: 'Inspire and motivate your audience',
    duration: '5 min',
    level: 'Intermediate',
    language: 'English',
    fullContent:
        "Today, I want to talk to you about the power of perseverance. Every single one of you in this room has the potential to achieve greatness. The difference between those who succeed and those who give up lies not in talent, not in luck, but in the relentless decision to keep moving forward. There will be days when the road seems too long, when the goal seems too far. But it is in those moments that your true character is forged. I have seen ordinary people achieve extraordinary things simply because they refused to quit. Your journey will not be easy. But I promise you — every challenge you overcome will make you stronger, wiser, and more capable than before. Believe in yourself. The world is waiting for what only you can offer.",
    tips: [
      'Speak from the heart, not just from the script',
      'Vary your volume and tone for emotional impact',
      'Make eye contact with different people in the audience',
      'Use strategic pauses to let powerful messages sink in',
    ],
  ),
  ScriptData(
    title: 'Keynote Address',
    description: 'Deliver a compelling keynote presentation',
    duration: '10 min',
    level: 'Advanced',
    language: 'English',
    fullContent:
        "Distinguished guests, colleagues, and friends — welcome. It is both an honor and a privilege to stand before you today. We gather at a pivotal moment, one that demands not just reflection, but bold action. Over the past decade, our industry has undergone transformative changes. The emergence of new technologies, shifting global dynamics, and evolving consumer expectations have redefined the rules of engagement. Yet amid all this change, one truth remains constant: the organizations and individuals that adapt, innovate, and lead with purpose are the ones that endure. Today, I will walk you through three critical pillars that I believe will define our success in the years ahead — innovation, collaboration, and resilience. Each pillar is not just a concept — it is a call to action.",
    tips: [
      'Rehearse multiple times with actual timing',
      'Memorize your opening and closing — these are most impactful',
      'Prepare for technical difficulties with backup plans',
      'Engage the audience with rhetorical questions',
    ],
  ),
];

// ─── Script Detail Page ────────────────────────────────────────────────────────

class ScriptDetailPage extends StatelessWidget {
  final ScriptData script;
  const ScriptDetailPage({super.key, required this.script});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Full Script',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 6),
                        ],
                      ),
                      child: Text(
                        script.fullContent,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.7,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTipsSection(),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3F7CF4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.mic,
                            color: Colors.white, size: 18),
                        label: const Text(
                          'Practice with this Script',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ScriptPracticePage(script: script),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
      color: const Color(0xFF3F7CF4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.chevron_left, color: Colors.white, size: 20),
                Text('Back',
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            script.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${script.duration} • ${script.level} • ${script.language}',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline,
                  size: 18, color: Color(0xFF3F7CF4)),
              SizedBox(width: 8),
              Text(
                'Tips',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F7CF4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...script.tips.map(
            (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '• $tip',
                style: const TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Script Practice Page ─────────────────────────────────────────────────────

enum PracticeStatus { ready, recording, paused }

class ScriptPracticePage extends StatefulWidget {
  final ScriptData script;
  const ScriptPracticePage({super.key, required this.script});

  @override
  State<ScriptPracticePage> createState() => _ScriptPracticePageState();
}

class _ScriptPracticePageState extends State<ScriptPracticePage> {
  PracticeStatus _status = PracticeStatus.ready;
  int _seconds = 0;
  Timer? _timer;

  void _toggleState() {
    setState(() {
      if (_status == PracticeStatus.ready ||
          _status == PracticeStatus.paused) {
        _status = PracticeStatus.recording;
        _timer = Timer.periodic(
          const Duration(seconds: 1),
          (t) => setState(() => _seconds++),
        );
      } else {
        _status = PracticeStatus.paused;
        _timer?.cancel();
      }
    });
  }

  String _formatTime(int s) {
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final sec = (s % 60).toString().padLeft(2, '0');
    return '$m:$sec';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  children: [
                    // ── Script Preview Card ──
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 8),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.script.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: [
                              _badge(
                                widget.script.level,
                                const Color(0xFFE6EEFF),
                                const Color(0xFF3F7CF4),
                              ),
                              _badge(
                                widget.script.language,
                                Colors.grey.shade100,
                                Colors.black54,
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            widget.script.fullContent,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black87,
                              height: 1.5,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // ── Record Button ──
                    GestureDetector(
                      onTap: _toggleState,
                      child: Container(
                        width: 112,
                        height: 112,
                        decoration: BoxDecoration(
                          color: _status == PracticeStatus.recording
                              ? Colors.red.shade100
                              : const Color(0xFFDCEAFD),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: _status == PracticeStatus.recording
                                  ? Colors.redAccent
                                  : const Color(0xFF3F7CF4),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _status == PracticeStatus.recording
                                  ? Icons.pause
                                  : Icons.mic,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Status Text ──
                    Text(
                      _status == PracticeStatus.ready
                          ? 'Ready to Record'
                          : _status == PracticeStatus.recording
                              ? 'Recording...'
                              : 'Paused',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),

                    // ── Timer ──
                    Text(
                      _formatTime(_seconds),
                      style: const TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3F7CF4),
                      ),
                    ),

                    const Spacer(),

                    // ── Finish Button (paused only) ──
                    if (_status == PracticeStatus.paused) ...[
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3F7CF4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SessionResultsPage(
                                script: widget.script,
                                duration: _formatTime(_seconds),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Finish & View Results',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ] else
                      const SizedBox(height: 52),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Back button ──
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.chevron_left,
                          color: Colors.black87, size: 20),
                      Text('Back',
                          style: TextStyle(
                              color: Colors.black87, fontSize: 14)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Script Practice',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.script.description,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
          Divider(
              height: 1, thickness: 1, color: Colors.grey.shade200),
        ],
      ),
    );
  }

  Widget _badge(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: textCol, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// ─── Session Results Page ─────────────────────────────────────────────────────

class SessionResultsPage extends StatelessWidget {
  final ScriptData script;
  final String duration;

  const SessionResultsPage({
    super.key,
    required this.script,
    required this.duration,
  });

  String _monthName(int m) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[m];
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateStr =
        '${_monthName(now.month)} ${now.day}, ${now.year} • $duration duration';

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: Column(
          children: [
            // ── Blue Header ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 22),
              color: const Color(0xFF3F7CF4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () =>
                        Navigator.popUntil(context, (r) => r.isFirst),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.chevron_left,
                            color: Colors.white, size: 20),
                        Text('Back to Home',
                            style: TextStyle(
                                color: Colors.white, fontSize: 14)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Session Results',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateStr,
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),

            // ── Scrollable Body ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                child: Column(
                  children: [
                    // ── Overall Score Card ──
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12, blurRadius: 8),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            '85',
                            style: TextStyle(
                              fontSize: 58,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3FBD7A),
                            ),
                          ),
                          const Text(
                            'Overall Score',
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDFF5E8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Excellent 🎉',
                              style: TextStyle(
                                color: Color(0xFF3FBD7A),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Performance Breakdown Card ──
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12, blurRadius: 8),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Performance Breakdown',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Pace
                          const _MetricRow(
                            icon: Icons.speed_outlined,
                            iconBg: Color(0xFFFFF3E0),
                            iconColor: Color(0xFFFF9800),
                            label: 'Pace',
                            score: 82,
                            scoreColor: Color(0xFFFF9800),
                            subtitle: '139 words per minute',
                            barColor: Color(0xFFFF9800),
                            feedback:
                                'Good pacing. Try to maintain consistency throughout.',
                          ),

                          Divider(
                              height: 28,
                              color: Colors.grey.shade100),

                          // Clarity
                          const _MetricRow(
                            icon: Icons.chat_bubble_outline,
                            iconBg: Color(0xFFE8F5E9),
                            iconColor: Color(0xFF3FBD7A),
                            label: 'Clarity',
                            score: 93,
                            scoreColor: Color(0xFF3FBD7A),
                            subtitle: '2 filler words detected',
                            barColor: Color(0xFF3FBD7A),
                            feedback:
                                'Minimal filler words. Watch for "um" and "uh".',
                          ),

                          Divider(
                              height: 28,
                              color: Colors.grey.shade100),

                          // Energy
                          const _MetricRow(
                            icon: Icons.bolt_outlined,
                            iconBg: Color(0xFFFFF8E1),
                            iconColor: Color(0xFFFFC107),
                            label: 'Energy',
                            score: 79,
                            scoreColor: Color(0xFFFFC107),
                            subtitle: 'Strong vocal projection',
                            barColor: Color(0xFFFFC107),
                            feedback: 'Good energy level.',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Practice Again ──
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3F7CF4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Practice Again',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── Back to Home ──
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () => Navigator.popUntil(
                            context, (r) => r.isFirst),
                        child: const Text(
                          'Back to Home',
                          style: TextStyle(
                            color: Color(0xFF1A1A2E),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF3F7CF4),
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.mic), label: 'Practice'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: 'Progress'),
        ],
      ),
    );
  }
}

// ─── Metric Row Widget ────────────────────────────────────────────────────────

class _MetricRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final int score;
  final Color scoreColor;
  final String subtitle;
  final Color barColor;
  final String feedback;

  const _MetricRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.score,
    required this.scoreColor,
    required this.subtitle,
    required this.barColor,
    required this.feedback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Icon Box
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            // Label + Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      Text(
                        '$score',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: scoreColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Progress Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: score / 100,
            backgroundColor: Colors.grey.shade100,
            color: barColor,
            minHeight: 7,
          ),
        ),
        const SizedBox(height: 7),
        // Feedback
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check, size: 13, color: barColor),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                feedback,
                style: const TextStyle(
                    fontSize: 11, color: Colors.black54),
              ),
            ),
          ],
        ),
      ],
    );
  }
}