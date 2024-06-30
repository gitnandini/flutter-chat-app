import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  //a property
  final void Function(File pickedImage) imagePickFn;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  void _pickImage() async {
    final pickedImageFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedImageFile != null) {
      final pickedImage = File(pickedImageFile.path);
      setState(() {
        // _pickedImage = File(pickedImageFile.path);
        //_pickedImage = pickedImageFile;
        _pickedImage = pickedImage;
      });

      widget.imagePickFn(pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          // backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor, // background color
          ),
        ),
      ],
    );
  }
}
