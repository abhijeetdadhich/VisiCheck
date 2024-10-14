import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visicheck/main.dart';

final CameraProvider = Provider((ref) => const MyApp().camera!);
