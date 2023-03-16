// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExpertDataWidget extends StatefulWidget {
  final String expertId;
  final String? expertname;

  ExpertDataWidget({required this.expertId, this.expertname});

  @override
  _ExpertDataWidgetState createState() => _ExpertDataWidgetState();
}

class _ExpertDataWidgetState extends State<ExpertDataWidget> {
  Map<String, dynamic> expertData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://armaan.pythonanywhere.com/api/Expert/${widget.expertId}'));
    if (response.statusCode == 200) {
      setState(() {
        expertData = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load expert data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expert data for ID ${widget.expertname}'),
      ),
      body: expertData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username: ${expertData['admin']['username']}'),
                  Text('Expert ID: ${expertData['expert_id']}'),
                  Text('Present Address: ${expertData['present_address']}'),
                  Text('Status: ${expertData['status']}'),
                  // Add other fields as needed
                ],
              ),
            ),
    );
  }
}

// class DashboardScreen extends StatefulWidget {


//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   Map<String, dynamic> expertData = {};

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final response = await http
//         .get(Uri.parse('http://armaan.pythonanywhere.com/api/Expert/19'));
//     if (response.statusCode == 200) {
//       setState(() {
//         expertData = jsonDecode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Expert Dashboard'),
//       ),
//       body: expertData.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Username: ${expertData['admin']['username']}'),
//                   Text('Expert ID: ${expertData['expert_id']}'),
//                   Text('Present Address: ${expertData['present_address']}'),
//                   Text('Status: ${expertData['status']}'),
//                   Text(
//                       'Joining Date: ${expertData['joining_date'] ?? 'Not available'}'),
//                 ],
//               ),
//             ),
//     );
//   }
// }


// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// // Define your model classes outside of your widget class
// class TotalProduct {
//   final int id;
//   final String mobile;
//   final String expertId;
//   final String highestQualification;
//   final String state;
//   final String city;
//   final String status;

//   TotalProduct({
//     required this.id,
//     required this.mobile,
//     required this.expertId,
//     required this.highestQualification,
//     required this.state,
//     required this.city,
//     required this.status,
//   });

//   // Define a factory method to convert the JSON response to your model object
//   factory TotalProduct.fromJson(Map<String, dynamic> json) {
//     return TotalProduct(
//       id: json["id"],
//       mobile: json["mobile"],
//       expertId: json["expert_id"],
//       highestQualification: json["highest_qualification"],
//       state: json["state"],
//       city: json["city"],
//       status: json["status"],
//     );
//   }
// }

// class DashBords extends StatefulWidget {
//   const DashBords({Key? key}) : super(key: key);

//   @override
//   _DashBordsState createState() => _DashBordsState();
// }

// class _DashBordsState extends State<DashBords> {
//   TotalProduct? _user; // Declare a variable to hold your user object

//   Future<TotalProduct?> getProfile(int id) async {
//     final response = await http.get(
//       Uri.parse('https://armaan.pythonanywhere.com/api/Expert/$id'),
//       headers: {
//         'Accept': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       print(response.statusCode);
//       if (response.body.isNotEmpty) {
//         // Pass response.body directly to the fromJson method
//         final user = TotalProduct.fromJson(json.decode(response.body));
//         return user;
//       }
//     }
//     return null;
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Call the getProfile() method to retrieve the user data
//     getProfile(1).then((user) {
//       setState(() {
//         _user = user;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//       ),
//       body: _user != null
//           ? Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Name: ${_user!.mobile}'),
//                 Text('Expert ID: ${_user!.expertId}'.toString()),
//                 Text('Qualification: ${_user!.highestQualification}'),
//                 Text('State: ${_user!.state}'),
//                 Text('City: ${_user!.city}'),
//                 Text('Status: ${_user!.status}'),
//               ],
//             )
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
// }
