// ignore_for_file: prefer_const_constructors, prefer_const_declarations
import 'package:flutter/gestures.dart';
import 'package:path/path.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraScreen({
    super.key,
    required this.cameras,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  Future<void>? _initializeControllerFuture;
  CameraController? _controller;
  int _selectedCameraIndex = -1;

  Future<void> initCamera(CameraDescription camera) async {
    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    _controller?.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (_controller!.value.hasError) {
      print("Camera Error ${_controller!.value.errorDescription}");
    }

    _initializeControllerFuture = _controller!.initialize();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _cameraToggle() async {
    setState(() {
      _selectedCameraIndex = _selectedCameraIndex > -1
          ? _selectedCameraIndex == 0
              ? 1
              : 0
          : 0;
    });

    await initCamera(widget.cameras[_selectedCameraIndex]);
  }

  Future<void> _takePhoto() async {
    try {
      await _initializeControllerFuture;

      String pathImage = join((await getTemporaryDirectory()).path,
          "${DateTime.now().millisecondsSinceEpoch}.jpg");

      XFile picture = _controller!.takePicture() as XFile;
      picture.saveTo(pathImage);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _cameraToggle();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double scale = size.aspectRatio * _controller!.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: TextButton(
            onPressed: () => print("close"),
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  Transform.scale(
                    scale: scale,
                    child: Center(
                      child: CameraPreview(_controller!),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 30.0,
                      ),
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3.0,
                          color: Colors.white,
                        ),
                      ),
                      child: FittedBox(
                        child: InkWell(
                          onLongPress: (() => print("take video")),
                          child: FloatingActionButton(
                            onPressed: () => _takePhoto(),
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 40,
                        left: 60,
                      ),
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3.0,
                          color: Colors.white,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: () => print("gallery access"),
                          child: Icon(
                            Icons.photo_size_select_actual,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 40,
                        right: 60,
                      ),
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3.0,
                          color: Colors.white,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: _cameraToggle,
                          child: Icon(
                            Icons.loop,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: Text("Loading"),
            );
          },
        ),
      ),
    );
  }
}
