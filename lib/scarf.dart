import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oguz_dokma/esasy_sah.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Sarf extends StatefulWidget {
  const Sarf({super.key});

  @override
  State<Sarf> createState() => _SapkaState();
}

class _SapkaState extends State<Sarf> {
  bool _isPlaying = false;
  bool _isPaused = false;
  int _seconds = 58 * 60;
  Timer? _timer;
  String _savedInfo = '';

  Future<void> _postInfo(String info) async {
    final body = {"info": info};

    var url = 'http://192.168.4.1';
    final uri = Uri.parse(url);

    try {
      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: 'Amal ýerine ýetirildi',
            backgroundColor: Colors.green,
            textColor: Colors.white);
        print(body);
      } else {
        print(response.statusCode);
      }
    } catch (e, s) {
      print('Exception: $e, Stack Trace: $s');
    }
  }

  Future<void> _saveInfo(String info) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('info', info);
    setState(() {
      _savedInfo = info;
    });
  }

  Future<String> _getSavedInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('info') ?? '';
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
        if (_seconds <= 0) {
          _stopTimer();
          _saveInfo('0');
          _postInfo('dur');
          _seconds = 0;
          _isPlaying = false;
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _saveInfo(_seconds.toString());
    if (!_isPlaying) {
      _postInfo('dur');
    }
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _postInfo(_seconds.toString());
        _startTimer();
      } else {
        _stopTimer();
        _postInfo('dur');
      }
    });
  }

  void _continueTimer() async {
    final savedSeconds = await _getSavedInfo();
    if (savedSeconds.isNotEmpty) {
      setState(() {
        _seconds = int.parse(savedSeconds);
        _isPlaying = true;
        _startTimer();
      });
    }
  }

  void _resetTimer() {
    setState(() {
      _seconds = 58 * 60;
      _isPlaying = false;
      _stopTimer();
      _postInfo('dur');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.blue,
            expandedHeight: 370,
            floating: true,
            pinned: true,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Esasy()),
                );
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: const Text(
              "ŞARF ÖRMEK",
              style: TextStyle(color: Colors.white),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.srcOver),
                child: Image.asset(
                  'lib/suratlar/wal.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 70),
                GestureDetector(
                  onTap: _togglePlay,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: _isPlaying ? Colors.red : Colors.blue,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '${_seconds ~/ 60}:${_seconds % 60 < 10 ? '0${_seconds % 60}' : _seconds % 60}',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _resetTimer,
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
