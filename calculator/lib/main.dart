import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Widgets/Screen.dart';
import 'Widgets/Keypad.dart';
import 'model/AnswerLogic.dart';
import 'model/EquationLogic.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => EquationLogic(),
          ),
          ChangeNotifierProvider(
            create: (_) => AnswerLogic(),
          ),
        ],
        child: MaterialApp(
          home: Calc(),
          debugShowCheckedModeBanner: false,
        ),
      ),

      // MaterialApp(
      //   home: Calc(),
      //   debugShowCheckedModeBanner: false,
      // ),
    );

class Calc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: todo
      drawer: Drawer(), //TODO: work on drawer
      backgroundColor: Color.fromRGBO(55, 67, 83, 1),
      appBar: AppBar(
        title: Text("My Companion"),
      ),
      body: Column(
        children: [
          Screen(context),
          Expanded(
            child: Keypad(),
          ),
        ],
      ),
    );
  }
}

// Widget buildButton(String value, BuildContext context) => GestureDetector(
//       onTap: () {
//         var display = context.read<Display>();
//       },
//       child: Container(
//         height: 70,
//         width: 70,
//         decoration: BoxDecoration(
//             border: Border.all(width: 1),
//             borderRadius: BorderRadius.all(Radius.circular(15))),
//         child: Center(
//           child: Text(value),
//         ),
//       ),
//     );
