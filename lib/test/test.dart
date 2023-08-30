import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final changeCounter =
        Provider.of<CounterController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter app'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          const Text(
            "Count will increase when you click the button",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            changeCounter.count.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          TextButton(onPressed: changeCounter.reset, child: const Text("Reset"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeCounter.increase,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class CounterController extends ChangeNotifier {
  int count = 0;
  int get counter => count;
  void increase() {
    count += 1;
    notifyListeners();
  }

  void reset() {
    count = 0;
    notifyListeners();
  }
}
