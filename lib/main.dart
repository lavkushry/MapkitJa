import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Simple Example')),
        body: Stack(
          children: [
            WebView(
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
                loadLocalHtml();
              },
              initialUrl: 'about:blank',
              javascriptMode: JavascriptMode.unrestricted,
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: _locateMe,
                child: Icon(Icons.my_location),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadLocalHtml() async {
    String mapHtml = await rootBundle.loadString('assets/web/map.html');
    String mapDataUri = Uri.dataFromString(mapHtml, mimeType: 'text/html').toString();
    _controller.loadUrl(mapDataUri);
  }

  Future<void> _locateMe() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Pass the location to the WebView
    _controller.runJavascript(
        'window.updateLocation(${position.latitude}, ${position.longitude});');
  }
}