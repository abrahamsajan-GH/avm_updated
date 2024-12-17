import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friend_private/backend/auth.dart';
import 'package:friend_private/backend/preferences.dart';
import 'package:friend_private/core/constants/constants.dart';
import 'package:friend_private/core/theme/app_colors.dart';
import 'package:friend_private/core/widgets/snackbar_util.dart';

class ChangeNameWidget extends StatefulWidget {
  const ChangeNameWidget({super.key});

  @override
  State<ChangeNameWidget> createState() => _ChangeNameWidgetState();
}

class _ChangeNameWidgetState extends State<ChangeNameWidget> {
  late TextEditingController nameController;
  User? user;
  bool isSaving = false;

  @override
  void initState() {
    user = getFirebaseUser();
    nameController = TextEditingController(text: user?.displayName ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const Text(
                'How AVM should call you?',
                style: TextStyle(fontSize: 16),
              ),
              h10,
              CupertinoTextField(
                controller: nameController,
                placeholderStyle: const TextStyle(color: AppColors.black),
                style: const TextStyle(color: AppColors.black),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            textStyle: const TextStyle(color: AppColors.red),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            textStyle: const TextStyle(color: AppColors.blue),
            onPressed: () {
              if (nameController.text.isEmpty ||
                  nameController.text.trim().isEmpty) {
                showSnackBar(message: 'Name cannot be empty', context: context);
                return;
              }
              SharedPreferencesUtil().givenName = nameController.text;
              updateGivenName(nameController.text);
              showSnackBar(
                  message: 'Name updated successfully!', context: context);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    } else {
      return AlertDialog(
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('How AVM should call you?'),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isEmpty ||
                  nameController.text.trim().isEmpty) {
                showSnackBar(message: 'Name cannot be empty', context: context);
                return;
              }
              SharedPreferencesUtil().givenName = nameController.text;
              updateGivenName(nameController.text);
              showSnackBar(
                  message: 'Name updated successfully!', context: context);
              Navigator.of(context).pop();
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      );
    }
  }
}
