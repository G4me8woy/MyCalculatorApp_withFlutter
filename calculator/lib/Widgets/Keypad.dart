import 'package:calculator/model/Button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Keypad extends StatelessWidget {
  final BuildContext inheritContext;

  Keypad(this.inheritContext);

  @override
  Widget build(inheritContext) {
    return Container(
      color: Color.fromRGBO(55, 67, 83, 1),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton("C", inheritContext),
                buildButton("(", inheritContext),
                buildButton(")", inheritContext),
                buildButton("/", inheritContext),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton("7", inheritContext),
                buildButton("8", inheritContext),
                buildButton("9", inheritContext),
                buildButton("*", inheritContext),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton("4", inheritContext),
                buildButton("5", inheritContext),
                buildButton("6", inheritContext),
                buildButton("-", inheritContext),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton("1", inheritContext),
                buildButton("2", inheritContext),
                buildButton("3", inheritContext),
                buildButton("+", inheritContext),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton("0", inheritContext),
                buildButton(".", inheritContext),
                buildButton("del", inheritContext),
                buildButton("=", inheritContext),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
