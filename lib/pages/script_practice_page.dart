import 'dart:async';
import 'package:flutter/material.dart';

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
    fullContent: "Good morning everyone! My name is [Your Name], and I'm delighted to have this opportunity to introduce myself. I am currently working as a [Your Profession], and I have been passionate about [Your Interest] for the past [Number] years. What drives me every day is the opportunity to learn something new and contribute meaningfully to my field. I believe that effective communication is the cornerstone of success in any endeavor.",
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
    fullContent: "Magandang umaga sa inyong lahat! Ako si [Pangalan Mo], at natutuwa akong mayroon akong pagkakataong ipakilala ang aking sarili. Kasalukuyan akong nagtatrabaho bilang [Propesyon Mo], at matagal ko nang hilig ang [Interes Mo]. Ang nagtutulak sa akin araw-araw ay ang pagkakataong matuto ng bagong kaalaman at makapag-ambag nang makahulugan sa aking larangan. Sa aking libreng oras, mahilig akong [Libangan Mo], na tumutulong sa akin na mapanatili ang balanseng buhay.",
    tips: [
      'Practice reading the script out loud several times',
      'Focus on your pace - aim for 100-130 words per minute',
      'Use natural pauses at punctuation marks',
      'Emphasize key points with vocal variety',
    ],
  ),
];

class LearningResourcesPage extends StatelessWidget {
  const LearningResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildTabs(),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Choose a script to practice with",
                    style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500)),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: scriptLibrary.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) => _buildScriptCard(context, scriptLibrary[index]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF3F7CF4),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.chevron_left, color: Colors.white),
              SizedBox(width: 8),
              Text("Back", style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(height: 20),
          Text("Learning Resources",
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Improve your speaking skills", style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          _tabItem("Scripts", true),
          _tabItem("Challenges", false),
          _tabItem("Guided Tasks", false),
        ],
      ),
    );
  }

  Widget _tabItem(String label, bool active) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: active ? const Color(0xFF3F7CF4) : Colors.transparent,
            borderRadius: BorderRadius.circular(25)),
        child: Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: active ? Colors.white : Colors.black54, fontWeight: FontWeight.bold, fontSize: 13)),
      ),
    );
  }

  Widget _buildScriptCard(BuildContext context, ScriptData script) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ScriptDetailPage(script: script))),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(script.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 4),
            Text(script.description, style: const TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 12),
            Row(
              children: [
                _badge(Icons.access_time, script.duration, Colors.grey.shade600, Colors.grey.shade100),
                const SizedBox(width: 8),
                _badge(null, script.level, Colors.green, Colors.green.shade50),
                const SizedBox(width: 8),
                _badge(null, script.language, Colors.blueGrey, Colors.blueGrey.shade50),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _badge(IconData? icon, String text, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          if (icon != null) ...[Icon(icon, size: 14, color: textColor), const SizedBox(width: 4)],
          Text(text, style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      selectedItemColor: const Color(0xFF3F7CF4),
      currentIndex: 1,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Practice"),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Progress"),
      ],
    );
  }
}

class ScriptDetailPage extends StatelessWidget {
  final ScriptData script;
  const ScriptDetailPage({super.key, required this.script});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: Column(
          children: [
            _buildDetailHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Full Script", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Text(script.fullContent, style: const TextStyle(fontSize: 14, height: 1.6)),
                    ),
                    const SizedBox(height: 20),
                    _buildTipsSection(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3F7CF4),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ScriptPracticePage(script: script))),
                      child: const Text("Practice with this Script", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

  Widget _buildDetailHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF3F7CF4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Row(children: [Icon(Icons.chevron_left, color: Colors.white), Text("Back", style: TextStyle(color: Colors.white))]),
          ),
          const SizedBox(height: 12),
          Text(script.title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          Text("${script.duration} • ${script.level} • ${script.language}", style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTipsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [Icon(Icons.info_outline, size: 18, color: Color(0xFF3F7CF4)), SizedBox(width: 8), Text("Tips", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF3F7CF4)))]),
          const SizedBox(height: 8),
          ...script.tips.map((tip) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text("• $tip", style: const TextStyle(fontSize: 12, color: Colors.black87)),
          )),
        ],
      ),
    );
  }
}

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
      if (_status == PracticeStatus.ready || _status == PracticeStatus.paused) {
        _status = PracticeStatus.recording;
        _timer = Timer.periodic(const Duration(seconds: 1), (t) => setState(() => _seconds++));
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
  void dispose() { _timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.chevron_left, color: Colors.black),
        title: const Text("Script Practice", style: TextStyle(color: Colors.black, fontSize: 16)),
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Container(color: Colors.grey.shade200, height: 1)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Script Preview Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.script.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 4),
                  Row(children: [
                    _statusBadge(widget.script.level, Colors.blue.shade50, const Color(0xFF3F7CF4)),
                    const SizedBox(width: 8),
                    _statusBadge(widget.script.language, Colors.grey.shade100, Colors.black54),
                  ]),
                  const SizedBox(height: 16),
                  Text(widget.script.fullContent, maxLines: 6, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black87, height: 1.5)),
                ],
              ),
            ),
            const Spacer(),
            // Action Circle
            GestureDetector(
              onTap: _toggleState,
              child: Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  color: _status == PracticeStatus.recording ? Colors.red.shade100 : const Color(0xFFE3F2FD),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 70, height: 70,
                    decoration: BoxDecoration(color: _status == PracticeStatus.recording ? Colors.redAccent : const Color(0xFF3F7CF4), shape: BoxShape.circle),
                    child: Icon(_status == PracticeStatus.recording ? Icons.pause : Icons.mic, color: Colors.white, size: 35),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(_status == PracticeStatus.ready ? "Ready to Record" : _status == PracticeStatus.recording ? "Recording..." : "Paused", 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(_formatTime(_seconds), style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF3F7CF4))),
            const Spacer(),
            if (_status == PracticeStatus.paused)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3F7CF4), minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: () {}, // Navigate to Results
                child: const Text("Finish & View Results", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(String text, Color bg, Color textCol) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)), child: Text(text, style: TextStyle(color: textCol, fontSize: 10, fontWeight: FontWeight.bold)));
  }
}