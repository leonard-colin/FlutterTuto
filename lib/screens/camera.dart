// ignore_for_file: prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 15,
          ),
          child: FutureBuilder(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    CameraPreview(_controller!),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 35.0,
                        ),
                        height: 60.0,
                        width: 60.0,
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
                              onPressed: () => print("take photo"),
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
      ),
    );
  }
}
