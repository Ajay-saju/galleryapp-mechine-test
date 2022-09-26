import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PickImageController extends GetxController {
  File? finalImage;
  List<File> images = [];
  Future pickImageFormGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = File(image!.path).readAsBytesSync().lengthInBytes;
    if (image != null) {
      if (bytes / 1024 < 5120) {
        finalImage = File(image.path);
      } else {
        Get.snackbar('Image is too heavy',
            'Please select a file less than 5MB This file about more than 5120kb ',
            colorText: Colors.white,
            padding: const EdgeInsets.all(10),
            backgroundColor: const Color.fromARGB(255, 116, 61, 57),
            snackPosition: SnackPosition.BOTTOM);
      }
    }
    update();
  }

  Future pickMultipleImages() async {
    final List<XFile>? selectedImges = await ImagePicker().pickMultiImage();

    if (selectedImges != null && selectedImges.length <= 5) {
      for (int i = 0; i < selectedImges.length; i++) {
        final bytes =
            File(selectedImges[i].path).readAsBytesSync().lengthInBytes;
        if (images.length >= 5) {
          Get.snackbar('Error', 'select maximum 5 images',
              colorText: Colors.white,
              padding: const EdgeInsets.all(10),
              backgroundColor: const Color.fromARGB(255, 116, 61, 57),
              snackPosition: SnackPosition.BOTTOM);
          return;
        }
        if (bytes / 1024 < 5120) {
          images.add(File(selectedImges[i].path));
        } else {
          Get.snackbar('Image is too heavy',
              'Please select a file less than 5MB This file about more than 5120kb ',
              colorText: Colors.white,
              padding: const EdgeInsets.all(10),
              backgroundColor: const Color.fromARGB(255, 116, 61, 57),
              snackPosition: SnackPosition.BOTTOM);
        }
      }
    } else {
      Get.snackbar('Error', 'select maximum 5 images',
          colorText: Colors.white,
          padding: const EdgeInsets.all(10),
          backgroundColor: const Color.fromARGB(255, 116, 61, 57),
          snackPosition: SnackPosition.BOTTOM);
    }

    update();
  }

  clearImages() {
    images.clear();
    update();
  }
}
