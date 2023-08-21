import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsmcd_dp/models/provider_model.dart';
import 'package:tsmcd_dp/utils/constants.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class TabletView extends StatefulWidget {
  TabletView({super.key});

  @override
  State<TabletView> createState() => _TabletViewState();
}

class _TabletViewState extends State<TabletView> {
  ImageCropper imageCropper = ImageCropper();

  XFile? image;

  CroppedFile? croppedImageFile;

  //
  Future<CroppedFile?> _cropImage(XFile? selectedImage) async {
    CroppedFile? croppedFile = await imageCropper.cropImage(
      sourcePath: selectedImage!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: orangeColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        WebUiSettings(
          context: context,
          presentStyle: CropperPresentStyle.dialog,
          boundary: const CroppieBoundary(
            width: 350,
            height: 350,
          ),
          viewPort:
              const CroppieViewPort(width: 300, height: 300, type: 'circle'),
          enableExif: true,
          enableZoom: true,
          showZoomer: true,
        ),
      ],
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
      maxWidth: 800,
      maxHeight: 800,
      cropStyle: CropStyle.rectangle, // Adjust as needed
    );
    setState(() => croppedImageFile = croppedFile);
  }

  Future<String?> _pickAndCropImage() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      final pickedImage = XFile(result.path);
      setState(() => image = pickedImage);
      CroppedFile? cropImage = await _cropImage(result);
    }
  }

  //
  final textController = TextEditingController();

  void _updateFirestore(BuildContext context, String newText) {
    FirebaseFirestore.instance
        .collection('TSMCD_Text')
        .doc('userText')
        .set({'TSMCD_Text': newText});
    Provider.of<TextProvider>(context, listen: false)
        .updateDisplayText(newText);
  }

  Widget _body() {
    if (croppedImageFile != null) {
      return _imageDisplay();
    } else {
      return _placeHolder();
    }

    // if (Provider.of<GlobalImageProvider>(context).croppedImage != null) {
    //   return _imageDisplay();
    // } else {
    //   return _placeHolder();
    // }
  }

  Widget _imageDisplay() {
    return InkWell(
      onTap: () async {
        _pickAndCropImage();
        // if (newFilePath != null) {
        //   Provider.of<ImageProvider2>(context, listen: false)
        //       .updateImageUrl(newFilePath);
        // }
      },
      child: Container(
        height: 118.0,
        width: 118.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: orangeColor,
            width: 1.5,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(100.0)),
        ),
        child: Image.network(croppedImageFile!.path),
      ),
    );
  }

  Widget _placeHolder() {
    return InkWell(
      onTap: () async {
        _pickAndCropImage();
        // if (newFilePath != null) {
        //   Provider.of<ImageProvider2>(context, listen: false)
        //       .updateImageUrl(newFilePath);
        // }
      },
      child: Container(
        height: 118.0,
        width: 118.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: orangeColor,
            width: 1.5,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(100.0)),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: 50.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: deviceHeight,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            opacity: 400.0,
            image: AssetImage('assets/images/bg_vertical.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        // Container for the flyer
                        height: deviceHeight - 50,
                        width: deviceWidth - (deviceWidth / 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          image: const DecorationImage(
                            image: AssetImage('assets/images/flyer_image.jpg'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 52,
                        left: 207,
                        child: CircularWidget(),
                      ),
                      Positioned(
                        top: 240 / 2,
                        right: 40.0,
                        child: Container(
                          height: 45.0,
                          width: 140.0,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 42.0, top: 4.0, bottom: 4.0, right: 10.0),
                            child: Center(
                              child: Text(
                                Provider.of<TextProvider>(context).displayText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 2nd Column
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Container(
                      width: deviceWidth > 900 ? deviceWidth / 4.5788 : 895 / 2,
                      height: 195 / 2,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo_black.png'),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20.0),

                  //     // Search

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Name: w = $deviceWidth h = $deviceHeight',
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lato',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 2.0),
                        Expanded(
                          flex: 4,
                          child: TextField(
                            controller: textController,
                            decoration: InputDecoration(
                              labelText:
                                  'E.g. Ofah Awor ${((deviceWidth - (deviceWidth / 8)) / 2) - 10}',
                              labelStyle: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(.3),
                                fontSize: 14.0,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: orangeColor,
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: orangeColor,
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => textController.clear(),
                                icon: const Icon(Icons.clear),
                                color: blackColor,
                                iconSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      "To make a photo upload, simply tap the add(+) circular field and upload your preferred image...",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontFamily: 'Lato',
                        overflow: TextOverflow.clip,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // Button Here
                  InkWell(
                    onTap: () {
                      String userInput = textController.text;
                      // _updateFirestore(context, userInput);
                    },
                    child: Container(
                      height: 35.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        color: orangeColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(width: 10.0),
                          Text(
                            'Continue',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Lato'),
                          ),
                          SizedBox(width: 5.0),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 14.0,
                          ),
                          SizedBox(width: 10.0),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),

            // Flyer Image goes here...
            const SizedBox(height: 20.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: orangeColor,
        onPressed: () {},
        child:
            const Icon(Icons.download_sharp, color: Colors.white, size: 18.0),
      ),
    );
  }
}

class CircularWidget extends StatelessWidget {
  CircularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        double widgetSize = constraints.biggest.shortestSide * 0.35;
        return Container(
          height: widgetSize,
          width: widgetSize,
          decoration: BoxDecoration(
            border: Border.all(
              color: orangeColor,
              width: 2.0,
            ),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(200.0)),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.black,
              size: 50.0,
            ),
          ),
        );
      },
    );
  }
}
