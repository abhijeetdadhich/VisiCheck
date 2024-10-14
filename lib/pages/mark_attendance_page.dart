import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visicheck/provider/camera_provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:image/image.dart' as img; // Add this import for image processing

class MarkAttendance extends ConsumerStatefulWidget {
  const MarkAttendance({super.key});

  @override
  ConsumerState<MarkAttendance> createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends ConsumerState<MarkAttendance> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  WebSocketChannel? _channel;
  bool isProcessing = false;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    final camera = ref.read(CameraProvider);

    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
    );

    _initializeControllerFuture = _cameraController.initialize();
    _initializeControllerFuture.then((_) {
      setState(() {
        isCameraInitialized = true;
      });
      _startCamera();
    }).catchError((error) {
      // Handle camera initialization errors
      debugPrint('Camera initialization error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error initializing camera: $error')),
      );
    });

    // Initialize WebSocket connection with the updated Render HTTPS link
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://visicheck-fastapi-new.onrender.com/ws/face_recognition'),
    );
  }

  @override
  void dispose() {
    if (isCameraInitialized) {
      _cameraController.stopImageStream();
      _cameraController.dispose();
    }
    _channel?.sink.close(status.normalClosure);
    super.dispose();
  }

  void _startCamera() async {
    if (!isCameraInitialized) return;

    _cameraController.startImageStream((image) async {
      if (isProcessing) return;
      isProcessing = true;

      try {
        // Convert image to bytes
        final bytes = await imageToBytes(image);

        // Send image bytes to WebSocket server
        _channel?.sink.add(bytes);

        // Listen for response from server
        _channel?.stream.listen((response) {
          // Handle response from server
          if (response == 'Attendance is marked') {
            setState(() {
              isProcessing = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Attendance marked successfully')),
            );
          } else if (response == 'Attendance is already marked') {
            setState(() {
              isProcessing = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Attendance already marked')),
            );
          } else {
            setState(() {
              isProcessing = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $response')),
            );
          }
        }, onError: (error) {
          setState(() {
            isProcessing = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Connection error: $error')),
          );
        });
      } catch (e) {
        debugPrint('Error during image processing: $e');
        setState(() {
          isProcessing = false;
        });
      }
    });
  }

  Future<Uint8List> imageToBytes(CameraImage image) async {
    try {
      // Convert YUV420 image to RGB image using the image library
      final width = image.width;
      final height = image.height;
      final uvRowStride = image.planes[1].bytesPerRow;
      final uvPixelStride = image.planes[1].bytesPerPixel!;
      final y = image.planes[0].bytes;
      final u = image.planes[1].bytes;
      final v = image.planes[2].bytes;

      // Create an empty RGB image buffer
      final imageBuffer = img.Image(width: width, height: height);

      for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
          final uvIndex = uvPixelStride * (j ~/ 2) + uvRowStride * (i ~/ 2);
          final index = i * width + j;

          final yVal = y[index];
          final uVal = u[uvIndex];
          final vVal = v[uvIndex];

          final r = (yVal + 1.370705 * (vVal - 128)).clamp(0, 255).toInt();
          final g = (yVal - 0.698001 * (vVal - 128) - 0.337633 * (uVal - 128)).clamp(0, 255).toInt();
          final b = (yVal + 1.732446 * (uVal - 128)).clamp(0, 255).toInt();

          imageBuffer.setPixel(j, i, img.ColorRgb8(r, g, b));
        }
      }

      final jpegBytes = Uint8List.fromList(img.encodeJpg(imageBuffer));
      return jpegBytes;
    } catch (e) {
      debugPrint('Error converting image to bytes: $e');
      return Uint8List(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final isWidthGreater = (screenWidth > screenHeight);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 189, 128),
        title: Text(
          'Mark Attendance',
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onBackground),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: isWidthGreater ? screenWidth * 0.03 : screenHeight * 0.03,
            left: screenWidth * 0.30,
            right: screenWidth * 0.30,
            top: isWidthGreater ? screenWidth * 0.79 : screenHeight * 0.79,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.check_rounded,
                color: Theme.of(context).colorScheme.onBackground,
                size: 40,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
