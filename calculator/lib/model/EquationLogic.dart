import 'package:calculator/model/AnswerLogic.dart';
import 'package:flutter/material.dart';

class EquationLogic extends ChangeNotifier {
  String displayEquation = "0";
  String lastChar;

  int openBrackets = 0;
  int negTermStartIndex = 0;

  var numberProperties = new List();

  AnswerLogic ans = new AnswerLogic();

  //answer logic
  // String equation;

  // var eqnParts = new List();
  // var steps = new List();
  // var braceInd = new List();

  // String answer = "...";

  // int oppNum = 0;
  // int eqnStartInd;
  // int eqnEndInd;

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
          ans.calcProcess(displayEquation);
          break;
        default:
          displayEquation += input;
      }
    }

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
    else if (lastChar == ")" && opperator == "(")
      displayEquation += "*(";
    else if (lastChar == ".")
      displayEquation += "0$opperator";
    else if (opperator == "(" &&
        (lastChar != "+" &&
            lastChar != "-" &&
            lastChar != "*" &&
            lastChar != "/"))
      displayEquation += "*$opperator";
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
    if (lastChar == "-" && bracket == "(") {
      displayEquation += bracket;
      openBrackets++;
    } else if (bracket == "(") {
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
    // answer = 0;
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

  //answer logic
//   void calcProcess(String givenEquation) {
//     eqnParts = [];
//     braceInd = [];
//     steps = [];
//     oppNum = 0;
//     eqnStartInd = null;
//     eqnEndInd = null;
//     this.equation = givenEquation;
//     bracketPrecedence();

//     // if (braceInd.length > 0) {
//     //   for (var indexGroup in braceInd) {
//     //     eqnParts = [];
//     //     eqnLog(indexGroup.startInd, indexGroup.closeInd);
//     //   }
//     // } else {
//     //   eqnLog(0, equation.length - 1);
//     // }
//   }

//   void bracketPrecedence() {
//     for (int eqnInd = 0; eqnInd < equation.length; eqnInd++) {
//       eqnParts = [];
//       oppNum = 0;
//       if (eqnInd == equation.length - 1 && equation[eqnInd] != ")") {
//         eqnStartInd = 0;
//         eqnEndInd = equation.length - 1;
//         eqnLog(eqnStartInd, eqnEndInd);
//         answer = equation;
//         notifyListeners();
//         break;
//       }

//       if (equation[eqnInd] != ")") continue;
//       // int searchInd;
//       // if (braceInd.length == 0)
//       //   searchInd = eqnInd - 2;
//       // else
//       //   searchInd = braceInd[braceInd.length - 1].startInd - 2;
//       for (int searchInd = eqnInd - 2; searchInd >= 0; searchInd--) {
//         if (equation[searchInd] == "(") {
//           // openBracketInd = searchInd;
//           // closeBracketInd = eqnInd;

//           eqnStartInd = searchInd + 1;
//           eqnEndInd = eqnInd - 1;

//           eqnLog(eqnStartInd, eqnEndInd);

//           eqnInd = 0;
//           break;
//         }
//       }
//     }
//   }

//   void eqnLog(int startInd, int endInd) {
//     String tempNum;

//     for (var i = startInd; i <= endInd; i++) {
//       //if an opperator (except (-)) is detected
//       if (equation[i] == "+" || equation[i] == "*" || equation[i] == "/") {
//         eqnParts.add(tempNum);
//         eqnParts.add(equation[i]);
//         tempNum = null;
//         oppNum++;
//       }
//       //if negative
//       else if (equation[i] == "-") {
//         if (equation[i - 1] == "+" ||
//             equation[i - 1] == "*" ||
//             equation[i - 1] == "/") {
//           if (tempNum == null)
//             tempNum = equation[i];
//           else
//             tempNum += equation[i];
//         } //if - operator
//         else {
//           eqnParts.add(tempNum);
//           eqnParts.add(equation[i]);
//           tempNum = null;
//           oppNum++;
//         }
//       } // number

//       else {
//         if (tempNum == null)
//           tempNum = equation[i];
//         else
//           tempNum += equation[i];
//       }

//       //on last num char
//       if (i == endInd) {
//         eqnParts.add(tempNum);
//         tempNum = null;
//       }
//     }
//     eqnPrecedence();
//   }

//   void eqnPrecedence() {
//     for (int a = 1; a <= oppNum; a++) {
//       for (var b = 0; b < eqnParts.length - 1; b++) {
//         switch (eqnParts[b]) {
//           case "/":
//             compute(eqnParts[b], b);
//             break;
//           case "*":
//             compute(eqnParts[b], b);
//             break;
//           case "+":
//             compute(eqnParts[b], b);
//             break;
//           case "-":
//             compute(eqnParts[b], b);
//             break;
//         }
//       }
//     }
//   }

//   void compute(String opp, int oppInd) {
//     num num1 = decimalCheck(eqnParts[oppInd - 1]);

//     num num2 = decimalCheck(eqnParts[oppInd + 1]);

//     num result;

//     switch (opp) {
//       case "/":
//         result = num1 / num2;
//         break;
//       case "*":
//         result = num1 * num2;
//         break;
//       case "+":
//         result = num1 + num2;
//         break;
//       case "-":
//         result = num1 - num2;
//         break;
//     }

//     eqnPartsUpdate(oppInd, result);
//     equationUpate(result);
//     stepsUpdate();
//   }

//   num decimalCheck(String number) {
//     if (number.contains("."))
//       return double.parse(number);
//     else
//       return int.parse(number);
//   }

//   void eqnPartsUpdate(int oppInd, num result) {
//     eqnParts.replaceRange(oppInd - 1, oppInd + 2, [result]);
//   }

//   void equationUpate(num result) {
//     // equation.replaceRange(
//     //     braceInd[0].startInd - 1, braceInd[0].closeInd + 2, result.toString());

//     if (eqnStartInd == 0)
//       equation = result.toString();
//     else
//       equation = equation.substring(0, eqnStartInd - 1) +
//           result.toString() +
//           equation.substring(eqnEndInd + 2, equation.length);

//     // braceInd.removeAt(0);
//   }

//   void stepsUpdate() {
//     steps.add(equation);
//   }

}

// class BraceIndex {
//   int startInd;
//   int closeInd;
// }

class NumberProperty {
  bool isNegative = false;
  bool isDecimal = false;
}
