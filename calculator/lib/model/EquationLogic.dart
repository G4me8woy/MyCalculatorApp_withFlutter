import 'package:flutter/material.dart';

class EquationLogic extends ChangeNotifier {
  String displayEquation = "0";
  String lastChar;

  int openBrackets = 0;
  int negTermStartIndex = 0;

  num answer = 0;

  var numberProperties = new List();

  void equationUpdate(String input) {
    if (lastChar == null) {
      firstCharHandler(input);
    } else {
      switch (input) {
        case "+":
          oppHandler(input);
          break;
        case "-":
          oppHandler(input);
          break;
        case "*":
          oppHandler(input);
          break;
        case "/":
          oppHandler(input);
          break;
        case ".":
          decimalHandler();
          break;
        case "(":
          bracketManager(input);
          break;
        case ")":
          bracketManager(input);
          break;
        case "C":
          clear();
          break;
        case "del":
          delete();
          break;
        case "=":
          for (var obj in numberProperties) {
            print(
                "isNegative: ${obj.isNegative}   isDecimal: ${obj.isDecimal}");
          }
          break;
        default:
          displayEquation += input;
      }
    }
    // if(displayEquation.length == 1)
    //   lastChar =

    //lastChar at start before updating = null
    //i want it to update then

    //but lastchar on clear is also = null
    //i dont want it to update then

    //what's the diff between the two occurences
    //input

    if (input != "C") lastChar = displayEquation[displayEquation.length - 1];

    //! AnswerLogic();
    notifyListeners();
  }

  void firstCharHandler(String input) {
    print("firstCharHandler run");

    numberProperties.add(new NumberProperty());

    switch (input) {
      case "*":
        break;
      case "/":
        break;
      case ")":
        break;
      case "del":
        break;
      case "C":
        break;
      case "=":
        break;
      case "+":
        displayEquation = "+";
        break;
      case "-":
        negate();
        break;
      case "(":
        displayEquation = "(";
        openBrackets++;
        break;
      case ".":
        displayEquation = "0.";
        numberProperties[numberProperties.length - 1].isDecimal = true;
        break;
      default:
        displayEquation = input;
    }
  }

  void termReset(String opperator) {
    if (numberProperties[numberProperties.length - 1].isNegative &&
        lastChar != ")")
      negGrouping(opperator);
    else if (lastChar == "." && opperator == "(")
      displayEquation += "0*(";
    else if (lastChar == ".")
      displayEquation += "0$opperator";
    else
      displayEquation += opperator;

    numberProperties.add(new NumberProperty());
  }

  void negate() {
    if (displayEquation == "0") {
      negTermStartIndex = 0;
      displayEquation = "-";
      numberProperties[numberProperties.length - 1].isNegative = true;
    } else {
      negTermStartIndex = displayEquation.length;
      displayEquation += "-";
      numberProperties[numberProperties.length - 1].isNegative = true;
    }
  }

  void decimate() {
    if (lastChar == "+" ||
        lastChar == "-" ||
        lastChar == "*" ||
        lastChar == "/" ||
        lastChar == "(") {
      displayEquation += "0.";
      numberProperties[numberProperties.length - 1].isDecimal = true;
    } else if (lastChar == ")") {
      displayEquation += "*0.";
      numberProperties[numberProperties.length - 1].isDecimal = true;
    } else if (!numberProperties[numberProperties.length - 1].isDecimal) {
      displayEquation += ".";
      numberProperties[numberProperties.length - 1].isDecimal = true;
    }
  }

  void bracketManager(String bracket) {
    if (bracket == "(") {
      termReset("(");
      openBrackets++;
    }
    // bracket == )
    else if (bracket == ")") {
      if (openBrackets > 0 && lastChar != "(") {
        displayEquation += ")";
        openBrackets--;
      }
    }
  }

  void clear() {
    displayEquation = "0";
    lastChar = null;
    openBrackets = 0;
    numberProperties = [];
    answer = 0;
    negTermStartIndex = 0;
  }

  void delete() {
    if (displayEquation.length == 1) {
      clear();
    } else {
      switch (lastChar) {
        case ".":
          numberProperties[numberProperties.length - 1].isDecimal = false;
          reduce();
          break;
        case "-":
          if (numberProperties[numberProperties.length - 1].isNegative == true)
            numberProperties[numberProperties.length - 1].isNegative = false;
          //on opperator
          else
            numberProperties.removeLast();
          reduce();
          break;
        case "+":
          numberProperties.removeLast();
          reduce();
          break;
        case "*":
          numberProperties.removeLast();
          reduce();
          break;
        case "/":
          numberProperties.removeLast();
          reduce();
          break;
        default:
          reduce();
      }
    }
  }

  void reduce() {
    displayEquation = displayEquation.substring(0, displayEquation.length - 1);
  }

  void oppHandler(String opp) {
    if (opp == "-") {
      switch (lastChar) {
        case "+":
          negate();
          break;
        case "-":
          if (!numberProperties[numberProperties.length - 1].isNegative)
            negate();
          break;
        case "*":
          negate();
          break;
        case "/":
          negate();
          break;
        case "(":
          negate();
          break;
        //break
        case ")":
          termReset(opp);
          break;
        case ".":
          termReset(opp);
          break;
        default:
          termReset(opp);
      }
    } else {
      switch (lastChar) {
        case "+":
          break;
        case "-":
          break;
        case "*":
          break;
        case "/":
          break;
        case "(":
          break;
        //break
        case ")":
          termReset(opp);
          break;
        case ".":
          termReset(opp);
          break;
        default:
          termReset(opp);
      }
    }
  }

  void decimalHandler() {
    if (lastChar == "+" ||
        lastChar == "-" ||
        lastChar == "*" ||
        lastChar == "/" ||
        lastChar == "(") {
      displayEquation += "0.";
      numberProperties[numberProperties.length - 1].isDecimal = true;
    } else if (lastChar == ")") {
      displayEquation += "*0.";
      numberProperties[numberProperties.length - 1].isDecimal = true;
    } else if (!numberProperties[numberProperties.length - 1].isDecimal) {
      displayEquation += ".";
      numberProperties[numberProperties.length - 1].isDecimal = true;
    }
  }

  void negGrouping(String opperator) {
    displayEquation = displayEquation.substring(0, negTermStartIndex) +
        "(" +
        displayEquation.substring(negTermStartIndex, displayEquation.length);
    if (lastChar == ".") displayEquation += "0";
    displayEquation += ")";
    if (opperator == "(") displayEquation += "*";
    displayEquation += opperator;
  }
}

class NumberProperty {
  bool isNegative = false;
  bool isDecimal = false;
}
