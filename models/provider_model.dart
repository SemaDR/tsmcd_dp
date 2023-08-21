import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TextProvider extends ChangeNotifier {
  String _displayText = '';

  String get displayText => _displayText;

  void updateDisplayText(String newText) {
    _displayText = newText;
    notifyListeners();
  }

  updateActiveDisplayText(String newText) {
    _displayText = newText;
    notifyListeners();
  }
}

class ImageProvider2 extends ChangeNotifier {
  String _imageUrl = '';

  String get imageUrl => _imageUrl;

  updateImageUrl(String newUrl) {
    _imageUrl = newUrl;
    notifyListeners();
  }
}

class GlobalImageProvider extends ChangeNotifier {
  XFile? _imageFile;
  CroppedFile? _croppedImage;

  XFile? get imageFile => _imageFile;
  CroppedFile? get croppedImage => _croppedImage;

  updateFile(XFile? newXFile) {
    _imageFile = newXFile;
    notifyListeners();
  }

  updateCroppedFile(CroppedFile? newCroppedFile) {
    _croppedImage = newCroppedFile;
    notifyListeners();
  }
}



// TextProvider providerFunction(){

// }
