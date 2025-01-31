import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

class DisplayTextPage extends StatefulWidget {
  final String marathiFilePath;
  final String hindiFilePath;

  DisplayTextPage({
    required this.marathiFilePath,
    required this.hindiFilePath,
  });

  @override
  _DisplayTextPageState createState() => _DisplayTextPageState();
}


class _DisplayTextPageState extends State<DisplayTextPage> {
  String selectedLanguage = 'Marathi';

  Future<String> _loadText(String filePath) async {
    try {
      String text = await DefaultAssetBundle.of(context).loadString(filePath);
      return text;
    } catch (error) {
      print('Error loading text from file: $filePath');
      print('Error details: $error');
      return 'Error loading text';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Description'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Add a dropdown for selecting language
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: DropdownButton<String>(
                value: selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLanguage = newValue!;
                  });
                },
                items: ['Marathi', 'Hindi'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            // Display the description based on the selected language
            FutureBuilder<String>(
              future: selectedLanguage == 'Marathi'
                  ? _loadText(widget.marathiFilePath)
                  : _loadText(widget.hindiFilePath),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return _buildDescriptionWidget(snapshot);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionWidget(AsyncSnapshot<String> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (snapshot.hasData) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          snapshot.data!,
          style: TextStyle(fontSize: 18),
        ),
      );
    } else if (snapshot.hasError) {
      return Center(
        child: Text('Error loading text'),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
