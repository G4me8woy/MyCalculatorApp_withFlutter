import 'package:flutter/foundation.dart';

class AnswerLogic extends ChangeNotifier {
  String equation;

  var eqnParts = new List();
  var steps = new List();
  var braceInd = new List();

  String answer = "...";

  int oppNum = 0;
  int eqnStartInd;
  int eqnEndInd;

  void calcProcess(String givenEquation) {
    eqnParts = [];
    braceInd = [];
    steps = [];
    oppNum = 0;
    eqnStartInd = null;
    eqnEndInd = null;
    this.equation = givenEquation;
    try {
      bracketPrecedence();
    } catch (e) {
      answer = "...";
      notifyListeners();
    }

    // if (braceInd.length > 0) {
    //   for (var indexGroup in braceInd) {
    //     eqnParts = [];
    //     eqnLog(indexGroup.startInd, indexGroup.closeInd);
    //   }
    // } else {
    //   eqnLog(0, equation.length - 1);
    // }
  }

  void bracketPrecedence() {
    for (int eqnInd = 0; eqnInd < equation.length; eqnInd++) {
      eqnParts = [];
      oppNum = 0;
      if (eqnInd == equation.length - 1 && equation[eqnInd] != ")") {
        eqnStartInd = 0;
        eqnEndInd = equation.length - 1;
        eqnLog(eqnStartInd, eqnEndInd);
        answer = equation;
        notifyListeners();
        break;
      }

      if (equation[eqnInd] != ")") continue;
      // int searchInd;
      // if (braceInd.length == 0)
      //   searchInd = eqnInd - 2;
      // else
      //   searchInd = braceInd[braceInd.length - 1].startInd - 2;
      for (int searchInd = eqnInd - 2; searchInd >= 0; searchInd--) {
        if (equation[searchInd] == "(") {
          // openBracketInd = searchInd;
          // closeBracketInd = eqnInd;

          eqnStartInd = searchInd + 1;
          eqnEndInd = eqnInd - 1;

          eqnLog(eqnStartInd, eqnEndInd);

          eqnInd = 0;
          break;
        }
      }
    }
  }

  void eqnLog(int startInd, int endInd) {
    String tempNum;

    for (var i = startInd; i <= endInd; i++) {
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
      if (i == endInd) {
        eqnParts.add(tempNum);
        tempNum = null;
      }
    }
    eqnPrecedence();
  }

  void eqnPrecedence() {
    for (int a = 1; a <= oppNum; a++) {
      for (var b = 0; b < eqnParts.length - 1; b++) {
        switch (eqnParts[b]) {
          case "/":
            compute(eqnParts[b], b);
            break;
          case "*":
            compute(eqnParts[b], b);
            break;
          case "+":
            compute(eqnParts[b], b);
            break;
          case "-":
            compute(eqnParts[b], b);
            break;
        }
        // b = 0;
      }
    }
  }

  void compute(String opp, int oppInd) {
    num num1 = decimalCheck(eqnParts[oppInd - 1]);

    num num2 = decimalCheck(eqnParts[oppInd + 1]);

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

    eqnPartsUpdate(oppInd, result);
    equationUpate(result);
    stepsUpdate();
  }

  num decimalCheck(String number) {
    if (number.contains("."))
      return double.parse(number);
    else
      return int.parse(number);
  }

  void eqnPartsUpdate(int oppInd, num result) {
    eqnParts.replaceRange(oppInd - 1, oppInd + 2, [result.toString()]);
  }

  void equationUpate(num result) {
    // equation.replaceRange(
    //     braceInd[0].startInd - 1, braceInd[0].closeInd + 2, result.toString());

    if (eqnStartInd == 0)
      equation = result.toString();
    else
      equation = equation.substring(0, eqnStartInd - 1) +
          result.toString() +
          equation.substring(eqnEndInd + 2, equation.length);

    // braceInd.removeAt(0);
  }

  void stepsUpdate() {
    steps.add(equation);
  }
}

class BraceIndex {
  int startInd;
  int closeInd;
}
