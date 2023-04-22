import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/utils_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 400,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(16),
                border: const Border(
                  top: BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                  bottom: BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                  left: BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                  right: BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                ),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.settings,
                    color: Colors.red,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Consumer<UtilsProvider>(
                    builder: (context, music, _) => SwitchListTile(
                      title: const Text('Music'),
                      value: music.isMusicTurnedOn,
                      onChanged: (value) {
                        if (value) {
                          music.musicPlayingTrue();
                        } else {
                          music.musicPlayingFalse();
                        }
                      },
                    ),
                  ),
                  Consumer<UtilsProvider>(
                    builder: (context, music, _) => SwitchListTile(
                      title: const Text('Sounds'),
                      value: music.isSounsPlaying,
                      onChanged: (value) {
                        if (value) {
                          music.switchIsSounsPlaying();
                        } else {
                          music.switchIsSounsPlaying();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          // navigate to privacy policy screen
                        },
                        child: const Text(
                          'About',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {
                          // navigate to terms of service screen
                        },
                        child: const Text(
                          'Contact',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          // navigate to privacy policy screen
                        },
                        child: const Text(
                          'Privacy Policy',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {
                          // navigate to terms of service screen
                        },
                        child: const Text(
                          'Terms',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
