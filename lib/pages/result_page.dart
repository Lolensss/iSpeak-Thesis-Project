import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final VoidCallback? onBackToHome;
  final VoidCallback? onPracticeAgain;

  const ResultPage({super.key, this.onBackToHome, this.onPracticeAgain});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF2F4F7),
      child: SafeArea(
        bottom: true,
        child: Column(
          children: [
              SizedBox(
                height: 240, // header (180) + overlap (60)
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _header(),
                    Positioned(
                      bottom: 0,
                      left: 20,
                      right: 20,
                      child: _scoreCard(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      _sectionTitle(),
                    const SizedBox(height: 14),
                    _metricCard(
                      icon: Icons.volume_up_outlined,
                      iconColor: const Color(0xFF26B5A0),
                      iconBg: const Color(0xFFD6F5F0),
                      title: "Pace",
                      subtitle: "126 words per minute",
                      score: "92",
                      scoreColor: const Color(0xFF3F7CF4),
                      progressColor: const Color(0xFF3FBD7A),
                      comment:
                          "✓ Good pacing. Try to maintain consistency throughout.",
                    ),
                    const SizedBox(height: 14),
                    _metricCard(
                      icon: Icons.chat_bubble_outline,
                      iconColor: const Color(0xFF26B5A0),
                      iconBg: const Color(0xFFD6F5F0),
                      title: "Clarity",
                      subtitle: "1 filler words detected",
                      score: "94",
                      scoreColor: const Color(0xFF3F7CF4),
                      progressColor: const Color(0xFF3FBD7A),
                      comment:
                          '✓ Minimal filler words. Watch for "um" and "uh".',
                    ),
                    const SizedBox(height: 14),
                    _metricCard(
                      icon: Icons.flash_on_outlined,
                      iconColor: const Color(0xFFF5A623),
                      iconBg: const Color(0xFFFFF3DC),
                      title: "Energy",
                      subtitle: "Strong vocal projection",
                      score: "72",
                      scoreColor: const Color(0xFFF5A623),
                      progressColor: const Color(0xFFF5A623),
                      comment: "✓ Good energy level.",
                    ),
                    const SizedBox(height: 28),
                    _primaryButton(),
                    const SizedBox(height: 14),
                    _secondaryButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      height: 180,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3F7CF4), Color(0xFF4F8DF7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onBackToHome,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.chevron_left, color: Colors.white, size: 18),
                Text(
                  "Back to Home",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Session Results",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "February 26, 2026 • 00:10 duration",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _scoreCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "87",
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3FBD7A),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Overall Score",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFFDFF5E8),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              "Excellent 🎉",
              style: TextStyle(
                color: Color(0xFF1F8F4C),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Performance Breakdown",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _metricCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required String score,
    required Color scoreColor,
    required Color progressColor,
    required String comment,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: iconBg,
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                score,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: scoreColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: int.parse(score) / 100,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(progressColor),
              minHeight: 7,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              comment,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _primaryButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3F7CF4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        onPressed: onPracticeAgain,
        child: const Text(
          "Practice Again",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _secondaryButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF3F7CF4), width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onBackToHome,
        child: const Text(
          "Back to Home",
          style: TextStyle(
            color: Color(0xFF3F7CF4),
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}