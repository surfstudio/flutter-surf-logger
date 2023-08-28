import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_logger/surf_logger.dart';

class CounterPage extends StatefulWidget {
  final String title;

  const CounterPage({
    required this.title,
    super.key,
  });

  @override
  State<CounterPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CounterPage> {
  late final Logger logger;
  int _counter = 0;

  _MyHomePageState();

  @override
  void initState() {
    logger = context.read<Logger>()..log('MyHomePageState initState');
    super.initState();
  }

  void _incrementCounter() {
    logger.log('counter value = $_counter before setState');
    setState(() {
      _counter++;
    });
    logger.log('counter value = $_counter after setState');
  }

  @override
  Widget build(BuildContext context) {
    logger.log('MyHomePageState build');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
