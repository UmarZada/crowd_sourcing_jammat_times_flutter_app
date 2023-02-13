import 'package:flutter/material.dart';
import 'package:time_to_pray/Screens/home/quran/juz_detail_screen.dart';

class JuzScreen extends StatefulWidget {
  const JuzScreen({super.key});

  @override
  State<JuzScreen> createState() => _JuzScreenState();
}

class _JuzScreenState extends State<JuzScreen> {
  static const juzNames = [
    'آلم',
    'سَيَقُولُ',
    'تِلْكَ ٱلْرُّسُلُ',
    'لَنْ  تَنَالُو',
    'وَٱلْمُحْصَنَاتُ',
    'لَا يُحِبُّ ٱللهُ',
    'وَإِذَا سَمِعُوا',
    'وَلَوْ أَنَّنَا',
    'قَالَ ٱلْمَلَأُ',
    'وَٱعْلَمُواْ',
    'يَعْتَذِرُونَ',
    'وَمَا مِنْ دَآبَّةٍ',
    'وَمَا أُبَرِّئُ',
    'رُبَمَا',
    'سُبْحَانَ ٱلَّذِى',
    'قَالَ أَلَمْ',
    'ٱقْتَرَبَ لِلْنَّاس',
    'قَدْ أَفْلَحَ',
    'وَقَالَ ٱلَّذِينَ',
    'أَمَّنْ خَلَقَ',
    'أُتْلُ مَاأُوْحِیَ',
    'وَمَنْ يَّقْنُتْ',
    'وَمَآ لي',
    'فَمَنْ أَظْلَمُ',
    'إِلَيْهِ يُرَدُّ',
    'حم',
    'قَالَ فَمَا خَطْبُكُم',
    'قَدْ سَمِعَ ٱللهُ',
    'تَبَارَكَ ٱلَّذِى',
    'عَمَّ',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: juzNames.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => JuzDetailScreen(
                      juzNumber: index + 1,
                    )));
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                juzNames[index],
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
