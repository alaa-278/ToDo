import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fast_color_picker/fast_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/database_service.dart';
import 'package:todo_app/screens/text_form_field_screen.dart';

import '../models/constants.dart';
import '../models/note.dart';

class AddNote extends StatefulWidget {
  AddNote({Key? key, this.previousNote}) : super(key: key);

  final Note? previousNote;
  var formKey = GlobalKey<FormState>();
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late SharedPreferences prefs;
  String? time;
  Uint8List? bytes;
  File? file;
  late Note newNote;
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  late TextEditingController title;
  late TextEditingController disc;

  @override
  void initState() {
    title = TextEditingController(text: widget.previousNote?.title);
    disc = TextEditingController(text: widget.previousNote?.description);
    newNote = widget.previousNote ?? Note.emptyNote();
    super.initState();
    if (widget.previousNote != null) {
      selectedDateController.text =
          intl.DateFormat.yMMMd().format(widget.previousNote!.dateTime);
    }
  }

  final TextEditingController selectedDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Color(0xff407BFF)),
      height: Get.height * 0.6,
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Text(
                    widget.previousNote == null ? "Add Note" : "Edit Note",
                    style: Themes.StyleThree),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: CustomTextFormField(
                  validator: (String? value1) {
                    if (value1!.isEmpty) {
                      return 'You must enter your email Title of note';
                    }
                  },
                  controller: title,
                  labelText: 'Title',
                  onSaved: (text) {
                    newNote.title = text!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: CustomTextFormField(
                  validator: (String? value1) {
                    if (value1!.isEmpty) {
                      return 'You must enter the description';
                    }
                  },
                  controller: disc,
                  labelText: 'Note',
                  onSaved: (text) {
                    newNote.description = text!;
                  },
                ),
              ),
              InkWell(
                onTap: () async {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime:
                      DateTime.now().subtract(Duration(days: 10 * 365)),
                      maxTime: DateTime.now().add(Duration(days: 10 * 365)),
                      onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.en)
                      .then((value) {
                    if (value != null) {
                      newNote.dateTime = value;
                      selectedDateController.text =
                          intl.DateFormat.yMd().add_jm().format(value);
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: IgnorePointer(
                    ignoring: true,
                    child: CustomTextFormField(
                      validator: (String? value1) {
                        if (value1!.isEmpty) {
                          return 'You must enter the time';
                        }
                      },
                      controller: selectedDateController,
                      labelText: 'Selected Time',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  ImagePicker()
                      .pickImage(source: ImageSource.gallery)
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        file = File(value.path);
                        final bytes = file!.readAsBytesSync();
                        String base64Image = base64Encode(bytes);
                        newNote.base64Image = base64Image;
                      });
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_a_photo_rounded,
                        size: 20,
                        color: Get.isDarkMode ? Colors.black : Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "pick Image",
                        style: Themes.StyleThree,
                      ),
                    ],
                  ),
                ),
              ),
              if (file != null) Image.file(file!),
              if (bytes != null) Image.memory(bytes!),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: TextButton(
                  onPressed: () {
                        (color) {
                      newNote.color = color;
                    };
                  },
                  child: FastColorPicker(
                    selectedColor: newNote.color,
                    onColorSelected: (color) {
                      setState(() {
                        newNote.color = color;
                      });
                    },
                  ),
                ),
              ),
              Center(
                child: CupertinoButton(
                  child: Text('Save', style: Themes.StyleTwo),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (widget.previousNote == null) {
                        Get.find<DatabaseController>().addNote(newNote);
                      } else {
                        Get.find<DatabaseController>().editNote(newNote);
                      }
                      Get.back();
                      Get.appUpdate();
                    } else {
                      Get.snackbar('Something Wrong', 'Incorrect Data',
                          backgroundColor:
                          Get.isDarkMode ? Colors.black : Colors.white);
                    }
                  },
                  color: Get.theme.cardColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
