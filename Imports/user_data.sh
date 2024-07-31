#!/bin/bash
apt-get update
apt-get install -y dos2unix

# Kopiere das Tic-Tac-Toe-Skript
cat << 'SCRIPT' > /home/ubuntu/tictactoe.sh
#!/bin/bash

# Tic-Tac-Toe Spiel für Bash

# Initialisiere das Spielfeld
board=(. . . . . . . . .)

# Funktion zum Anzeigen des Spielfelds
function print_board {
  echo " ${board[0]} | ${board[1]} | ${board[2]} "
  echo "---|---|---"
  echo " ${board[3]} | ${board[4]} | ${board[5]} "
  echo "---|---|---"
  echo " ${board[6]} | ${board[7]} | ${board[8]} "
}

# Funktion zum Überprüfen, ob ein Spieler gewonnen hat
function check_winner {
  for i in 0 3 6; do
    if [[ "${board[$i]}" != "." && "${board[$i]}" == "${board[$i+1]}" && "${board[$i]}" == "${board[$i+2]}" ]]; then
      echo "Spieler ${board[$i]} gewinnt!"
      exit
    fi
  done

  for i in 0 1 2; do
    if [[ "${board[$i]}" != "." && "${board[$i]}" == "${board[$i+3]}" && "${board[$i]}" == "${board[$i+6]}" ]]; then
      echo "Spieler ${board[$i]} gewinnt!"
      exit
    fi
  done

  if [[ "${board[0]}" != "." && "${board[0]}" == "${board[4]}" && "${board[0]}" == "${board[8]}" ]]; then
    echo "Spieler ${board[0]} gewinnt!"
    exit
  fi

  if [[ "${board[2]}" != "." && "${board[2]}" == "${board[4]}" && "${board[2]}" == "${board[6]}" ]]; then
    echo "Spieler ${board[2]} gewinnt!"
    exit
  fi
}

# Funktion zum Überprüfen, ob das Spiel unentschieden ist
function check_draw {
  for i in "${board[@]}"; do
    if [[ "$i" == "." ]]; then
      return
    fi
  done
  echo "Unentschieden!"
  exit
}

# Hauptspielschleife
player="X"
while true; do
  print_board
  echo "Spieler $player ist am Zug. Wähle eine Position (1-9):"
  read -r position

  if ! [[ "$position" =~ ^[1-9]$ ]]; then
    echo "Ungültige Eingabe. Bitte wähle eine Zahl zwischen 1 und 9."
    continue
  fi

  index=$((position - 1))
  if [[ "${board[$index]}" != "." ]]; then
    echo "Position bereits belegt. Bitte wähle eine andere Position."
    continue
  fi

  board[$index]=$player
  check_winner
  check_draw

  if [[ "$player" == "X" ]]; then
    player="O"
  else
    player="X"
  fi
done

SCRIPT

# Konvertiere das Skript ins Unix-Format und mache es ausführbar
dos2unix /home/ubuntu/tictactoe.sh
chmod +x /home/ubuntu/tictactoe.sh

# Füge das Tic-Tac-Toe-Skript zur .bashrc hinzu, um es beim Login zu starten
echo 'bash /home/ubuntu/tictactoe.sh' >> /home/ubuntu/.bashrc
