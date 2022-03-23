import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_wordle/domain.dart';
import 'package:flutter_wordle/widgets/tile.dart';

class Board extends StatelessWidget {
  final List<GlobalKey<AnimatorWidgetState>> _keys;

  final Context _context;
  final int _rowLength;

  const Board(this._context, this._rowLength, this._keys, {Key? key}) : super(key: key);

  List<Widget> _buildTiles() {
    final rows = <Widget>[];
    var board = _context.board;

    var i = 0;
    for (var x = 0; x < board.length / _rowLength; x++) {
      final cells = <Widget>[];
      for (var y = 0; y < _rowLength; y++) {
        cells.add(Tile(board[i].value, board[i].color));
        i++;
      }
      rows.add(Shake(
          key: _keys[x],
          preferences: const AnimationPreferences(
            magnitude: 0.7, 
            duration: Duration(milliseconds: 700),
            autoPlay: AnimationPlayStates.None),
          child: Flex(
            children: cells,
            direction: Axis.horizontal,
          )));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 350,
        height: 420,
        child: Stack(alignment: Alignment.center, children: [
          Column(children: _buildTiles()),
          if (_context.message.isNotEmpty) ...[
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      _context.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )),
            )
          ]
        ]));
  }
}
