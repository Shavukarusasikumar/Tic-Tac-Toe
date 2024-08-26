import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/game_provider.dart';
import 'game_cell.dart';

class GameBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final board = gameProvider.gameState.board;

    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          final row = index ~/ 3;
          final col = index % 3;
          return GameCell(
            cellState: board[row][col],
            onTap: () => gameProvider.makeMove(row, col),
            isNewMove: gameProvider.isNewMove(row, col),
          ).animate().fade(duration: 300.ms).scale(delay: 300.ms);
        },
      ),
    ).animate()
      .fade(duration: 600.ms)
      .scale(delay: 300.ms)
      .shimmer(delay: 600.ms, duration: 1800.ms);
  }
}