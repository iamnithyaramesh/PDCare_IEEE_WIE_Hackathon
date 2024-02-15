import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthcare App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 62, 125, 99)),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
      debugShowCheckedModeBanner: false, // Hide the debug banner
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to PDCare',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AudioRecorderScreen()),
                );
              },
              child: const Text('Take the Audio Analysis Test'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CommunityPage()),
                );
              },
              child: const Text('Community'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SpecialistsPage()),
                );
              },
              child: const Text('Find Specialists'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color _backgroundColor = Color.fromARGB(255, 62, 125, 99);
  TextStyle _textStyle = TextStyle(fontSize: 16);

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: _textStyle.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _backgroundColor = Color.fromARGB(255, 62, 125, 99); // Change background color to blue
              });
            },
            tooltip: 'Change Background',
            child: const Icon(Icons.color_lens),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _textStyle = _textStyle.copyWith(fontSize: 20); // Increase font size
              });
            },
            tooltip: 'Increase Font Size',
            child: const Icon(Icons.format_size),
          ),
        ],
      ),
    );
  }
}


class AudioRecorderScreen extends StatefulWidget {
  @override
  _AudioRecorderScreenState createState() => _AudioRecorderScreenState();
}

class _AudioRecorderScreenState extends State<AudioRecorderScreen> {
  bool _isRecording = false;
  String _audioPath = '';
  bool _isAnalyzing = false;
  bool _hasParkinsons = false;
  double _severity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Recorder & Analyzer'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isRecording = !_isRecording;
                if (_isRecording) {
                  _audioPath = ''; // Reset audio path when starting a new recording
                }
              });
            },
            child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
          ),
          if (_audioPath.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Recorded audio path: $_audioPath'),
            ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                _isAnalyzing = true;
              });
              await Future.delayed(Duration(seconds: 3)); 
              setState(() {
                _hasParkinsons = Random().nextBool();
                _severity = Random().nextDouble() * 100;
                _isAnalyzing = false;
              });
            },
            child: Text('Analyze Recorded Audio'),
          ),
          if (_isAnalyzing)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          if (!_isAnalyzing && _hasParkinsons != null)
            Column(
              children: [
                Text('Parkinson\'s Disease: ${_hasParkinsons ? 'Present' : 'Absent'}'),
                Text('Disease Severity: ${_severity.toStringAsFixed(2)}'),
              ],
            ),
        ],
      ),
    );
  }
}

class StatisticsPage extends StatelessWidget {
  final bool hasParkinsons;
  final double severity;

  const StatisticsPage({
    Key? key,
    required this.hasParkinsons,
    required this.severity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Parkinson\'s Disease:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              hasParkinsons ? 'Present' : 'Absent',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Disease Severity:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Severity: ${severity.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text('User 1'),
                  subtitle: Text('Do you know any motor specialists in Chennai?'),
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text('User 2'),
                  subtitle: Text('Hmm, I know a few..'),
                ),
                // Add more list items for other community posts
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Handle sending the message
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SpecialistsPage extends StatelessWidget {
  const SpecialistsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Specialists'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Motor Specialists in Your Area'),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text('Dr. Smith'),
                  subtitle: Text('Neurologist'),
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text('Dr. Johnson'),
                  subtitle: Text('Physiotherapist'),
                ),
                // Add more list items for other specialists
              ],
            ),
          ),
        ],
      ),
    );
  }
}