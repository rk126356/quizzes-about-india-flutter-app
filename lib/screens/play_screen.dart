import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riddle/providers/questions_language_provider.dart';
import 'package:riddle/screens/home_screen.dart';
import '../models/questions_model.dart';
import '../providers/utils_provider.dart';
import '../widgets/admob/banner_ads_widget.dart';
import '../widgets/appbar_actions_widget.dart';
import '../widgets/level_grid_view_widget.dart';
import '../providers/questions_provider.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  bool hasInternet = false;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      hasInternet = connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final music = Provider.of<UtilsProvider>(context, listen: false);

    if (music.isMusicTurnedOn && music.isQuizMusicPlaying) {
      music.quizMusicPlayingFalse();
      music.stopQuizMusic();
    }

    final questionsProvider = Provider.of<QuestionsProvider>(context);
    final List<List<Question>> levels =
        questionsProvider.questionsList.map((question) => [question]).toList();
    final language = Provider.of<QuestionsLanguageProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: kIsWeb
            ? null
            : Container(
                child: !hasInternet && language.language != "en"
                    ? const Text(
                        "You will need internet connection \n to translate the Quizzes.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w200))
                    : const BannerAdWidget()),
        appBar: AppBar(
          title: const Text('Play'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
            child: const Icon(Icons.arrow_back),
          ),
          actions: const [
            AppBarActions(),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orange,
                Colors.white,
                Colors.green,
              ],
            ),
          ),
          child: LevelGridView(levels: levels),
        ),
      ),
    );
  }
}
