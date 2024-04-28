


/*import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with TickerProviderStateMixin {
  bool isBreathTest = false;
  int breathCount = 0;
  Duration inhaleDuration = const Duration(seconds: 2);
  Duration holdDuration = const Duration(seconds: 1);
  Duration exhaleDuration = const Duration(seconds: 2);
  Timer? breathTimer;
  AnimationController? _animationController;
  Animation<double>? _animation;

  bool isMeditating = false;
  String currentMeditation = 'Select Meditation';
  final List<String> meditationOptions = [
    'Select Meditation',
    'Ocean Waves',
    'Forest Sounds',
    'Calming Music',
  ];
  AudioPlayer _audioPlayer = AudioPlayer();

  void startBreathTest() {
    setState(() {
      isBreathTest = true;
      breathCount = 0;
    });
    _animationController = AnimationController(
      duration: inhaleDuration + holdDuration + exhaleDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        setState(() {});
      });
    _animationController!.repeat(reverse: true);
    breathTimer = Timer.periodic(inhaleDuration + holdDuration + exhaleDuration,
        (timer) {
      setState(() {
        breathCount++;
      });
    });
  }

  void stopBreathTest() {
    setState(() {
      isBreathTest = false;
      breathTimer?.cancel();
      _animationController?.dispose();
    });
  }

  void startMeditation(String meditation) {
    setState(() {
      isMeditating = true;
      currentMeditation = meditation;
    });
    if (meditation != 'Select Meditation') {
      playAudio(meditation);
    }
  }

  void stopMeditation() {
    setState(() {
      isMeditating = false;
      currentMeditation = 'Select Meditation';
    });
    stopAudio();
  }

  Future<void> playAudio(String meditation) async {
    try {
      String audioPath;
      switch (meditation) {
        case 'Ocean Waves':
          audioPath = 'assets/audio/ocean_waves.mp3';
          break;
        case 'Forest Sounds':
          audioPath = 'assets/audio/forest_sounds.mp3';
          break;
        case 'Calming Music':
          audioPath = 'assets/audio/calming_music.mp3';
          break;
        default:
          return;
      }
      await _audioPlayer.setSource(AssetSource(audioPath));
      await _audioPlayer.resume();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  @override
  void dispose() {
    stopAudio();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relax Your Mind & Body'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isBreathTest) ...[
              Text(
                breathCount % 3 == 0
                    ? 'Inhale...'
                    : breathCount % 3 == 1
                        ? 'Hold...'
                        : 'Exhale...',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: breathCount % 3 == 0
                      ? Colors.green
                      : breathCount % 3 == 1
                          ? Colors.orange
                          : Colors.red,
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: CircularProgressIndicator(
                  value: _animation?.value,
                  strokeWidth: 10,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    breathCount % 3 == 0
                        ? Colors.green
                        : breathCount % 3 == 1
                            ? Colors.orange
                            : Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: isBreathTest ? stopBreathTest : startBreathTest,
                child: Text(isBreathTest ? 'Stop Breath Test' : 'Start Breath Test'),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: startBreathTest,
                child: const Text('Take a Breath Test'),
              ),
            ],
            SizedBox(height: 32),
            DropdownButton<String>(
              value: currentMeditation,
              items: meditationOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newMeditation) {
                if (newMeditation != null) {
                  if (isMeditating) {
                    stopMeditation();
                  }
                  startMeditation(newMeditation);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'dart:math';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with TickerProviderStateMixin {
      final audio2 =Audioplayer();
audio2.play(AssetSource('your mp3 or wav file here');
  bool isBreathTest = false;
  int breathCount = 0;
  Duration inhaleDuration = const Duration(seconds: 2);
  Duration holdDuration = const Duration(seconds: 1);
  Duration exhaleDuration = const Duration(seconds: 2);
  Timer? breathTimer;
  AnimationController? _animationController;
  Animation<double>? _animation;

  bool isMeditating = false;
  String currentMeditation = 'Select Meditation';
  final List<String> meditationOptions = [
    'Select Meditation',
    'Ocean Waves',
    'Forest Sounds',
    'Calming Music',
  ];
  AudioPlayer _audioPlayer = AudioPlayer();
  AudioCache _audioCache = AudioCache();

  final List<String> positiveAffirmations = [
    'You are strong and capable.',
    'You have the power to create positive change.',
    'Believe in yourself and your abilities.',
    'You are worthy of love and happiness.',
    'Embrace the present moment and let go of worries.',
    'Your journey is unique and beautiful.',
    'You have the resilience to overcome any challenge.',
    'Surround yourself with positivity and support.',
  ];

  void startBreathTest() {
    setState(() {
      isBreathTest = true;
      breathCount = 0;
    });
    _animationController = AnimationController(
      duration: inhaleDuration + holdDuration + exhaleDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        setState(() {});
      });
    _animationController!.repeat(reverse: true);
    breathTimer = Timer.periodic(inhaleDuration + holdDuration + exhaleDuration,
        (timer) {
      setState(() {
        breathCount++;
      });
    });
    playPositiveAffirmation();
  }

  void stopBreathTest() {
    setState(() {
      isBreathTest = false;
      breathTimer?.cancel();
      _animationController?.dispose();
    });
  }

  void startMeditation(String meditation) {
    setState(() {
      isMeditating = true;
      currentMeditation = meditation;
    });
    if (meditation != 'Select Meditation') {
      playAudio(meditation);
    }
  }

  void stopMeditation() {
    setState(() {
      isMeditating = false;
      currentMeditation = 'Select Meditation';
    });
    stopAudio();
  }

  Future<void> playAudio(String meditation) async {
    try {
      String audioPath;
      switch (meditation) {
        case 'Ocean Waves':
          audioPath = 'assets/audio/ocean_waves.mp3';
          break;
        case 'Forest Sounds':
          audioPath = 'assets/audio/forest_sounds.mp3';
          break;
        case 'Calming Music':
          audioPath = 'assets/audio/calming_music.mp3';
          break;
        default:
          return;
      }
      //await _audioCache.(audioPath);
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  void playPositiveAffirmation() {
    final random = Random();
    final affirmation =
        positiveAffirmations[random.nextInt(positiveAffirmations.length)];
    //_audioCache.Res('affirmations/$affirmation.mp3');
  }

  @override
  void dispose() {
    stopAudio();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relax Your Mind & Body'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isBreathTest) ...[
              Text(
                breathCount % 3 == 0
                    ? 'Inhale...'
                    : breathCount % 3 == 1
                        ? 'Hold...'
                        : 'Exhale...',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: breathCount % 3 == 0
                      ? Colors.green
                      : breathCount % 3 == 1
                          ? Colors.orange
                          : Colors.red,
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: CircularProgressIndicator(
                  value: _animation?.value,
                  strokeWidth: 10,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    breathCount % 3 == 0
                        ? Colors.green
                        : breathCount % 3 == 1
                            ? Colors.orange
                            : Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: isBreathTest ? stopBreathTest : startBreathTest,
                child: Text(
                    isBreathTest ? 'Stop Breath Test' : 'Start Breath Test'),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: startBreathTest,
                child: const Text('Take a Breath Test'),
              ),
            ],
            SizedBox(height: 32),
            DropdownButton<String>(
              value: currentMeditation,
              items: meditationOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newMeditation) {
                if (newMeditation != null) {
                  if (isMeditating) {
                    stopMeditation();
                  }
                  startMeditation(newMeditation);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}*/