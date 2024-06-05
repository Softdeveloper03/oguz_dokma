import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oguz_dokma/esasy_sah.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Tekiz extends StatefulWidget {
  const Tekiz({super.key});

  @override
  State<Tekiz> createState() => _SapkaState();
}

class _SapkaState extends State<Tekiz> {
  TextEditingController ini = TextEditingController();
  TextEditingController uzynlygy = TextEditingController();
  Future<void> mag_ug() async {
    final title = ini.text;
    final description = uzynlygy.text;
    final body = {"ini": title, "uzynlygy": description, "ady": "plain"};

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
            msg: 'Üstünlikli ýerine ýetirildi',
            backgroundColor: Colors.green,
            textColor: Colors.white);
        ini.text = '';
        uzynlygy.text = '';
        print(body);
      } else {
        print(response.statusCode);
      }
    } catch (e, s) {
      print('Exception: $e, Stack Trace: $s');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.deepPurple,
            expandedHeight: 300,
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
              "TEKIZ ZATLARY ÖRMEK",
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
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 5.0),
                    child: TextFormField(
                      controller: ini,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        label: Text('Örginiň ini...'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 5.0),
                    child: TextFormField(
                      controller: uzynlygy,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        label: Text('Örginiň uzynlygy...'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      ;
                    },
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'Örmäge başla',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
