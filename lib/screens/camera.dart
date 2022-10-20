// ignore_for_file: prefer_const_constructors, prefer_const_declarations, prefer_const_literals_to_create_immutables
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  String? _lastImage;
  bool _loading = false;

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
    if (_lastImage != null) {
      _lastImage = null;
    }

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

      _controller!.takePicture().then((XFile? picture) {
        picture!.saveTo(pathImage);
        setState(() => _lastImage = pathImage);
      });
    } catch (e) {
      print("LASTIMAGE ERROR");
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
    // final size = MediaQuery.of(context).size;
    // final deviceRatio = size.width / size.height;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: _lastImage != null
              ? TextButton(
                  onPressed: () => setState(() => _lastImage = null),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )
              : null,
        ),
        backgroundColor: Colors.black,
        body: FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  Transform.scale(
                    scale: _controller!.value.aspectRatio,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 1 / _controller!.value.aspectRatio,
                        child: _lastImage != null
                            ? Image(
                                image: FileImage(
                                  File(_lastImage!),
                                ),
                              )
                            : CameraPreview(_controller!),
                      ),
                    ),
                  ),
                  _lastImage == null
                      ? Align(
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
                        )
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 30.0,
                              right: 20,
                            ),
                            child: FloatingActionButton.extended(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(),
                              backgroundColor: Colors.white.withOpacity(0.6),
                              onPressed: (() async {
                                setState(() => _loading = !_loading);

                                await Future.delayed(Duration(seconds: 3));
                                setState(() => _lastImage = null);

                                setState(() => _loading = !_loading);
                              }),
                              label: Text(
                                "Pusblish",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              icon: Icon(
                                Icons.send,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                  Visibility(
                    visible: _lastImage == null,
                    child: Align(
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
                  ),
                  Visibility(
                    visible: _lastImage == null,
                    child: Align(
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
                  ),
                  Visibility(
                      visible: _loading == true,
                      child: Positioned(
                        bottom: 45,
                        left: 25,
                        child: Container(
                          margin: EdgeInsets.only(),
                          child: Row(
                            children: [
                              SpinKitCircle(
                                color: Colors.white,
                                size: 15.0,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Publishing...",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
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
