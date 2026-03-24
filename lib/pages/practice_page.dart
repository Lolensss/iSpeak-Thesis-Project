import 'dart:async';
import 'package:flutter/material.dart';

enum PracticeState { ready, recording, paused }

class PracticePage extends StatefulWidget {
  final VoidCallback? onFinish;

  const PracticePage({super.key, this.onFinish});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  PracticeState _state = PracticeState.ready;
  Timer? _timer;
  int _seconds = 0;

  /// START RECORDING
  void _start() {
    _timer?.cancel(); 

    if (_state == PracticeState.ready) {
      _seconds = 0; 
    }

    setState(() {
      _state = PracticeState.recording;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _seconds++);
    });
  }

  /// PAUSE RECORDING
  void _pause() {
    _timer?.cancel();
    setState(() => _state = PracticeState.paused);
  }

  /// RESET SESSION COMPLETELY
  void _reset() {
    _timer?.cancel();
    setState(() {
      _state = PracticeState.ready;
      _seconds = 0;
    });
  }

  String get _time {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF0F0F3),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              const SizedBox(height: 6),
              const Text(
                'Practice Session',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Record your speech to get instant feedback',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 16),

              _recordCard(),
              const SizedBox(height: 16),

              if (_state != PracticeState.ready)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        _metricCard('Pace', '121 WPM', 0.75, Colors.blue),
                        const SizedBox(height: 12),
                        _metricCard('Clarity', '0 fillers', 0.6, Colors.cyan),
                        const SizedBox(height: 12),
                        _metricCard('Energy', 'Good', 0.8, Colors.green),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                )
              else
                const Spacer(),

              if (_state == PracticeState.paused && _seconds >= 10)
                _finishButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recordCard() {
    final isRecording = _state == PracticeState.recording;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10)
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (_state == PracticeState.ready) {
                _start();
              } else if (_state == PracticeState.recording) {
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
            _state == PracticeState.ready
                ? 'Ready to Record'
                : _state == PracticeState.recording
                    ? 'Recording...'
                    : 'Paused',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            _time,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3F7CF4),
            ),
          ),

          /// 🔥 RESET BUTTON (for testing)
          if (_state == PracticeState.paused)
            TextButton(
              onPressed: _reset,
              child: const Text("Reset Session"),
            ),
        ],
      ),
    );
  }

  Widget _metricCard(
      String title, String value, double progress, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(value,
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 8,
          ),
          const SizedBox(height: 6),
          Text(
            _helperForMetric(title),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  String _helperForMetric(String title) {
    switch (title) {
      case 'Pace':
        return 'Optimal pace range: 120-150 WPM';
      case 'Clarity':
        return 'Perfect! No filler words';
      case 'Energy':
        return 'Try to project more energy';
      default:
        return '';
    }
  }

  Widget _finishButton() {
    return SafeArea(
      top: false,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3F7CF4),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            _timer?.cancel();
            widget.onFinish?.call();
          },
          child: const Text(
            'Finish & View Results',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}