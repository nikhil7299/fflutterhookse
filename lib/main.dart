import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

// const url = 'https://bit.ly/3qYOtDm';
const url =
    'https://images.unsplash.com/photo-1659135890084-930731031f40?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bWFjYm9vayUyMG0yfGVufDB8MHwwfHw%3D&auto=format&fit=crop&w=800&q=60';
const imageHeight = 300.0;

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    late final StreamController<double> controller;
    controller = useStreamController<double>(
      onListen: () {
        controller.sink.add(0.0);
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: StreamBuilder<double>(
          stream: controller.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              final rotation = snapshot.data ?? 0.0;
              return GestureDetector(
                onTap: () {
                  controller.sink.add(rotation + 10.0);
                },
                child: RotationTransition(
                    turns: AlwaysStoppedAnimation(rotation / 360.0),
                    child: Center(child: Image.network(url))),
              );
            }
          }),
    );
  }
}
