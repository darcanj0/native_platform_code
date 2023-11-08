import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Sum',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Native Sum'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int a = 0;
  int b = 0;
  int sumResult = 0;
  Future<void> _sum() async {
    const channel = MethodChannel('native-app/channel');
    try {
      final sum = await channel.invokeMethod('calcSum', {"a": a, "b": b});
      setState(() {
        sumResult = sum;
      });
    } on PlatformException catch (_) {
      setState(() {
        sumResult = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sum is: ${sumResult.toString()}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                decoration: const InputDecoration(label: Text('A')),
                onChanged: (value) => setState(() {
                  a = int.tryParse(value) ?? 0;
                }),
              ),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                decoration: const InputDecoration(label: Text('B')),
                onChanged: (value) => setState(() {
                  b = int.tryParse(value) ?? 0;
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: _sum, child: const Text('Sum'))
            ],
          ),
        ),
      ),
    );
  }
}
