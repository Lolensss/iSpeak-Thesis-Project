import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final VoidCallback? onBackToHome;

  const ResultPage({super.key, this.onBackToHome});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF2F4F7),
      child: SafeArea(
        bottom: true,
        child: Column(
          children: [
            _header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 120), // ✅ FIXED
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    _scoreCard(),
                    const SizedBox(height: 28),
                    _sectionTitle(),
                    const SizedBox(height: 14),
                    _metricCard(
                      icon: Icons.volume_up_outlined,
                      title: "Pace",
                      subtitle: "121 words per minute",
                      score: "82",
                      comment:
                          "✓ Good pacing. Try to maintain consistency throughout.",
                    ),
                    const SizedBox(height: 14),
                    _metricCard(
                      icon: Icons.chat_bubble_outline,
                      title: "Clarity",
                      subtitle: "0 filler words detected",
                      score: "98",
                      comment: "✓ Perfect! Zero filler words!",
                    ),
                    const SizedBox(height: 14),
                    _metricCard(
                      icon: Icons.flash_on_outlined,
                      title: "Energy",
                      subtitle: "Strong vocal projection",
                      score: "78",
                      comment: "✓ Good energy level.",
                    ),
                    const SizedBox(height: 28),
                    _primaryButton(),
                    const SizedBox(height: 14),
                    _secondaryButton(context),
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
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3F7CF4), Color(0xFF4F8DF7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Session Results",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "February 2, 2026 • 00:11 duration",
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
    return Transform.translate(
      offset: const Offset(0, -60),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 28),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 6),
            )
          ],
        ),
        child: Column(
          children: [
            const Text(
              "87",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F7CF4),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Overall Score",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 14),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFDFF5E8),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                "Great Performance! 🎉",
                style: TextStyle(
                  color: Color(0xFF1F8F4C),
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
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
    required String title,
    required String subtitle,
    required String score,
    required String comment,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(16),
        boxShadow:
            const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFE6EEFF),
                child: Icon(icon,
                    color: const Color(0xFF3F7CF4), size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Text(
                score,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F7CF4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: int.parse(score) / 100,
            backgroundColor: Colors.grey.shade300,
            color: const Color(0xFF3F7CF4),
            minHeight: 6,
            borderRadius: BorderRadius.circular(20),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              comment,
              style: const TextStyle(
                  fontSize: 12, color: Colors.grey),
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
          padding:
              const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {},
        child: const Text(
          "Practice Again",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.white),
        ),
      ),
    );
  }

  Widget _secondaryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side:
              const BorderSide(color: Color(0xFF3F7CF4)),
          padding:
              const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onBackToHome,
        child: const Text(
          "Back to Home",
          style: TextStyle(
              color: Color(0xFF3F7CF4),
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
