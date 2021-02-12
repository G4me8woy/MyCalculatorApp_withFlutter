import 'package:flutter/foundation.dart';

class AnswerLogic {
  String equation;
  int oppNum = 0;
  var eqnParts = new List();

  void calcProcess(String equation) {
    this.equation = equation;
    bracketPrecedence();
    eqnPrecedence();
  }

  void bracketPrecedence() {
    for (int eqnInd = 0; eqnInd < equation.length; eqnInd++) {
      if (equation[eqnInd] != ")") continue;

      for (int searchInd = eqnInd - 2; searchInd >= 0; searchInd--) {
        if (equation[searchInd] == "(") eqnLog(searchInd, eqnInd);
      }
    }
  }

  void eqnLog(int startInd, int endInd) {
    String tempNum;

    for (var i = 0; i < equation.length; i++) {
      //if an opperator (except (-)) is detected
      if (equation[i] == "+" || equation[i] == "*" || equation[i] == "/") {
        eqnParts.add(tempNum);
        eqnParts.add(equation[i]);
        tempNum = null;
        oppNum++;
      }
      //if negative
      else if (equation[i] == "-") {
        if (equation[i - 1] == "+" ||
            equation[i - 1] == "*" ||
            equation[i - 1] == "/") {
          if (tempNum == null)
            tempNum = equation[i];
          else
            tempNum += equation[i];
        } //if - operator
        else {
          eqnParts.add(tempNum);
          eqnParts.add(equation[i]);
          tempNum = null;
          oppNum++;
        }
      } // number
      else {
        if (tempNum == null)
          tempNum = equation[i];
        else
          tempNum += equation[i];
      }

      //on last num char
      if (i == equation.length - 1) {
        eqnParts.add(tempNum);
        tempNum = null;
      }
    }
  }

  void eqnPrecedence() {
    for (int a = 1; a <= oppNum; a++) {
      for (var b = 0; b < equation.length; b++) {
        switch (equation[b]) {
          case "/":
            compute(equation[b], b);
            break;
          case "*":
            compute(equation[b], b);
            break;
          case "+":
            compute(equation[b], b);
            break;
          case "-":
            compute(equation[b], b);
            break;
          default:
        }
      }
    }
  }

  void compute(String opp, int oppInd) {
    num num1 = decimalCheck(equation[oppInd - 1]);

    num num2 = decimalCheck(equation[oppInd - 1]);

    num result;

    switch (opp) {
      case "/":
        result = num1 / num2;
        break;
      case "*":
        result = num1 * num2;
        break;
      case "+":
        result = num1 + num2;
        break;
      case "-":
        result = num1 - num2;
        break;
    }

    eqnUpdate(oppInd, result);
  }

  num decimalCheck(String number) {
    if (number.contains("."))
      return double.parse(number);
    else
      return int.parse(number);
  }

  void eqnUpdate(int oppInd, num result) {
    eqnParts.replaceRange(oppInd - 1, oppInd + 2, [result]);
  }
}
