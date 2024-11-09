import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:productivity_app/helpers/colors_helper.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:audioplayers/audioplayers.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  final int _duration = 25 * 60;
  final CountDownController _controller = CountDownController();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource('timer.mp3'));
  }

  Future<void> _stopSound() async {
    await _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pomodoro',
          style: GoogleFonts.syne(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.barColor),
        ),
        backgroundColor: const Color(0xffF9F9F9),
      ),
      backgroundColor: const Color(0xffF9F9F9),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 30,
          ),
          _button(
            icon: Icons.play_arrow,
            onPressed: () async {
              _controller.start();
              await _playSound(); // Mainkan suara ketika timer dimulai
            },
          ),
          const SizedBox(
            width: 10,
          ),
          _button(
            icon: Icons.pause,
            onPressed: () async {
              _controller.pause();
              await _stopSound(); // Hentikan suara ketika timer dijeda
            },
          ),
          const SizedBox(
            width: 10,
          ),
          _button(
            icon: Icons.rectangle,
            onPressed: () async {
              _controller.resume();
              await _playSound(); // Mainkan suara kembali ketika timer dilanjutkan
            },
          ),
          const SizedBox(
            width: 10,
          ),
          _button(
            icon: Icons.refresh,
            onPressed: () {
              _stopSound();
              _controller.restart(duration: _duration);
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Center(
              child: CircularCountDownTimer(
                duration: _duration,
                initialDuration: 0,
                controller: _controller,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                ringColor: Colors.grey[300]!,
                fillColor: AppColors.titleColor,
                backgroundColor: AppColors.barColor,
                strokeWidth: 20.0,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                  fontSize: 33.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textFormat: CountdownTextFormat.MM_SS,
                isReverse: true,
                isReverseAnimation: true,
                isTimerTextShown: true,
                autoStart: false,
                onStart: () {
                  debugPrint('Countdown Started');
                },
                onComplete: () {
                  debugPrint('Countdown Ended');
                  _stopSound(); // Hentikan suara ketika timer selesai
                },
                onChange: (String timeStamp) {
                  debugPrint('Countdown Changed $timeStamp');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button({VoidCallback? onPressed, required IconData icon}) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.barColor),
        ),
        onPressed: onPressed,
        child: Icon(
          icon,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
