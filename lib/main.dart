import 'package:flutter/material.dart';

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
  double a = 0;
  double b = 0;
  double sumResult = 0;
  Future<void> _sum() async {
    setState(() {
      sumResult = a + b;
    });
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
                'Sum is: ${sumResult.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(label: Text('A')),
                onChanged: (value) => setState(() {
                  a = double.tryParse(value) ?? 0;
                }),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(label: Text('B')),
                onChanged: (value) => setState(() {
                  b = double.tryParse(value) ?? 0;
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
