import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editing/widgets/edit_image_viewmodel.dart';
import 'package:screenshot/screenshot.dart';

import '../widgets/image_text.dart';

class EditImageScreen extends StatefulWidget {
  final String selectedImage;
  const EditImageScreen({
    super.key,
    required this.selectedImage,
  });

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              children: [
                _selectedImage,
                for (int i = 0; i < texts.length; i++)
                  Positioned(
                    left: texts[i].left,
                    top: texts[i].top,
                    child: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          currentIndex = i;
                          removeText(context);
                        });
                      },
                      onTap: () => setCurrentIndex(context, i),
                      child: Draggable(
                        feedback: ImageText(textInfo: texts[i]),
                        child: ImageText(textInfo: texts[i]),
                        onDragEnd: (drag) {
                          final renderBox =
                              context.findRenderObject() as RenderBox;
                          Offset off = renderBox.globalToLocal(drag.offset);
                          setState(() {
                            texts[i].top = off.dy - 96;
                            texts[i].left = off.dx;
                          });
                        },
                      ),
                    ),
                  ),
                creatorText.text.isNotEmpty
                    ? Positioned(
                        child: Text(
                          creatorText.text,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _addNewTextFAB,
    );
  }

  Widget get _selectedImage => Center(
        child: Image.file(
          File(
            widget.selectedImage,
          ),
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
        ),
      );

  Widget get _addNewTextFAB => FloatingActionButton(
        onPressed: () {
          addNewDialog(context);
        },
        //  => addNewDialog(context),
        backgroundColor: Colors.white,
        tooltip: "Add New Text",
        child: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
      );
  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              IconButton(
                onPressed: saveToGallery(context),
                icon: const Icon(
                  Icons.save,
                  color: Colors.black,
                ),
                tooltip: 'Save Image',
              ),
              IconButton(
                onPressed: increaseFontSize,
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                tooltip: 'Increase Font Size',
              ),
              IconButton(
                onPressed: decreaseFontSize,
                icon: const Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
                tooltip: 'Decrease Font Size',
              ),
              IconButton(
                onPressed: alignLeft,
                icon: const Icon(
                  Icons.format_align_left,
                  color: Colors.black,
                ),
                tooltip: 'Align Left',
              ),
              IconButton(
                onPressed: alignCenter,
                icon: const Icon(
                  Icons.format_align_center,
                  color: Colors.black,
                ),
                tooltip: 'Align Center',
              ),
              IconButton(
                onPressed: alignRight,
                icon: const Icon(
                  Icons.format_align_right,
                  color: Colors.black,
                ),
                tooltip: 'Align Right',
              ),
              IconButton(
                onPressed: boldText,
                icon: const Icon(
                  Icons.format_bold,
                  color: Colors.black,
                ),
                tooltip: 'Bold',
              ),
              IconButton(
                onPressed: itallicText,
                icon: const Icon(
                  Icons.format_italic,
                  color: Colors.black,
                ),
                tooltip: 'Itallic',
              ),
              IconButton(
                onPressed: addLinesToText,
                icon: const Icon(
                  Icons.space_bar,
                  color: Colors.black,
                ),
                tooltip: 'Add new Line',
              ),
              Tooltip(
                message: "Red",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.red),
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "White",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.white),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Black",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.black),
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Blue",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.blue),
                  child: const CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Yellow",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.yellow),
                  child: const CircleAvatar(
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Green",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.green),
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Orange",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.orange),
                  child: const CircleAvatar(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Pink",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.pink),
                  child: const CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      );
}
