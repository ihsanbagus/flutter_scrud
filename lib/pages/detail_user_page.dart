import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class DetailUser extends StatefulWidget {
  static String routeName = "/detail";

  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  @override
  Widget build(BuildContext context) {
    var userId = ModalRoute.of(context)!.settings.arguments as String;
    final _user =
        Provider.of<UserProvider>(context, listen: false).selectUser(userId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DETAIL",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 10,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(_user.avatar),
                ),
                Text(
                  _user.nama,
                  style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  width: 100,
                  height: 5,
                ),
                Text(_user.email),
                Text(_user.alamat),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
