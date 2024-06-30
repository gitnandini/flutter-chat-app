// import 'package:flutter/material.dart';
// import 'package:chat/widgets/pickers/user_image_picker.dart';
// import 'dart:io';

// class AuthForm extends StatefulWidget {
//   //const AuthForm({super.key, required this.submitFn});
//   AuthForm(this.submitFn, this.isLoading);
//   //submitFn is property and type of the prop is a function
//   final bool isLoading;
//   final void Function(
//     String email,
//     String password,
//     String userName,
//     File image,
//     bool isLogin,
//     BuildContext ctx,
//   ) submitFn;

//   @override
//   State<AuthForm> createState() => _AuthFormState();
// }

// class _AuthFormState extends State<AuthForm> {
//   final _formKey = GlobalKey<FormState>();
//   var _isLogin = true;
//   var _userEmail = '';
//   var _userName = '';
//   var _userPassword = '';
//   File? _userImageFile;

//   void _pickedImage(File image) {
//     _userImageFile = image;
//   }

//   void _trySubmit() {
//     final isValid = _formKey.currentState!.validate();
//     //to remove the keyboard
//     FocusScope.of(context).unfocus();

//     if (_userImageFile == null && !_isLogin) {
//       //instead of scaffold using messenger
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('please pick an image'),
//           backgroundColor: Theme.of(context).colorScheme.error,
//         ),
//       );
//       return;
//     }

//     if (isValid) {
//       _formKey.currentState!.save();
//       widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
//           _userImageFile!, _isLogin, context);

//       //use those values to send our auth request..
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Card(
//         margin: EdgeInsets.all(20),
//         child: Card(
//           margin: EdgeInsets.all(20),
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: <Widget>[
//                   if (!_isLogin) UserImagePicker(_pickedImage),
//                   TextFormField(
//                       validator: (value) {
//                         if (value!.isEmpty || !value.contains('@')) {
//                           return 'please enter a valid email address';
//                         }
//                         return null;
//                       },
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         labelText: 'email address',
//                       ),
//                       onSaved: (value) {
//                         _userEmail = value!;
//                       }),
//                   if (!_isLogin)
//                     TextFormField(
//                       validator: (value) {
//                         if (value!.isEmpty || value.length < 4) {
//                           return 'Please enter at least 4 chracters';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(labelText: 'username'),
//                       onSaved: (value) {
//                         _userName = value!;
//                       },
//                     ),
//                   TextFormField(
//                       validator: (value) {
//                         if (value!.isEmpty || value.length < 7) {
//                           return 'password must be at least 7 charaters long';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(labelText: 'password'),
//                       onSaved: (value) {
//                         _userPassword = value!;
//                       }),
//                   SizedBox(height: 12),
//                   if (widget.isLoading) CircularProgressIndicator(),
//                   if (!widget.isLoading)
//                     ElevatedButton(
//                       child: Text(_isLogin ? 'Login' : 'Signup'),
//                       onPressed: _trySubmit,
//                     ),
//                   TextButton(
//                       child: Text(_isLogin
//                           ? 'create new account'
//                           : 'I already have an account'),
//                       onPressed: () {
//                         setState(
//                           () {
//                             _isLogin = !_isLogin;
//                           },
//                         );
//                       })
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:chat/widgets/pickers/user_image_picker.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    File? image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  AuthForm(this.submitFn, this.isLoading);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File? _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (!_isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                  ),
                  onSaved: (value) {
                    _userEmail = value!;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'Please enter at least 4 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Username'),
                    onSaved: (value) {
                      _userName = value!;
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: (value) {
                    _userPassword = value!;
                  },
                ),
                SizedBox(height: 12),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                  ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin
                        ? 'Create new account'
                        : 'I already have an account',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
