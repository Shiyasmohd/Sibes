// import 'dart:html';
// import 'dart:io';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodie/Models/food_model.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ScreenCreate extends StatefulWidget {
  const ScreenCreate({Key? key}) : super(key: key);

  @override
  _ScreenCreateState createState() => _ScreenCreateState();
}

class _ScreenCreateState extends State<ScreenCreate> {
  final TextEditingController _foodName = TextEditingController();
  // final TextEditingController _foodType = TextEditingController();
  late String type = "all";
  bool? _veg = false;
  // final String _time = DateTime.now().toString();
  // late final File _imageFile;
  final TextEditingController _contents = TextEditingController();
  final TextEditingController _hotelName = TextEditingController();
  final TextEditingController _no = TextEditingController();
  // final TextEditingController _noBooked = TextEditingController();
  // late final int _noInt;
  final ImagePicker picker = ImagePicker();
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    const Widget s1 = SizedBox(
      height: 45,
    );

    final _foodNameField = TextFormField(
        autofocus: false,
        controller: _foodName,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Food  Name cannot be Empty");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Food Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final _hotelNameField = TextFormField(
        autofocus: false,
        controller: _hotelName,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Hotel Name cannot be Empty");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Hotel Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final vegField = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Radio(
            value: true,
            groupValue: _veg,
            onChanged: (newValue) {
              print(newValue);
              setState(() {
                _veg = true;
              });
            }),
        const Text("Veg"),
        const SizedBox(
          width: 10,
        ),
        Radio(
            value: false,
            groupValue: _veg,
            onChanged: (newValue) {
              print(newValue);
              setState(() {
                _veg = false;
              });
            }),
        const Text("Non-Veg")
      ],
    );

    final noField = TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return ("No of meals cannot be empty");
          }
          return null;
        },
        autofocus: false,
        controller: _no,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "No of meals available",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final contents = TextFormField(
        autofocus: false,
        controller: _contents,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Contents cannot be Empty");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Contents Provided in one meal",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final photoView = Column(
      children: [
        InkWell(
            onTap: selectPhoto,
            child: imageUrl != null
                ? Image(
                    image: NetworkImage(imageUrl!),
                    height: 200,
                    width: 200,
                  )
                : const Icon(
                    Icons.ac_unit,
                    size: 200,
                  )),
        InkWell(
          onTap: selectPhoto,
          child: Row(
            children: [
              const Icon(Icons.camera),
              SizedBox(
                width: 10,
              ),
              Text(
                imageUrl != null ? "Change Photo" : "select Photo",
              ),
            ],
          ),
        )
      ],
    );

    final submitButton =
        TextButton(onPressed: _handleSubmit, child: const Text("Submit"));

    return Scaffold(
        appBar: AppBar(
          title: const Text("Add food"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                photoView,
                s1,
                _foodNameField,
                s1,
                _hotelNameField,
                s1,
                noField,
                s1,
                contents,
                s1,
                vegField,
                submitButton
              ],
            ),
          ),
        ));
  }

  void selectPhoto() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.camera),
                      title: const Text(
                        "camera",
                        style: TextStyle(fontSize: 20),
                      ),
                      onTap: () async {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.camera);
                        // final _imageFile = await picker.pickImage(
                        //     source: ImageSource.camera, imageQuality: 50);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.ac_unit_outlined),
                      title: const Text(
                        "Gallery",
                        style: TextStyle(fontSize: 20),
                      ),
                      onTap: () async {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.gallery);
                        // final _imageFile = await picker.pickImage(
                        //     source: ImageSource.camera, imageQuality: 50);
                      },
                    )
                  ],
                );
              });
        });
  }

  Future _pickImage(ImageSource source) async {
    final _pickedFile =
        await picker.pickImage(source: source, imageQuality: 50);
    if (_pickedFile == null) {
      return;
    }
    setState(() {
      imageUrl = "https://cdn.dribbble.com/users/760347/screenshots/7341673/media/b5af68cdf397db3063f89e5b466aab11.gif";
    });
    var file = await ImageCropper.cropImage(
        sourcePath: _pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 2));
    if (file == null) {
      return;
    }
    // file = (await compressImage(file.path, 35));
    await _uploadFile(file.path);
  }

  compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');
    final result = await compressImage(path, quality);
    print("image Compresssed");
    return result!;
  }

  Future _uploadFile(String path) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    final ref = storage
        .ref()
        .child('images')
        .child('${DateTime.now().toIso8601String() + p.basename(path)}');
    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    setState(() {
      imageUrl = fileUrl;
    });
  }

  void _handleSubmit() async {
    final _auth = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    if (imageUrl == null ||
        _foodName.text.isEmpty ||
        _contents.text.isEmpty ||
        _hotelName.text.isEmpty ||
        _auth == null ||
        _no.text.isEmpty) return;
    final String _uid = _auth.uid;
    final _nos = _no.text;
    final parserNo = int.tryParse(_nos);
    FoodModel _temp = FoodModel(
        "none",
        _foodName.text,
        type,
        DateTime.now().toString(),
        imageUrl!,
        _uid,
        _veg!,
        _hotelName.text,
        _contents.text,
        parserNo!,
        0,[]);
    final _ids =
        await firebaseFirestore.collection("products").add(_temp.toMap());
    final String f1 = _ids.id;
    FoodModel _temp1 = FoodModel(
        f1,
        _foodName.text,
        type,
        DateTime.now().toString(),
        imageUrl!,
        _uid,
        _veg!,
        _hotelName.text,
        _contents.text,
        parserNo,
        0,[]);
    await firebaseFirestore
        .collection("products")
        .doc(f1)
        .update(_temp1.toMap());
    Fluttertoast.showToast(msg: "ThankYou For contributing  ");
    Navigator.pushReplacementNamed(context, '/');
  }
}
