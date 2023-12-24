import 'package:flutter/material.dart';

class Constants {
  final Color purple = const Color.fromARGB(255, 143, 22, 230);
  final Color darkPurple = const Color.fromARGB(255, 41, 22, 52);
  final Color lightPurple = const Color.fromARGB(255, 203, 178, 227);
  final Color anotherPurple = const Color.fromARGB(255, 203, 120, 227);
  final Color lightPurple2 = const Color.fromARGB(255, 171, 124, 224);
  final Color grey = Colors.grey;

  final linearGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 149, 70, 205),
      Color.fromARGB(255, 203, 120, 227),
    ],
  );
  final linearGradient2 = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color.fromARGB(255, 207, 178, 244),
      const Color.fromARGB(255, 171, 124, 224),
    ],
  );
}
