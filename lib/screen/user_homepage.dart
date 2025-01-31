import 'package:flutter/material.dart';
import 'package:medico/screen/displaytext.dart';
import 'package:medico/widget/custom_homepage.dart';
import 'package:medico/widget/custom_scaffold.dart';
import 'package:medico/widget/drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'dart:io';

class userhomepage extends StatefulWidget {
  const userhomepage({super.key});

  @override
  State<userhomepage> createState() => _userhomepageState();
}

class _userhomepageState extends State<userhomepage> {
  bool loading = true;
  File? _image;
  List _output = [];
  final ImagePicker imagePicker = ImagePicker();
  String selectedLanguage = 'Marathi';

  Map<String, String> labelDescriptions = {
    'Dolo 365': 'assets/DOLO 365.txt',
    'Calpol 500': 'assets/Calpol 500.txt',
  };

  Map<String, String> hindiFilePaths = {
    'Dolo 365': 'assets/DOLO 360(hindi).txt',
    'Calpol 500': 'assets/Calpol 500(hindi).txt',
    // Add more mappings as needed
  };

  String getHindiFilePath(String label) {
    // Default to a generic Hindi file if label not found
    return hindiFilePaths[label] ?? 'assets/GenericHindiFile.txt';
  }

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  Future<void> detectImage(File image) async {
    var prediction = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _output = prediction ?? [];
      loading = false;

      if (_output.isEmpty) {
        // Show error message or handle invalid image case here
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Invalid Image'),
              content: Text('The image does not match any label.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  Future<void> pickImageCamera() async {
    final XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
    }
    detectImage(_image!);
  }

  Future<void> pickImageGallery() async {
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
    }
    detectImage(_image!);
  }
  @override
  Widget build(BuildContext context) {
    return CustomHomepage(
      title: "User Homepage",

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: 180,
              padding: EdgeInsets.all(10),
              child: Lottie.asset('assets/medicinegif.json'),
            ),
            Text(
              'Medicine Detector',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // DropdownButton<String>(
            //   value: selectedLanguage,
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       selectedLanguage = newValue!;
            //     });
            //   },
            //   items: ['Marathi', 'Hindi'].map<DropdownMenuItem<String>>((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            // ),
            SizedBox(height: 30),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      pickImageCamera();
                    },
                    child: Text(
                      'Capture',
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      pickImageGallery();
                    },
                    child: Text(
                      'Gallery',
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            if (!loading)
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 220,
                      padding: EdgeInsets.all(15),
                      child: Image.file(_image ?? File('')),
                    ),
                    if (_output.isNotEmpty)
                      Column(
                        children: [
                          Text(
                            (_output[0]['label']).toString().substring(2),
                            style: GoogleFonts.roboto(fontSize: 18),
                          ),
                          Text(
                            'Confidence: ' + (_output[0]['confidence']).toString(),
                            style: GoogleFonts.roboto(fontSize: 18),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('Show Description button pressed');
                              String detectedLabel = (_output[0]['label']).toString().substring(2);
                              if (!labelDescriptions.containsKey(detectedLabel)) {
                                print('Image is not relevant.');
                                return;
                              }
                              String marathiFilePath = labelDescriptions[detectedLabel]!;
                              String hindiFilePath = getHindiFilePath(detectedLabel);

                              print('Marathi File Path: $marathiFilePath');
                              print('Hindi File Path: $hindiFilePath');
                              print('now  start navigator.push');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DisplayTextPage(
                                    marathiFilePath: marathiFilePath,
                                    hindiFilePath: hindiFilePath,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.lightBlue[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Show Description',
                                style: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            if (loading) CircularProgressIndicator(),
          ],
        ),
    );
  }
  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
