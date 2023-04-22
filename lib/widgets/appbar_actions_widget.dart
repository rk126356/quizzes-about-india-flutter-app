import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riddle/providers/daily_login_provider.dart';

import '../providers/coin_provider.dart';
import '../providers/heart_provider.dart';
import '../providers/utils_provider.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heart = Provider.of<HeartProvider>(context, listen: false);
    final dailyLogin = Provider.of<DailyLoginProvider>(context, listen: false);

    if (dailyLogin.timeLeft.inSeconds == 1) {
      heart.addHeart(5);
      dailyLogin.login();
    }

    final music = Provider.of<UtilsProvider>(context, listen: false);
    Future<void> delayedFunction() async {
      await Future.delayed(const Duration(seconds: 3));

      if (music.isMusicTurnedOn && music.isQuizMusicPlaying) {
        music.stopMusic();
        music.playQuizMusic();
        print("Quiz music is playing");
      } else if (music.isMusicTurnedOn && !music.isQuizMusicPlaying) {
        print("Music is turned on");
        music.playMusic();
      } else if (!music.isMusicTurnedOn) {
        print("Music is turned off");
        music.stopMusic();
        music.stopQuizMusic();
      }
    }

    delayedFunction();

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          _buildCoinBox(context),
          const SizedBox(width: 4),
          _buildHeartBox(context),
        ],
      ),
    );
  }

  Widget _buildCoinBox(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final coinsprovider = Provider.of<CoinProvider>(context, listen: false);
        coinsprovider.addCoin(100);
      },
      child: Container(
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.purpleAccent],
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.monetization_on,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Consumer<CoinProvider>(
              builder: (context, coinProvider, child) {
                return Text(
                  '${coinProvider.coins}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              },
            ),
            const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeartBox(BuildContext context) {
    final dailyLogin = Provider.of<DailyLoginProvider>(context);
    return GestureDetector(
      onTap: () {
        final heartProvider =
            Provider.of<HeartProvider>(context, listen: false);
        heartProvider.addHeart(1);
      },
      child: Container(
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.purpleAccent],
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Consumer<HeartProvider>(
              builder: (context, heartProvider, child) {
                return Text(
                  '${heartProvider.hearts}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              },
            ),
            const Icon(
              Icons.add,
              color: Colors.white,
            ),
            Text(
              '${dailyLogin.timeLeft.inHours.remainder(24).toString().padLeft(2, '0')}:${(dailyLogin.timeLeft.inMinutes.remainder(60)).toString().padLeft(2, '0')}:${(dailyLogin.timeLeft.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
