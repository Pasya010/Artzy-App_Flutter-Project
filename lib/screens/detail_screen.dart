import 'dart:async';
import 'dart:ui';

import 'package:arty_app/blocs/Artlist/artlist_bloc.dart';
import 'package:arty_app/blocs/Artlist/artlist_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final String images;
  const DetailScreen({super.key, required this.title, required this.images});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double _xRotation = 0;
  double _yRotation = 0;
  double _targetX = 0;
  double _targetY = 0;
  late Timer _timer;
  StreamSubscription? _gyroscopeSubscription;

  @override
  void initState() {
    super.initState();

    // Mendengarkan perubahan dari gyroscope
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _targetX = event.x; // Rotasi target sumbu Y
        _targetY = event.y; // Rotasi target sumbu X
      });
    });

    // Menghaluskan rotasi setiap 16ms (frame rate ~60fps)
    _timer = Timer.periodic(Duration(milliseconds: 16), (_) {
      setState(() {
        _xRotation = lerpDouble(_xRotation, _targetX, 0.1)!; // Interpolasi X
        _yRotation = lerpDouble(_yRotation, _targetY, 0.1)!; // Interpolasi Y
      });
    });
  }

  @override
  void dispose() {
    // Hentikan listener gyroscope dan timer saat layar ditutup
    _gyroscopeSubscription?.cancel();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // text
          Text(
            '"Tilt you Phone!"',
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(
            height: 15,
          ),

          Center(
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // Efek perspektif
                ..rotateX(_xRotation)
                ..rotateY(_yRotation),
              alignment: FractionalOffset.center,
              child: Container(
                height: 400,
                width: 400,
                child: Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(widget.images)),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              final newItem = {'title': widget.title, 'images': widget.images};
              context.read<ArtlistBloc>().add(AddToArtlist(newItem));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${widget.title} added to Artlist")),
              );
            },
            child: Text(
              "Add to Artlist",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
