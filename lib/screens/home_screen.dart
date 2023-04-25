import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:language_picker/language_picker_dialog.dart';
import 'package:language_picker/languages.dart';
import 'package:provider/provider.dart';
import 'package:riddle/providers/daily_login_provider.dart';
import 'package:riddle/providers/questions_language_provider.dart';
import 'package:riddle/screens/play_screen.dart';
import 'package:riddle/screens/settings_screen.dart';
import 'package:riddle/screens/store_screen.dart';
import 'package:riddle/screens/test_store.dart';
import 'package:riddle/widgets/daily_login_model_widget.dart';
import '../widgets/admob/banner_ads_widget.dart';
import '../widgets/appbar_actions_widget.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/home_title_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  Widget build(BuildContext context) {
    @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      final dailyLogin = Provider.of<DailyLoginProvider>(context);
      // Show the dialog if it is a new day
      if (dailyLogin.isNewDay) {
        final player = AudioPlayer();
        player.play(AssetSource('audio/newday1.mp3'));
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const DailyLoginScreen();
            },
          );
        });
        dailyLogin.login();
      }
    }

    didChangeDependencies();

    // It's sample code of Dialog Item.
    Widget buildDialogItem(Language language) => Row(
          children: <Widget>[
            Text(language.name),
            const SizedBox(width: 8.0),
            Flexible(child: Text("(${language.isoCode})"))
          ],
        );

    final languageProvider =
        Provider.of<QuestionsLanguageProvider>(context, listen: false);

    void openLanguagePickerDialog() {
      showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.orange),
            child: LanguagePickerDialog(
                titlePadding: const EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration:
                    const InputDecoration(hintText: 'Search...'),
                languages: [
                  Languages.english,
                  Languages.arabic,
                  Languages.bengali,
                  Languages.dutch,
                  Languages.french,
                  Languages.german,
                  Languages.greek,
                  Languages.gujarati,
                  Languages.hindi,
                  Languages.indonesian,
                  Languages.irish,
                  Languages.italian,
                  Languages.japanese,
                  Languages.korean,
                  Languages.latin,
                  Languages.marathi,
                  Languages.nepali,
                  Languages.persian,
                  Languages.polish,
                  Languages.portuguese,
                  Languages.russian,
                  Languages.spanish,
                  Languages.tamil,
                  Languages.telugu,
                  Languages.thai,
                  Languages.turkish,
                  Languages.ukrainian,
                  Languages.urdu,
                  Languages.vietnamese,
                ],
                isSearchable: true,
                title: const Text("Select your quiz language"),
                onValuePicked: (Language language) => setState(() {
                      languageProvider.changeLanguage(language.isoCode);
                      languageProvider.changeLanguageName(language.name);
                    }),
                itemBuilder: buildDialogItem)),
      );
    }

    return Scaffold(
      bottomNavigationBar: kIsWeb
          ? null
          : Container(
              child: !hasInternet && languageProvider.language != "en"
                  ? const Text(
                      "You will need internet connection \n to translate the Quizzes.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w200))
                  : const BannerAdWidget()),
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          'Home',
          style: TextStyle(
            fontFamily: 'Righteous',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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
              ]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32.0),
              const HomeTitleText(title: "India"),
              const SizedBox(height: 32.0),
              const CustomButton(
                label: 'Play',
                icon: Icons.play_arrow,
                route: PlayScreen(),
              ),
              const SizedBox(height: 16.0),
              const CustomButton(
                label: 'Store',
                icon: Icons.shop,
                route: StoreScreen(),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const SettingsScreen();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.deepPurple,
                  backgroundColor: Colors.white,
                  minimumSize: const Size(200.0, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 5.0,
                ),
                icon: const Icon(Icons.settings),
                label: const Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton.icon(
                onPressed: openLanguagePickerDialog,
                style: ElevatedButton.styleFrom(
                  foregroundColor:
                      !hasInternet && languageProvider.language != "en"
                          ? Colors.white
                          : Colors.deepPurple,
                  backgroundColor:
                      !hasInternet && languageProvider.language != "en"
                          ? Colors.red
                          : Colors.white,
                  minimumSize: const Size(200.0, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 5.0,
                ),
                icon: const Icon(Icons.translate),
                label: Text(
                  !hasInternet && languageProvider.language != "en"
                      ? "No Internet"
                      : "[${languageProvider.languageName}]",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
