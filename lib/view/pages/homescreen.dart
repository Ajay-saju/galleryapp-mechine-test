import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testfive/controller/pick_image_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PickImageController pickImageController = Get.put(PickImageController());
    // final PickImageController img = Get.find();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Gallery App',
          style: TextStyle(
              color: Colors.black,
              letterSpacing: 3,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<PickImageController>(builder: (controller) {
        return Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: unnecessary_null_comparison
              controller.images.isEmpty
                  ? const Center(
                      child: Text(
                        'No Photos',
                        style: TextStyle(fontSize: 25),
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LimitedBox(
                          maxHeight: 600,
                          maxWidth: double.infinity,
                        child: GridView.builder(
                            itemCount: controller.images.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(controller.images[index]),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                              );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 10),
                          ),
                        ),
                      ),
                    )
            ]);
      }),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          // shadowColor: const Color.fromARGB(255, 38, 3, 3)
        ),
        onPressed: () {
          pickImageController.pickMultipleImages();
        },
        child: const Text(
          'Go to Gallery',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
