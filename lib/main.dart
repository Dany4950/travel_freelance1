import 'dart:async';
import 'package:flutter/material.dart';
import 'Locationinfo.dart';

void main() {
  runApp(MaterialApp(
    title: 'Solo',
    home: ImageScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class ImageScreen extends StatefulWidget {
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  int _currentIndex = 0;
  final List<String> _images = [
    'Resources/Img1.png',
    'Resources/Img3.png',
    'Resources/Img2.png',
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _images.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExpandedImage(
                image: Image.asset(_images[_currentIndex]),
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_images[_currentIndex]),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(
                backgroundColor: Colors.grey[400],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TravelScreen(),
                    ),
                  );
                },
                child: const Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExpandedImage extends StatelessWidget {
  final Image image;

  const ExpandedImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: InteractiveViewer(
            child: image,
          ),
        ),
      ),
    );
  }
}
