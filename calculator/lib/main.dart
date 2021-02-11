import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Widgets/Screen.dart';
import 'Widgets/Keypad.dart';
import 'model/EquationLogic.dart';

void main() => runApp(
      ChangeNotifierProvider(
        // Initialize the model in the builder. That way, Provider
        // can own Counter's lifecycle, making sure to call `dispose`
        // when not needed anymore.
        create: (context) => EquationLogic(),
        child: MaterialApp(
          home: Calc(),
          // home: Test(),
          debugShowCheckedModeBanner: false,
        ),
      ),
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
          Consumer<EquationLogic>(
              builder: (context, display, child) => Screen(context)),
          Expanded(
            child: Keypad(context),
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
