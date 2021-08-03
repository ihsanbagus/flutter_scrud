import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';

class AddUser extends StatefulWidget {
  static String routeName = "add_notes";
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    final dataUser = Provider.of<UserProvider>(context, listen: false);
    final TextEditingController tecA = TextEditingController();
    final TextEditingController tecN = TextEditingController();
    final TextEditingController tecE = TextEditingController();
    final TextEditingController tecD = TextEditingController();
    String userId = "";
    String title = "TAMBAH";
    String btnSubmit = "SIMPAN";
    bool isEdit = false;
    UserModel user;
    final _formKey = GlobalKey<FormState>();
    try {
      userId = ModalRoute.of(context)!.settings.arguments as String;
      user = dataUser.selectUser(userId);
      tecA.text = user.avatar;
      tecN.text = user.nama;
      tecE.text = user.email;
      tecD.text = user.alamat;
      title = "UBAH";
      btnSubmit = "UBAH";
      isEdit = true;
    } catch (e) {}
    return Scaffold(
      appBar: AppBar(title: Text(title, style: TextStyle(color: Colors.white))),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                controller: tecA,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "link avatar (optional)",
                    labelText: "Avatar"),
              ),
              Divider(height: 10),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Wajib Isi";
                  }
                },
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                controller: tecN,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "nama",
                    labelText: "Nama"),
              ),
              Divider(height: 10),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Wajib Isi";
                  }
                },
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                controller: tecE,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "email",
                    labelText: "Email"),
              ),
              Divider(height: 10),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Wajib Isi";
                  }
                },
                maxLines: 5,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.done,
                controller: tecD,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "alamat",
                    labelText: "Alamat"),
              ),
              Divider(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: OutlinedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (isEdit) {
                        dataUser
                            .patchUser(userId, tecN.text, tecE.text, tecD.text,
                                a: tecA.text)
                            .then((value) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("BERHASIL DIUBAH")));
                        });
                      } else {
                        dataUser
                            .postUser(tecN.text, tecE.text, tecD.text,
                                a: tecA.text)
                            .then((value) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("BERHASIL DITAMBAH")));
                        });
                      }
                    }
                  },
                  child: Text(btnSubmit),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
