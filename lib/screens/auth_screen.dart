import 'dart:convert';
import 'dart:io';
import 'package:aws_s3_upload_lite/aws_s3_upload_lite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../utils/tools.dart';
import '../widgets/user_image_picker.dart';

const Url = 'http://10.0.2.2:3000/api/v1';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLogin = true;
  var _isAuthenticating = false;
  var _userEmail = '';
  var _userPassword = '';
  var _userName = '';
  var _telephoneNumber = '';
  var _organizationName = '';
  var _address = '';
  File? _selectedImage;

  final _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please fill out the form.'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return;
    }

    if (!_isLogin && _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please pick an image.'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      _isAuthenticating = true;
    });

    if (_isLogin) {
      try {
        logger.d(
            'Logging in with email: $_userEmail and password: $_userPassword');

        final response = await http.post(Uri.parse('$Url/auth/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': _userEmail,
              'password': _userPassword,
            }));
        final data = json.decode(response.body);
        logger.d(data);
      } catch (error) {
        var message =
            'An error occurred, logging in, please check your credentials!';

        logger.e(error);
        logger.e(message);

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      } finally {
        setState(() {
          _isAuthenticating = false;
        });
      }
    } else {
      // Sign user up
      return logger.d(_selectedImage!);

      try {
        var results = await AwsS3.uploadFile(
          file: File(_selectedImage!.path),
          bucket: dotenv.env['AWS_BUCKET_NAME']!,
          region: dotenv.env['AWS_REGION']!,
          accessKey: dotenv.env['AWS_ACCESSKEY_ID']!,
          secretKey: dotenv.env['AWS_SECRET_ACCESS_KEY']!,
          destDir: 'prodImages',
          filename: '',
        );

        final response = await http.post(Uri.parse('$Url/auth/signup'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': _userEmail,
              'password': _userPassword,
              'fullName': _userName,
              'telephoneNumber': _telephoneNumber,
              'address': _address,
              'organisation': _organizationName,
            }));
        final data = json.decode(response.body);
        logger.d(data);

        // final storageRef = FirebaseStorage.instance
        //     .ref()
        //     .child('user_images')
        //     .child('${userCredentials.user!.uid}.jpg');
        //
        // final result = await storageRef.putFile(_selectedImage!);
        // final imageUrl = await storageRef.getDownloadURL();
        // logger.d('Image URL: $imageUrl');
        //
        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(userCredentials.user!.uid)
        //     .set({
        //   'username': _userName,
        //   'email': _userEmail,
        //   'image_url': imageUrl,
        // });
        //
        // // _firebase.currentUser!.updatePhotoURL(imageUrl);
        //
        // logger.d(userCredentials);
      } catch (error) {
        var message = 'An error occurred, signing up';

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      } finally {
        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryFixedDim,
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 30, bottom: 20, left: 20, right: 20),
              width: 200,
              child: Image.asset('assets/images/logo.png'),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!_isLogin)
                          UserImagePicker(
                            onImagePick: (pickedImage) {
                              _selectedImage = pickedImage;
                            },
                          ),
                        if (!_isLogin)
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.trim().length < 4) {
                                return 'Please enter at least 4 characters.';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Name'),
                            enableSuggestions: false,
                            textCapitalization: TextCapitalization.none,
                            onSaved: (value) {
                              logger.d('Name: $value');
                              _userName = value!;
                            },
                          ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Email Address'),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _userEmail = value!;
                            logger.d('Email: $_userEmail');
                          },
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Password must be at least 6 characters long.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _userPassword = value!;
                            logger.d('Password: $_userPassword');
                          },
                        ),
                        if (!_isLogin)
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Telephone'),
                            validator: (value) {
                              if (value == null || value.trim().length < 11) {
                                return 'Telephone must be at least 11 characters long.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _telephoneNumber = value!;
                              logger.d('Telephone: $_telephoneNumber');
                            },
                          ),
                        if (!_isLogin)
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Organisation Name'),
                            validator: (value) {
                              if (value == null || value.trim().length < 8) {
                                return 'Organisation must be at least 8 characters long.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _organizationName = value!;
                              logger.d('Organization Name: $_organizationName');
                            },
                          ),
                        if (!_isLogin)
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            minLines: 2,
                            maxLines: null,
                            decoration:
                                const InputDecoration(labelText: 'Address'),
                            validator: (value) {
                              if (value == null || value.trim().length < 8) {
                                return 'Address must be at least 8 characters long.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _address = value!;
                              logger.d('Address $_address');
                            },
                          ),
                        const SizedBox(height: 12),
                        if (_isAuthenticating)
                          const CircularProgressIndicator(),
                        if (!_isAuthenticating)
                          ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              child: Text(_isLogin ? 'Login' : 'Sign Up')),
                        if (!_isAuthenticating)
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(_isLogin
                                  ? 'Create an Account'
                                  : 'I already have an account Login')),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
