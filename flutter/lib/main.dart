import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:switcher/bridge.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SwitcherWidget(),
    );
  }
}

class SwitcherWidget extends StatefulWidget {
  const SwitcherWidget({super.key});

  @override
  State<SwitcherWidget> createState() => _SwitcherWidgetState();
}

class ApiHandler implements FApi {
  final Function(String) callBack;

  ApiHandler(this.callBack);

  @override
  void currentState(String state) {
    callBack(state);
  }
}

class _SwitcherWidgetState extends State<SwitcherWidget> {
  var state = "true";
  HistoryEntry  history = HistoryEntry( state: HashMap());
  final _api = HApi();

  TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FApi.setup(ApiHandler(currentState));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter App')),
        body: Column(
          children: [
            Text(state),
            TextFormField(
              controller: lastNameController,
              decoration:  const InputDecoration(
                labelText: "Text",
              ),
            ),

            GestureDetector(
              onTap: (){
                _updateState();
                SystemNavigator.pop();

              },
              child: Text("GO TO NATIVE"),)
          ],
        )
    );
  }

  void currentState(String state) {
    setState(() {
      this.state = state;
    });
  }

  void _updateState() {
    final String TITLE = "TITLE";
    final String SUBTITLE = "SUBTITLE";
    final String TOKEN = "TOKEN";
    HashMap<String,Object> x = HashMap();
    x[TITLE] = "$TITLE:${lastNameController.text}\n";
    x[SUBTITLE] = "$SUBTITLE:${lastNameController.text}----\n";
    x[TOKEN] = 5;
    _api.updateState(HistoryEntry(state: x));
    history = HistoryEntry(state: x);
    setState(() {
      state = state;
    });
  }
}
