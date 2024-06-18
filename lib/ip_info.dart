import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(IpInfo());
}

class IpInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IP Info App',
      home: IpPage(),
    );
  }
}

class IpPage extends StatefulWidget {
  @override
  _IpPageState createState() => _IpPageState();
}

class _IpPageState extends State<IpPage> {
  String ipAddress = '';
  String city = '';
  String region = '';
  String country = '';
  String location = '';
  String organization = '';
  String postalCode = '';
  String timezone = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://ipinfo.io/json'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          ipAddress = jsonData['ip'];
          city = jsonData['city'];
          region = jsonData['region'];
          country = jsonData['country'];
          location = jsonData['loc'];
          organization = jsonData['org'];
          postalCode = jsonData['postal'];
          timezone = jsonData['timezone'];
        });
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP Info App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('IP-Adresse: $ipAddress'),
            SizedBox(height: 16),
            Text('Stadt: $city'),
            SizedBox(height: 8),
            Text('Region: $region'),
            SizedBox(height: 8),
            Text('Land: $country'),
            SizedBox(height: 8),
            Text('Breitengrad/Längengrad: $location'),
            SizedBox(height: 8),
            Text('Organisation: $organization'),
            SizedBox(height: 8),
            Text('Postleitzahl: $postalCode'),
            SizedBox(height: 8),
            Text('Zeitzone: $timezone'),
          ],
        ),
      ),
    );
  }
}