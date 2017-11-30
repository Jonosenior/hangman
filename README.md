# Hangman project

This is player vs computer game of [Hangman](https://en.wikipedia.org/wiki/Hangman_(game)) for the command line. The computer chooses a random word of between 5 and 12 letters from the dictionary, which the player has 12 turns to guess.

Skills practiced:
 - File serialization using YAML to save and load game progress.
 - String manipulation.
 - Object-Oriented Programming to create a working game.

![Hangman_screenshot](hangman_cropped.png?raw=true)

It's a project from [The Odin Project](https://www.theodinproject.com/courses/ruby-programming/lessons/advanced-building-blocks).


## Installation

Open your terminal/command line. Navigate to the directory where you want this project to live. Type:
```
$ git clone https://github.com/Jonosenior/hangman.git
$ cd hangman/lib
$ ruby hangman.rb
```

## Post-project thoughts

The game itself was relatively straightforward to build, and I finished it in an afternoon.

Developing the save/load functions was harder, and the challenge pushed me to learn more about YAML and data serialization.

# Todo

  - Create an AI which could guess a word inputted by the player. The strategy would look something like:
    - Use a list of the most frequent letters in the English language for the first few guesses: ( e-t-a-o-i-n-s-h-r-d-l-u ).
    - Iterate through a dictionary file and remove those words which are incompatible with the currently-known correct and incorrect letters and letter positions.
