// x is player 1
const _ = require('lodash');

class TicTacToe {
  constructor(n = 3) {
    this.rowSize = n;
    this.board = _.range(1, n * n + 1);
    this.player2Turn = false;
  }

  checkBoard() {

  }

  toString() {
    let output = '';
    for (let i = 0; i < this.board.length; i++) {
      if (i + 1 % this.rowSize !== 0) {
        output += ` ${this.board[i]} |`;
      } else {
        output += `${this.board[i]} \n`;
      }
    }
    return output;
  }

  legalMove() {

  }

  placePiece(boardPosition) {

  }

  currentPlayerTurn() {
    return this.player2Turn ? '2' : '1';
  }
}

module.exports = TicTacToe;