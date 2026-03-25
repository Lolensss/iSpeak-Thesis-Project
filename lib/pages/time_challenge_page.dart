import 'dart:async';
import 'package:flutter/material.dart';


enum ChallengeDifficulty { beginner, intermediate, advanced }

class ChallengeData {
  final String title;
  final String description;
  final int durationSeconds;
  final ChallengeDifficulty difficulty;
  final String targetWpm;
  final String prompt;
  final List<String> tips;

  const ChallengeData({
    required this.title,
    required this.description,
    required this.durationSeconds,
    required this.difficulty,
    required this.targetWpm,
    required this.prompt,
    required this.tips,
  });
}

const quickPitchChallenge = ChallengeData(
  title: 'Quick Pitch',
  description: 'Deliver a 60-second elevator pitch about yourself',
  durationSeconds: 60,
  difficulty: ChallengeDifficulty.beginner,
  targetWpm: '120-140 WPM',
  prompt:
      "Imagine you're in an elevator with someone important. You have 60 seconds to introduce yourself and make a memorable impression. Go!",
  tips: [
    'Start strong with your name',
    'Mention your key strength',
    'End with a call to action',
  ],
);

const impromptuTopicChallenge = ChallengeData(
  title: 'Impromptu Topic',
  description: 'Speak for 2 minutes on a random topic',
  durationSeconds: 120,
  difficulty: ChallengeDifficulty.intermediate,
  targetWpm: '130-150 WPM',
  prompt:
      'You will be given a random topic. Speak about it for 2 minutes without stopping. Stay confident and keep a steady pace.',
  tips: [
    'Take 5 seconds to gather your thoughts',
    'Structure: Point → Reason → Example',
    'Avoid long silences — keep talking',
  ],
);

const clarityChallengeData = ChallengeData(
  title: 'Clarity Challenge',
  description: 'Speak for 90 seconds without filler words',
  durationSeconds: 90,
  difficulty: ChallengeDifficulty.intermediate,
  targetWpm: '120-150 WPM',
  prompt:
      'Describe your ideal weekend in detail. Speak clearly and avoid filler words like "um", "uh", "like", and "you know".',
  tips: [
    'Pause instead of saying "um"',
    'Slow down when you feel lost',
    'Practice short, complete sentences',
  ],
);

const speedRoundChallenge = ChallengeData(
  title: 'Speed Round',
  description: 'Deliver a 3-minute presentation at optimal pace',
  durationSeconds: 180,
  difficulty: ChallengeDifficulty.advanced,
  targetWpm: '140+ WPM',
  prompt:
      'Present on a topic of your choice for exactly 3 minutes. Aim for a brisk, energetic delivery while keeping articulation sharp.',
  tips: [
    'Maintain high energy throughout',
    'Use transitions to keep momentum',
    'Breathe deeply between sections',
  ],
);

const bilingualSwitchChallenge = ChallengeData(
  title: 'Bilingual Switch',
  description: 'Present in English and Filipino',
  durationSeconds: 120,
  difficulty: ChallengeDifficulty.advanced,
  targetWpm: '120-150 WPM',
  prompt:
      'Introduce yourself first in English, then switch to Filipino (Tagalog). Use natural transitions and keep the same confident tone.',
  tips: [
    'Use smooth transition phrases',
    'Keep the same pacing in both languages',
    'Maintain eye contact throughout',
  ],
);


enum _PracticeState { ready, recording, paused }

class TimedChallengePage extends StatefulWidget {
  final ChallengeData challenge;
  final VoidCallback? onBack;
  final VoidCallback? onBackToHome;

  const TimedChallengePage({
    super.key,
    this.challenge = quickPitchChallenge,
    this.onBack,
    this.onBackToHome,
  });

  @override
  State<TimedChallengePage> createState() => _TimedChallengePageState();
}

class _TimedChallengePageState extends State<TimedChallengePage> {
  _PracticeState _state = _PracticeState.ready;
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isFil = false;

  double _paceWpm = 120;
  int _fillerCount = 0;
  double _energyLevel = 0.85;


  int get _remainingSeconds =>
      (widget.challenge.durationSeconds - _elapsedSeconds)
          .clamp(0, widget.challenge.durationSeconds);

  void _start() {
    _timer?.cancel();
    if (_state == _PracticeState.ready) {
      _elapsedSeconds = 0;
      _paceWpm = 120;
      _fillerCount = 0;
      _energyLevel = 0.85;
    }
    setState(() => _state = _PracticeState.recording);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        _elapsedSeconds++;
        // Simulate gradually shifting metrics
        if (_elapsedSeconds >= 5) _paceWpm = 125;
        if (_elapsedSeconds == 7) _fillerCount = 1;
        if (_elapsedSeconds == 9) _fillerCount = 3;
      });
      // Auto-finish when countdown hits zero
      if (_elapsedSeconds >= widget.challenge.durationSeconds) {
        _timer?.cancel();
        _goToResults();
      }
    });
  }

  void _pause() {
    _timer?.cancel();
    setState(() => _state = _PracticeState.paused);
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _state = _PracticeState.ready;
      _elapsedSeconds = 0;
      _fillerCount = 0;
      _paceWpm = 120;
    });
  }

  void _goToResults() {
    _timer?.cancel();
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChallengeResultsPage(
          challenge: widget.challenge,
          durationSeconds: _elapsedSeconds,
          fillerCount: _fillerCount,
          paceWpm: _paceWpm.toInt(),
          onPracticeAgain: () {
            Navigator.of(context).pop();
            _reset();
          },
          onBackToHome: () {
            Navigator.of(context).pop();
            widget.onBackToHome?.call();
            widget.onBack?.call();
          },
        ),
      ),
    );
  }

  String _fmt(int s) {
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final sec = (s % 60).toString().padLeft(2, '0');
    return '$m:$sec';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // ── Difficulty helpers 
  String get _diffLabel {
    switch (widget.challenge.difficulty) {
      case ChallengeDifficulty.beginner:     return 'Beginner';
      case ChallengeDifficulty.intermediate: return 'Intermediate';
      case ChallengeDifficulty.advanced:     return 'Advanced';
    }
  }

  Color get _diffColor {
    switch (widget.challenge.difficulty) {
      case ChallengeDifficulty.beginner:     return const Color(0xFF3FBD7A);
      case ChallengeDifficulty.intermediate: return const Color(0xFF3F7CF4);
      case ChallengeDifficulty.advanced:     return const Color(0xFFB45FD4);
    }
  }

  Color get _diffBg {
    switch (widget.challenge.difficulty) {
      case ChallengeDifficulty.beginner:     return const Color(0xFFDFF5E8);
      case ChallengeDifficulty.intermediate: return const Color(0xFFE6EEFF);
      case ChallengeDifficulty.advanced:     return const Color(0xFFF3E6FF);
    }
  }

  String get _durationLabel {
    final s = widget.challenge.durationSeconds;
    return s < 60 ? '${s}s limit' : '${s ~/ 60}min limit';
  }

 
  @override
  Widget build(BuildContext context) {
    final isReady     = _state == _PracticeState.ready;
    final isRecording = _state == _PracticeState.recording;
    final isPaused    = _state == _PracticeState.paused;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: DefaultTextStyle.merge(
        style: const TextStyle(decoration: TextDecoration.none),
        child: SafeArea(
          bottom: true,
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
                  child: Column(
                    children: [
                     
                      if (isReady) ...[
                        _buildChallengeInfoCard(),
                        const SizedBox(height: 16),
                      ],

                      
                      if (!isReady) ...[
                        _buildLanguageBanner(),
                        const SizedBox(height: 14),
                      ],

                      
                      _buildRecordCard(isReady, isRecording, isPaused),

                      
                      if (isRecording || isPaused) ...[
                        const SizedBox(height: 14),
                        _buildMetricCard(
                          icon: Icons.volume_up,
                          iconColor: const Color(0xFF3F7CF4),
                          iconBg: const Color(0xFFE6EEFF),
                          title: 'Pace',
                          value: '${_paceWpm.toInt()} WPM',
                          valueColor: const Color(0xFF3F7CF4),
                          progress: (_paceWpm / 150).clamp(0.0, 1.0),
                          barColor: const Color(0xFF3F7CF4),
                          helper:
                              'Optimal pace range: ${widget.challenge.targetWpm}',
                        ),
                        const SizedBox(height: 10),
                        _buildMetricCard(
                          icon: Icons.chat_bubble_outline,
                          iconColor: const Color(0xFF3F7CF4),
                          iconBg: const Color(0xFFE6EEFF),
                          title: 'Clarity',
                          value: _fillerCount == 0
                              ? '0 fillers'
                              : '$_fillerCount fillers',
                          valueColor: _fillerCount == 0
                              ? const Color(0xFF3F7CF4)
                              : const Color(0xFFF4913F),
                          progress: _fillerCount == 0
                              ? 1.0
                              : (1 - _fillerCount / 10).clamp(0.0, 1.0),
                          barColor: _fillerCount == 0
                              ? const Color(0xFF3F7CF4)
                              : const Color(0xFFF4913F),
                          helper: _fillerCount == 0
                              ? 'Perfect! No filler words'
                              : 'Detected: "um" (1), "uh" (2)',
                        ),
                        const SizedBox(height: 10),
                        _buildMetricCard(
                          icon: Icons.bolt,
                          iconColor: const Color(0xFF3F7CF4),
                          iconBg: const Color(0xFFE6EEFF),
                          title: 'Energy',
                          value: 'High',
                          valueColor: const Color(0xFF3F7CF4),
                          progress: _energyLevel,
                          barColor: const Color(0xFF3F7CF4),
                          helper: 'Strong vocal projection',
                        ),
                      ],

                      
                      if (isPaused) ...[
                        const SizedBox(height: 20),
                        _buildFinishButton(),
                      ],

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      color: const Color(0xFF3F7CF4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _timer?.cancel();
                  widget.onBack?.call();
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chevron_left, color: Colors.white, size: 20),
                    Text('Back',
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ),
              const Spacer(),
              _buildLangToggle(),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Timed Challenge',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            widget.challenge.description,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildLangToggle() {
    return Container(
      height: 30,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _langChip('EN', !_isFil),
          const SizedBox(width: 2),
          _langChip('FIL', _isFil),
        ],
      ),
    );
  }

  Widget _langChip(String label, bool active) {
    return GestureDetector(
      onTap: () => setState(() => _isFil = label == 'FIL'),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: active ? Colors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  // ── Language banner 
  Widget _buildLanguageBanner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.language,
          size: 14,
          color: _isFil ? Colors.orange : const Color(0xFF3F7CF4),
        ),
        const SizedBox(width: 6),
        Text(
          _isFil ? 'Practicing in Filipino' : 'Practicing in English',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _isFil ? Colors.orange : const Color(0xFF3F7CF4),
          ),
        ),
      ],
    );
  }

  // ── Challenge info card 
  Widget _buildChallengeInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF3F7CF4),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.challenge.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _pill(
                bg: Colors.white.withOpacity(0.20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.access_time,
                        color: Colors.white70, size: 12),
                    const SizedBox(width: 4),
                    Text(_durationLabel,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 11)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _pill(
                bg: _diffBg,
                child: Text(
                  _diffLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _diffColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Prompt box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Prompt:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.challenge.prompt,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF3A3A50),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Tips:',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          ...widget.challenge.tips.map(
            (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: CircleAvatar(
                        radius: 3, backgroundColor: Colors.white70),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      tip,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 13, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill({required Color bg, required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: child,
    );
  }

  // ── Record card 
  Widget _buildRecordCard(bool isReady, bool isRecording, bool isPaused) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (isReady) {
                _start();
              } else if (isRecording) {
                _pause();
              } else {
                _start(); // resume
              }
            },
            child: CircleAvatar(
              radius: 42,
              backgroundColor:
                  isRecording ? Colors.redAccent : const Color(0xFF3F7CF4),
              child: Icon(
                isRecording ? Icons.pause : Icons.mic,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            isReady
                ? 'Ready to Record'
                : isRecording
                    ? 'Recording...'
                    : 'Paused',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 6),
          // Elapsed timer (blue, large)
          Text(
            _fmt(_elapsedSeconds),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3F7CF4),
            ),
          ),
          // Time remaining (dark, smaller) — shown when active
          if (!isReady) ...[
            const SizedBox(height: 6),
            const Text('Time Remaining',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 2),
            Text(
              _fmt(_remainingSeconds),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ],
          if (isPaused) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: _reset,
              child: const Text('Reset Session',
                  style: TextStyle(color: Colors.grey)),
            ),
          ],
        ],
      ),
    );
  }

  // ── Metric card ────────────────────────────────────────────
  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String value,
    required Color valueColor,
    required double progress,
    required Color barColor,
    required String helper,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 10),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF1A1A2E))),
              const Spacer(),
              Text(value,
                  style: TextStyle(
                      color: valueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(barColor),
              minHeight: 7,
            ),
          ),
          const SizedBox(height: 6),
          Text(helper,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  // ── Finish button ──────────────────────────────────────────
  Widget _buildFinishButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3F7CF4),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        onPressed: _goToResults,
        child: const Text(
          'Finish & View Results',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  SESSION RESULTS PAGE
// ═════════════════════════════════════════════════════════════
class ChallengeResultsPage extends StatelessWidget {
  final ChallengeData challenge;
  final int durationSeconds;
  final int fillerCount;
  final int paceWpm;
  final VoidCallback? onPracticeAgain;
  final VoidCallback? onBackToHome;

  const ChallengeResultsPage({
    super.key,
    required this.challenge,
    required this.durationSeconds,
    this.fillerCount = 3,
    this.paceWpm = 125,
    this.onPracticeAgain,
    this.onBackToHome,
  });

  String _fmt(int s) {
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final sec = (s % 60).toString().padLeft(2, '0');
    return '$m:$sec';
  }

  String get _dateStr {
    final now = DateTime.now();
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }

  // Compute scores from session data
  int get _paceScore {
    // Full score if within optimal range
    return (paceWpm >= 120 && paceWpm <= 150) ? 90 : 75;
  }

  int get _clarityScore => fillerCount == 0 ? 100 : (90 - fillerCount * 3).clamp(60, 100);
  int get _energyScore  => 82;
  int get _overallScore => ((_paceScore + _clarityScore + _energyScore) / 3).round();

  String get _overallLabel {
    if (_overallScore >= 90) return 'Excellent 🎉';
    if (_overallScore >= 75) return 'Great Job 👍';
    return 'Keep Practicing 💪';
  }

  Color get _overallColor {
    if (_overallScore >= 90) return const Color(0xFF3FBD7A);
    if (_overallScore >= 75) return const Color(0xFF3F7CF4);
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: DefaultTextStyle.merge(
        style: const TextStyle(decoration: TextDecoration.none),
        child: SafeArea(
          bottom: true,
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildOverallScoreCard(),
                      const SizedBox(height: 20),
                      const Text(
                        'Performance Breakdown',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildBreakdownCard(
                        icon: Icons.volume_up,
                        iconColor: const Color(0xFF3F7CF4),
                        iconBg: const Color(0xFFE6EEFF),
                        title: 'Pace',
                        subtitle: '$paceWpm words per minute',
                        score: _paceScore,
                        scoreColor: const Color(0xFF3FBD7A),
                        progress: _paceScore / 100,
                        barColor: const Color(0xFF3FBD7A),
                        feedback:
                            'Good pacing. Try to maintain consistency throughout.',
                      ),
                      const SizedBox(height: 10),
                      _buildBreakdownCard(
                        icon: Icons.chat_bubble_outline,
                        iconColor: const Color(0xFF3F7CF4),
                        iconBg: const Color(0xFFE6EEFF),
                        title: 'Clarity',
                        subtitle: fillerCount == 0
                            ? 'No filler words detected'
                            : '$fillerCount filler words detected',
                        score: _clarityScore,
                        scoreColor: const Color(0xFF3FBD7A),
                        progress: _clarityScore / 100,
                        barColor: const Color(0xFF3FBD7A),
                        feedback: fillerCount == 0
                            ? 'Perfect! No filler words at all.'
                            : 'Minimal filler words. Watch for "um" and "uh".',
                      ),
                      const SizedBox(height: 10),
                      _buildBreakdownCard(
                        icon: Icons.bolt,
                        iconColor: Colors.orange,
                        iconBg: const Color(0xFFFFF3E0),
                        title: 'Energy',
                        subtitle: 'Strong vocal projection',
                        score: _energyScore,
                        scoreColor: Colors.orange,
                        progress: _energyScore / 100,
                        barColor: Colors.orange,
                        feedback:
                            'Excellent energy! Your enthusiasm is engaging.',
                      ),
                      const SizedBox(height: 24),
                      _buildPrimaryButton('Practice Again', onPracticeAgain),
                      const SizedBox(height: 10),
                      _buildSecondaryButton('Back to Home', onBackToHome),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
      color: const Color(0xFF3F7CF4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onBackToHome,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.chevron_left, color: Colors.white, size: 20),
                Text('Back to Home',
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Session Results',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '$_dateStr • ${_fmt(durationSeconds)} duration',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallScoreCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        children: [
          Text(
            '$_overallScore',
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: _overallColor,
              height: 1,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Overall Score',
            style: TextStyle(fontSize: 15, color: Color(0xFF666680)),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: _overallColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _overallLabel,
              style: TextStyle(
                color: _overallColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required int score,
    required Color scoreColor,
    required double progress,
    required Color barColor,
    required String feedback,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    color: iconBg, borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF1A1A2E))),
                    Text(subtitle,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Text('$score',
                  style: TextStyle(
                      color: scoreColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(barColor),
              minHeight: 7,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.check, size: 13, color: barColor),
              const SizedBox(width: 4),
              Expanded(
                child: Text(feedback,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(String label, VoidCallback? onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3F7CF4),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        onPressed: onTap,
        child: Text(label,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildSecondaryButton(String label, VoidCallback? onTap) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: Color(0xFF3F7CF4), width: 1.5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onTap,
        child: Text(label,
            style: const TextStyle(
                color: Color(0xFF3F7CF4),
                fontSize: 15,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}

