const Board = require('./src/board');
const readline = require('readline');

const board = new Board();

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: true,
  prompt: `Player ${board.currentPlayerTurn} to play: >`
});

console.log(`
  Tic-Tac-Toe
  Type q to quit, h for help
  ${board.toString()}
  `);

rl.prompt();

rl.on('line', line => {
  if (line === 'q') {
    rl.close();
    return;
  }

  if (line === 'h') {
    console.log('You are beyond help');
    rl.prompt();
  } else if (Math.floor(+line) < 10 && Math.floor(+line) > 0) {
    if (board.legalMove(+line)) {
    } else {
      console.log('Illegal move, q to quit, h for help');
    }
  } else {
    console.log('Invalid command, q to quit, h for help');    
  }
  console.log(board.toString());
  rl.setPrompt(`Player ${board.currentPlayerTurn()} to play: >`);
  rl.prompt();
});