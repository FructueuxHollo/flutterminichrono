import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StopWatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'StopWatch'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //  declaration of some variables
  double pourcente = 0;
  int seconde = 0;
  bool stop = false;
  int minute = 0;
  int secondeRemaind = 0;
  var sec = const Duration(seconds: 1);

  // startChrono launch the stopwatch

  void startChrono() {
    stop = false;

    // Timer's callback function is use to define the behavior of the stopwatch after a sec

    Timer(sec, () {
      for (int i = 0; i < 1; i++) {
        seconde++;
        pourcente = seconde.remainder(60) / 60;
        secondeRemaind = seconde.remainder(60);
        if (secondeRemaind == 0) {
          minute++;
        }
        if (stop) {
          break;
        }

// to make it repeat infinitly startChrono is used has a recursive function

        startChrono();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                    value: pourcente,
                  ),
                ),
                Positioned(
                  child: Text(
                    '$minute . $secondeRemaind',
                    style: const TextStyle(fontSize: 50),
                  ),
                  left: 25,
                  top: 70,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    stop = true;
                    setState(() {});
                  },
                  child: const Icon(Icons.pause),
                ),
                const SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                  onPressed: startChrono,
                  child: const Icon(Icons.play_arrow),
                ),
                const SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                    // here onPressed reset the stopwatch
                    onPressed: () {
                      seconde = 0;
                      secondeRemaind = 0;
                      pourcente = 0;
                      minute = 0;
                      stop = true;
                      setState(() {});
                    },
                    child: const Icon(Icons.restart_alt)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
