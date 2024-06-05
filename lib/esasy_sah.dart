import 'package:flutter/material.dart';
import 'package:oguz_dokma/hat.dart';
import 'package:oguz_dokma/main.dart';
import 'package:oguz_dokma/plain.dart';
import 'package:oguz_dokma/scarf.dart';

class Esasy extends StatefulWidget {
  const Esasy({super.key});

  @override
  State<Esasy> createState() => _EsasyState();
}

class _EsasyState extends State<Esasy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'OGUZ DOKMA',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Sapka()));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'lib/suratlar/hat.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 150,
                      width: 500,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black
                            .withOpacity(0.5), // transparent black layer
                      ),
                      child: const Center(
                        child: Padding(
                          padding: const EdgeInsets.all(58.0),
                          child: Text(
                            'ŞAPKA',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Sarf()));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'lib/suratlar/scarf.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 150,
                      width: 500,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black
                            .withOpacity(0.5), // transparent black layer
                      ),
                      child: const Center(
                        child: Padding(
                          padding: const EdgeInsets.all(58.0),
                          child: Text(
                            'ŞARF',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Tekiz()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
