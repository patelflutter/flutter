import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../Custom_Widget/custom_mediamButton.dart';
import '../Custom_Widget/responsiveHeigh_Width.dart';
import 'package:file_picker/file_picker.dart';

class MyJoin extends StatefulWidget {
  const MyJoin({Key? key}) : super(key: key);

  @override
  State<MyJoin> createState() => _MyJoinState();
}

class _MyJoinState extends State<MyJoin> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  String? _pdfPath;

  ///File? _imageFile;
  var _pdfFile;
  Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6956F0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Career",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 0.05,
                        blurRadius: 3,
                      )
                    ],
                    borderRadius: BorderRadius.circular(9)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Name",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getMediaQueryHeight(context: context, value: 15),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 0.05,
                        blurRadius: 3,
                      )
                    ],
                    borderRadius: BorderRadius.circular(9)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Mobile",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getMediaQueryHeight(context: context, value: 15),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 0.05,
                        blurRadius: 3,
                      )
                    ],
                    borderRadius: BorderRadius.circular(9)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getMediaQueryHeight(context: context, value: 15),
              ),
              DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                padding: EdgeInsets.all(6),
                child: InkWell(
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );
                    if (result != null) {
                      PlatformFile file = result.files.first;
                      setState(() {
                        _pdfFile = File(file.path!);
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    color: Color(0xFFF2FA95).withOpacity(0.5),
                    child: Column(
                      children: [
                        _pdfFile != null
                            ? Text(
                                _pdfFile.path,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFCCCBCB),
                                ),
                              )
                            : Icon(
                                Icons.upload_file,
                                size: 30,
                                color: Color(0xFFCCCBCB),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            _pdfFile == null
                                ? "Upload Your PDF"
                                : "Selected PDF: ${_pdfFile.path}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFCCCBCB),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getMediaQueryHeight(context: context, value: 15),
              ),
              CustomContainerMediamButton(
                buttonText: 'Submit',
                onTap: onTap,
              )
            ],
          ),
        ),
      )),
    );
  }

  void onTap() async {
    if (_pdfFile != null) {
      FormData formData = FormData.fromMap({
        "name": nameController.text,
        "email": emailController.text,
        "mobile": mobileController.text,
        "file": await MultipartFile.fromFile(_pdfFile!.path,
            filename: _pdfFile!.path.split('/').last),
      });

      Dio dio = Dio();
      Response response = await dio.post(
        'https://armaan.pythonanywhere.com/api/JobEnquiry/',
        data: formData,
      );

      if (response.statusCode == 200) {
        // Do something on success
      } else {
        // Do something on failure
      }
    } else {
      // Handle case where _pdfFile is null
    }
  }
}
