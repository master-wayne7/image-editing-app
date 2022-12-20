import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_editing/models/text_info.dart';
import 'package:image_editing/screens/edit_imageScreen.dart';
import 'package:image_editing/widgets/default_button.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../utils/utils.dart';

abstract class EditImageViewModel extends State<EditImageScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  List<TextInfo> texts = [];
  int currentIndex = 0;

  saveToGallery(BuildContext context) {
    if (texts.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Image saved to gallery"),
          ),
        );
        saveImage(image!);
      }).catchError((err) => print(err));
    }
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Text"),
          content: TextField(
            controller: textEditingController,
            maxLines: 5,
            decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.edit,
              ),
              filled: true,
              hintText: "Enter text here...",
            ),
          ),
          actions: [
            DefaultButton(
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.red,
              textColor: Colors.black,
              child: const Text("Back"),
            ),
            DefaultButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text("Add Text"),
              onPressed: () => addNewText(context),
            ),
          ],
        );
      },
    );
  }

  setCurrentIndex(context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Selected for styling',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    ));
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  alignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  alignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  alignCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  itallicText() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.italic) {
        texts[currentIndex].fontStyle = FontStyle.normal;
      } else {
        texts[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  addLinesToText() {
    setState(() {
      if (texts[currentIndex].text.contains('\n')) {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll('\n', ' ');
      } else {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  removeText(context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Deleted',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    ));
  }

  addNewText(BuildContext context) {
    setState(() {
      texts.add(
        TextInfo(
          color: Colors.black,
          fontSize: 20,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.normal,
          left: 0,
          text: textEditingController.text,
          textAlign: TextAlign.left,
          top: 0,
        ),
      );
    });
    Navigator.of(context).pop();
  }
}
