import 'package:flutter/material.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';

class FavouriteMusicPlayer extends StatefulWidget {
  const FavouriteMusicPlayer({super.key});

  @override
  State<FavouriteMusicPlayer> createState() => _FavouriteMusicPlayerState();
}

class _FavouriteMusicPlayerState extends State<FavouriteMusicPlayer> {
  late AudioPlayer player;
  bool playing = false;
  bool hover = false;
  Duration elapsedDuration = const Duration(minutes: 0, seconds: 0);
  final maxDuration = const Duration(minutes: 1, seconds: 2);
  final samples = <double>[
    -911204,
    627187,
    -183295,
    939259,
    -44275,
    941837,
    -779848,
    46169,
    -405216,
    936781,
    -856234,
    413263,
    -886333,
    396784,
    -578151,
    548398,
    -774037,
    491376,
    -526159,
    353199,
    -417492,
    666080,
    -874848,
    806608,
    -884596,
    39922,
    -935178,
    952221,
    -485001,
    132703,
    -334041,
    324461,
    -639294,
    328531,
    -112714,
    970755,
    -318491,
    745140,
    -277736,
    446132,
    -885291,
    653224,
    -255905,
    182271,
    -485486,
    600490,
    -126338,
    253448,
    -672303,
    559681,
    -439121,
    285364,
    -37979,
    812524,
    -699304,
    404861,
    -819307,
    336775,
    -474380,
    882063,
    -692510,
    221753,
    -396919,
    859813,
    -227695,
    736581,
    -138423,
    154305,
    -877565,
    542957,
    -611618,
    126487,
    -316925,
    646467,
    -540096,
    718303,
    -669299,
    27321,
    -623201,
    76410,
    -226010,
    11014,
    -821516,
    773377,
    -144677,
    740225,
    -567778,
    700833,
    -503590,
    142674,
    -918044,
    563456,
    -562393,
    416239,
    -72364,
    627654,
    -385349,
    441146,
    -489345,
    626478
  ];

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setAsset('assets/music/favourite.mp3');
    player.setLoopMode(LoopMode.all);
    player.positionStream.listen((event) {
      if (mounted) {
        setState(() {
          elapsedDuration = event;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                if (playing) {
                  player.pause();
                } else {
                  player.play();
                }
                playing = !playing;
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (e) => setState(() => hover = true),
                onExit: (e) => setState(() => hover = false),
                child: Tooltip(
                  message:
                      playing ? "Click to pause" : "Click me and enjoy reading",
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn,
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: hover ? Colors.lightBlue : Colors.blue,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Icon(
                        playing
                            ? Icons.pause_circle_filled_rounded
                            : Icons.play_arrow_rounded,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(10),
            PolygonWaveform(
              samples: samples,
              height: 45,
              width: 200,
              maxDuration: maxDuration,
              elapsedDuration: elapsedDuration
                          .compareTo(const Duration(minutes: 1, seconds: 2)) >
                      0
                  ? maxDuration
                  : elapsedDuration,
              activeColor: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }
}
