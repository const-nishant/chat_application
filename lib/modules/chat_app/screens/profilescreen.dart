// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../exports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void logout() {
    final authServices = Authservices();
    authServices.logout();
  }

  final userservices = UserService();

  File? _image;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> uploadImage() async {
    if (_image != null) {
      await userservices.uploadimage(_image!);
      setState(() {
        _image = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _image = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: const Text(
          'Profile',
        ),
        centerTitle: true,
        actions: [
          _image != null
              ? IconButton(
                  onPressed: () async {
                    await uploadImage();
                  },
                  icon: const Icon(Icons.save),
                )
              : Container(),
        ],
      ),
      drawer: const CommonDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
            stream: userservices.getcurrentuserstream(),
            builder: (context, snapshot) {
              //error
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
              //loading..
              else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              //return profile
              else {
                final userData = snapshot.data!;
                List<UserInfo> users =
                    userData.map((map) => UserInfo.fromMap(map)).toList();
                UserInfo user = users.first;
                return Column(
                  children: [
                    //profile picture
                    Center(
                      child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                    radius: 54,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: _image != null
                                        ? FileImage(_image!)
                                        : user.profileImage != null
                                            ? NetworkImage(user.profileImage)
                                            : null,
                                    child: user.profileImage == null
                                        ? Icon(
                                            Icons.person,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            size: 50,
                                          )
                                        : null),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 40,
                                    width: 34,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                      shape: BoxShape.circle,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      size: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    const SizedBox(height: 16.0),
                    //username
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.rectangle,
                      ),
                      margin: const EdgeInsets.all(12.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.person_2_outlined,
                          size: 32,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        title: Text(
                          user.username,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                    //email
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.rectangle,
                      ),
                      margin: const EdgeInsets.all(12.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.email_outlined,
                          size: 32,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        title: Text(
                          user.email,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                    //phone
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.rectangle,
                      ),
                      margin: const EdgeInsets.all(12.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.phone,
                          size: 32,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        title: Text(
                          "+91 ${user.phone}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                    //logout
                    GestureDetector(
                      onTap: logout,
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.rectangle,
                        ),
                        margin: const EdgeInsets.all(12.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.logout,
                            size: 32,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
