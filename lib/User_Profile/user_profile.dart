import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homofix/Custom_Widget/textStyle.dart';
import 'package:homofix/dashbord.dart';
import 'package:image_picker/image_picker.dart';
import '../Custom_Widget/custom_mediamButton.dart';
import '../Custom_Widget/responsiveHeigh_Width.dart';
import 'package:dotted_border/dotted_border.dart';
import "package:http/http.dart" as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';

class UserPeofileVew extends StatefulWidget {
  final String expertId;
  final String expertname;

  const UserPeofileVew(
      {Key? key, required this.expertId, required this.expertname})
      : super(key: key);

  @override
  State<UserPeofileVew> createState() => _UserPeofileVewState();
}

class _UserPeofileVewState extends State<UserPeofileVew> {
  bool showSpiner = false;
  int? state = 0;
  int? id;
  Map<String, dynamic> expertData = {};
  String dropdownValue = 'Aadhaar Card';
  File? _image;
  bool isLoading = true;
  File? pickedImage;

  void imagePickerOption(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: SingleChildScrollView(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Container(
                color: Colors.white,
                height: getMediaQueryHeight(context: context, value: 250),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Pick Image From",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          pickImage(ImageSource.camera);
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text("CAMERA"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          pickImage(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.image),
                        label: const Text("GALLERY"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                        label: const Text("CANCEL"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;

      File tempImage = File(photo.path);

      // Resize and compress the image
      Uint8List? compressedImage = await FlutterImageCompress.compressWithFile(
        tempImage.path,
        quality: 80, // Adjust the quality as per your requirement
      );

      tempImage = await tempImage.writeAsBytes(compressedImage!);

      setState(() {
        pickedImage = tempImage;
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // late TextEditingController _nameController,
  TextEditingController _nameController = TextEditingController();
  TextEditingController _fatherController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _paraAddController = TextEditingController();
  TextEditingController _serAreaController = TextEditingController();
  TextEditingController _highQulController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _JoiningController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(
        'https://support.homofixcompany.com/api/Expert/${widget.expertId}/'));
    if (response.statusCode == 200) {
      print(response.statusCode);
      setState(() {
        showSpiner = true;
        expertData = jsonDecode(response.body);
        _nameController.text = widget.expertname;
        _fatherController.text = expertData['Father_name'].toString();
        _categoryController.text = expertData['category'].toString();
        _mobileController.text = expertData['mobile'].toString();
        _paraAddController.text = expertData['permanent_address'].toString();
        _serAreaController.text = expertData['serving_area'].toString();
        _highQulController.text =
            expertData['highest_qualification'].toString();
        _cityController.text = expertData['city'].toString();
        _stateController.text = expertData['state'].toString();
        _JoiningController.text = expertData['joining_date'].toString();
        _idController.text = expertData['Id_Proof'].toString();
      });
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load expert data');
    }
  }

  Future<void> post() async {
    // setState(() {
    //   isLoading = true;
    // });

    if (pickedImage != null) {
      await uploadImage();
    }

    final activityData = {
      'id': widget.expertId,
      'mobile': _mobileController.text,
    };

    final response = await http.patch(
      Uri.parse(
          "https://support.homofixcompany.com/api/Expert/${widget.expertId}/"),
      body: jsonEncode(activityData),
      headers: {
        "content-type": "application/json",
      },
    );

    try {
      setState(() {
        isLoading = false;
      });
      print("ok");
      Fluttertoast.showToast(
        msg: "Form Update Successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
      Fluttertoast.showToast(
        msg: "Form Update Error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> uploadImage() async {
    // setState(() {
    //   isLoading = true;
    // });

    try {
      var uri = Uri.parse(
          'https://support.homofixcompany.com/api/Expert/${widget.expertId}/');
      var headers = {
        'Content-Type': 'multipart/form-data',
      };
      FormData formData = FormData.fromMap({
        'profile_pic': await MultipartFile.fromFile(
          pickedImage!.path,
          filename: pickedImage!.path.split('/').last,
        ),
      });

      Dio dio = Dio();
      dio.options.headers = headers;

      var response = await dio.patch(uri.toString(), data: formData);

      // setState(() {
      //   isLoading = false;
      // });

      if (response.statusCode == 200) {
        print("Image Uploaded Successfully");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashBord()),
        );
      } else {
        print("Failed to upload image");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fatherController = TextEditingController();
    _mobileController = TextEditingController();

    fetchData();
  }

  // @override
  // void dispose() {
  //   _mobileFocusNode.dispose();
  //   _fatherController.dispose();
  //   _mobileController.dispose();
  //   super.dispose();
  // }

  final _mobileFocusNode = FocusNode();
  bool _isButtonVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff002790),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.expertname.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.black))
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xff002790),
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child: pickedImage != null
                                    ? Image.file(
                                        pickedImage!,
                                        fit: BoxFit.fill,
                                      )
                                    : expertData['profile_pic'] != null
                                        ? Image.network(
                                            expertData['profile_pic'],
                                            fit: BoxFit.fill,
                                          )
                                        : Center(
                                            child: Icon(
                                            FontAwesomeIcons.user,
                                            size: 80,
                                            color: Color(0xFFF3F2F2),
                                          )),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Color(0xff002790),
                                child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: InkWell(
                                            onTap: () {
                                              pickImage(ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                            child: CustomContainerSmallButton(
                                              buttonText: 'From Camera',
                                              onTap: () {
                                                //  pickImage(ImageSource.camera);
                                              },
                                            ),
                                          ),
                                          content: InkWell(
                                            onTap: () {
                                              pickImage(ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                            child: CustomContainerSmallButton(
                                              buttonText: 'From Gallery',
                                              onTap: () {},
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                // Add button logic here
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "UPLOAD",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff002790)),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "CANCEL",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff002790),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height:
                            getMediaQueryHeight(context: context, value: 20),
                      ),
                      Text(
                        "ID",
                        style: customSmallTextStyle,
                      ),
                      Text(
                        expertData['expert_id'],
                        style: customTextStyle,
                      ),
                      SizedBox(
                        height:
                            getMediaQueryHeight(context: context, value: 20),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("User name :"),
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 10),
                          ),
                          Container(
                            width: double.infinity,
                            // height: 45,
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
                                  controller: _nameController,
                                  enabled: true,
                                  readOnly: true,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    // hintStyle: GoogleFonts.poppins(
                                    //     fontSize: 14,
                                    //     fontWeight: FontWeight.normal),
                                    border: InputBorder.none,
                                    hintText: "name",
                                  )
                                  //  label: Text("raviranjan510")),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            getMediaQueryHeight(context: context, value: 15),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Father Name :"),
                          SizedBox(
                            height:
                                getMediaQueryHeight(context: context, value: 5),
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
                                readOnly: true,
                                controller: _fatherController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  // hintStyle: GoogleFonts.poppins(
                                  //     fontSize: 14,
                                  //     fontWeight: FontWeight.normal),
                                  border: InputBorder.none,
                                  hintText: "Father Name",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            getMediaQueryHeight(context: context, value: 15),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Category :"),
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 10),
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
                                controller: _categoryController,
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  // hintStyle: GoogleFonts.poppins(
                                  //     fontSize: 14,
                                  //     fontWeight: FontWeight.normal),
                                  border: InputBorder.none,
                                  hintText: "Category",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 15),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Mobile :"),
                              SizedBox(
                                height: getMediaQueryHeight(
                                    context: context, value: 10),
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
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: _mobileController,
                                    maxLength: 10,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Mobile  Number';
                                      } else if (value.length < 10) {
                                        return 'Please enter a 10 digit number';
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      setState(() {
                                        _isButtonVisible = false;
                                      });
                                    },
                                    onFieldSubmitted: (_) {
                                      setState(() {
                                        _isButtonVisible = true;
                                      });
                                    },
                                    focusNode: _mobileFocusNode,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      suffixIcon: Icon(Icons.edit),
                                      // hintStyle: GoogleFonts.poppins(
                                      //     fontSize: 14,
                                      //     fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      hintText: "Mobile",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 15),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Present Address :"),
                              SizedBox(
                                height: getMediaQueryHeight(
                                    context: context, value: 10),
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
                                    controller: _paraAddController,
                                    readOnly: true,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      // hintStyle: GoogleFonts.poppins(
                                      //     fontSize: 14,
                                      //     fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      hintText: "Present Address",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 15),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("ID Proof :"),
                              SizedBox(
                                height: getMediaQueryHeight(
                                    context: context, value: 10),
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
                                    controller: _idController,
                                    readOnly: true,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      // hintStyle: GoogleFonts.poppins(
                                      //     fontSize: 14,
                                      //     fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      hintText: "ID ",
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       boxShadow: [
                              //         BoxShadow(
                              //           color: Colors.black.withOpacity(0.5),
                              //           spreadRadius: 0.05,
                              //           blurRadius: 3,
                              //         )
                              //       ],
                              //       borderRadius: BorderRadius.circular(9)),
                              //   child: Padding(
                              //     padding: EdgeInsets.symmetric(horizontal: 10),
                              //     child: DropdownButtonFormField<String>(
                              //       value: dropdownValue,
                              //       onChanged: (String? newValue) {
                              //         setState(() {
                              //           dropdownValue = newValue!;
                              //         });
                              //       },
                              //       items: <String>[
                              //         'Aadhaar Card',
                              //         'PAN Card',
                              //         'Driving License',
                              //       ].map<DropdownMenuItem<String>>((String value) {
                              //         return DropdownMenuItem<String>(
                              //           value: value,
                              //           child: Text(value),
                              //         );
                              //       }).toList(),
                              //       decoration: InputDecoration(
                              //         // hintStyle: GoogleFonts.poppins(
                              //         //     fontSize: 14,
                              //         //     fontWeight: FontWeight.normal),
                              //         border: InputBorder.none,
                              //         hintText: "Select your ID",
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 15),
                          ),
                          DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(12),
                            padding: EdgeInsets.all(6),
                            child: Container(
                              width: double.infinity,
                              color: Color(0xFFF2FA95).withOpacity(0.5),
                              child: _image == null
                                  ? expertData['id_proof_document'] != null
                                      ? Image.network(
                                          expertData['id_proof_document'],
                                          width: getMediaQueryWidth(
                                              context: context, value: 150),
                                          height: getMediaQueryHeight(
                                              context: context, value: 190),
                                          fit: BoxFit.fill,
                                        )
                                      : Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.image,
                                                color: Colors.grey,
                                                size: 35,
                                              ),
                                              Text(
                                                'No Image',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        )
                                  : Image.file(
                                      _image!,
                                      fit: BoxFit.contain,
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 15),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ratting :"),
                              SizedBox(
                                height: getMediaQueryHeight(
                                    context: context, value: 10),
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
                                    readOnly: true,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                        // hintStyle: GoogleFonts.poppins(
                                        //     fontSize: 14,
                                        //     fontWeight: FontWeight.normal),
                                        border: InputBorder.none,
                                        hintText: "* * *",
                                        hintStyle: TextStyle(
                                            fontSize: 24, color: Colors.black)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 15),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Serving Area :"),
                              SizedBox(
                                height: getMediaQueryHeight(
                                    context: context, value: 10),
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
                                    controller: _serAreaController,
                                    readOnly: true,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      // hintStyle: GoogleFonts.poppins(
                                      //     fontSize: 14,
                                      //     fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      hintText: "",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 15),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Highest Qualification :"),
                              SizedBox(
                                height: getMediaQueryHeight(
                                    context: context, value: 10),
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
                                    readOnly: true,
                                    controller: _highQulController,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      // hintStyle: GoogleFonts.poppins(
                                      //     fontSize: 14,
                                      //     fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      hintText: "",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 15),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("City :"),
                              SizedBox(
                                height: getMediaQueryHeight(
                                    context: context, value: 10),
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
                                    controller: _cityController,
                                    readOnly: true,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      // hintStyle: GoogleFonts.poppins(
                                      //     fontSize: 14,
                                      //     fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      hintText: "",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 15),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("State :"),
                              SizedBox(
                                height: getMediaQueryHeight(
                                    context: context, value: 10),
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
                                    controller: _stateController,
                                    readOnly: true,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      // hintStyle: GoogleFonts.poppins(
                                      //     fontSize: 14,
                                      //     fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      hintText: "",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 15),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Joining Date :"),
                              SizedBox(
                                height: getMediaQueryHeight(
                                    context: context, value: 10),
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
                                    controller: _JoiningController,
                                    readOnly: true,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      // hintStyle: GoogleFonts.poppins(
                                      //     fontSize: 14,
                                      //     fontWeight: FontWeight.normal),
                                      border: InputBorder.none,
                                      hintText: "",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            getMediaQueryHeight(context: context, value: 25),
                      ),
                      Visibility(
                        visible: _isButtonVisible,
                        child: CustomContainerMediamButton(
                            buttonText: 'Save Change',
                            onTap: () async {
                              //  async {
                              await post();
                            }
                            // {
                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return AlertDialog(
                            //         content: SingleChildScrollView(
                            //           child: OtpView(
                            //             expertId: _userId,
                            //             expertname: _username,
                            //           ),
                            //         ),
                            //       );
                            //     });

                            // }
                            // async {
                            //   await post();
                            // },
                            ),
                      ),
                      SizedBox(
                        height:
                            getMediaQueryHeight(context: context, value: 25),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
