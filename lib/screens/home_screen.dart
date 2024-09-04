import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/game_provider.dart';
import '../providers/game_with_friend_provider.dart';
import '../providers/theme_provider.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final gameProvider = Provider.of<GameProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: themeProvider.isDarkMode
                ? [Colors.grey[900]!, Colors.grey[800]!]
                // : [Colors.deepPurple[100]!, Colors.deepPurple[200]!],
                : [Color(0xFFFFF3E2),Color(0xFFFFF3E2),],
                // : [Colors.deepPurple[100]!, Colors.deepPurple[200]!],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tic Tac Toe',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode ? Colors.white : Color(0xFFFBAB57),
                ),
              ).animate().fade().scale(),
              SizedBox(height: 50),
              _buildButton(context, 'Play with AI', () {
                gameProvider.resetGame();  // Reset the AI game state
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider.value(
                      value: gameProvider,  // Use AI game provider
                      child: GameScreen(isAIGame: true),
                    ),
                  ),
                );
              }),
              SizedBox(height: 20),
              _buildButton(context, 'Play with Friend', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => GameWithFriendProvider(),  // Use Friend game provider
                      child: GameScreen(isAIGame: false),
                    ),
                  ),
                );
              }),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      gameProvider.isBackgroundMusicPlaying ? Icons.music_note : Icons.music_off,
                      color: themeProvider.isDarkMode ? Colors.white : Color(0xFFFBAB57),
                    ),
                    onPressed: gameProvider.toggleBackgroundMusic,
                  ),
                  IconButton(
                    icon: Icon(
                      themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      color: themeProvider.isDarkMode ? Colors.white : Color(0xFFFBAB57),
                    ),
                    onPressed: themeProvider.toggleTheme,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
    ).animate().fade().scale();
  }
}
