import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tictactoe/models/game_state.dart';
import '../providers/game_provider.dart';
import '../widgets/game_board.dart';
import '../widgets/player_icon.dart';
import '../utils/quotes.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A237E), Color(0xFF3949AB), Color(0xFF5C6BC0)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeader(context),
              GameBoard(),
              _buildStatusText(gameProvider),
              _buildControlRow(context, gameProvider),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'AI Tic Tac Toe',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(offset: Offset(2, 2), blurRadius: 3, color: Colors.black38),
          ],
        ),
      ).animate().fadeIn(duration: 600.ms).slide(),
    );
  }

  Widget _buildStatusText(GameProvider gameProvider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        _getStatusText(gameProvider.gameState.status),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(offset: Offset(1, 1), blurRadius: 2, color: Colors.black38),
          ],
        ),
      ).animate().fade().scale(),
    );
  }

  Widget _buildControlRow(BuildContext context, GameProvider gameProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PlayerIcon(isAI: false),
        _buildNewGameButton(context, gameProvider),
        _buildSoundToggleButton(gameProvider),
        PlayerIcon(isAI: true),
      ],
    ).animate().fadeIn(duration: 600.ms).slide();
  }

  Widget _buildNewGameButton(BuildContext context, GameProvider gameProvider) {
    return ElevatedButton(
      onPressed: gameProvider.resetGame,
      child: Text('New Game', style: TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        primary: Colors.amber,
        onPrimary: Colors.deepPurple,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ).animate()
      .fade(duration: 300.ms)
      .scale(delay: 300.ms)
      .shimmer(delay: 600.ms, duration: 1800.ms);
  }

Widget _buildSoundToggleButton(GameProvider gameProvider) {
  return IconButton(
    icon: Icon(
      gameProvider.isSoundEnabled ? Icons.volume_up : Icons.volume_off,
      color: Colors.white,
      size: 30,
    ),
    onPressed: gameProvider.toggleSound,
  ).animate()
    .fade(duration: 300.ms)
    .scale(delay: 300.ms);
}


  String _getStatusText(GameStatus status) {
    switch (status) {
      case GameStatus.playing:
        return 'Game in progress';
      case GameStatus.playerWin:
        return 'You win! 🎉';
      case GameStatus.aiWin:
        return getRandomQuote();
    }
  }
}