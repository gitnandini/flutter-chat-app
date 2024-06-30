// import 'package:chat/widgets/auth/auth_form.dart';
// import 'package:flutter/material.dart';
// import '../widgets/auth/auth_form.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final _auth = FirebaseAuth.instance;
//   var _isLoading = false;

//   void _submitAuthForm(
//     String email,
//     String password,
//     String username,
//     File image,
//     bool isLogin,
//     BuildContext ctx,
//   ) async {
//     //AuthResult is depricated , use Usercred instead
//     UserCredential authResult;
//     try {
//       if (isLogin) {
//         authResult = await _auth.signInWithEmailAndPassword(
//             email: email, password: password);
//       } else {
//         authResult = await _auth.createUserWithEmailAndPassword(
//             email: email, password: password);

//         //ref points to the root storage bucket
//         // final ref = FirebaseStorage.instance
//         //     .ref()
//         //     .child('user_image')
//         //     .child(authResult.user!.uid + '.jpg');

//         // TaskSnapshot uploadTaskSnapshot = await ref.putFile(image);
//         // final url = await ref.getDownloadURL();

//         //adding new data when new user signs up
//         await FirebaseFirestore.instance
//             //use await beacuse setdata returns a  future
//             .collection('users')
//             .doc(authResult.user!.uid)
//             //setdata is depricated and changed to set
//             .set({
//           'username': username,
//           'email': email,
//           //'image_url': url,
//         });
//       }
//     }

//     //import flutter/services
//     on PlatformException catch (err) {
//       String? message = 'An error occured , please check your credentials';

//       if (err.message != null) {
//         message = err.message;
//       }

//       ScaffoldMessenger.of(ctx).showSnackBar(
//         SnackBar(
//           content: Text(message!),
//           backgroundColor: Theme.of(ctx).errorColor,
//         ),
//       );
//     } catch (err) {
//       print(err);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       body: SingleChildScrollView(child: AuthForm(_submitAuthForm, _isLoading)),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    File? image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential? authResult;
    try {
      setState(() {
        _isLoading = true;
      });

      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // if (image != null) {
        //   final ref = FirebaseStorage.instance
        //       .ref()
        //       .child('user_image')
        //       .child(authResult.user!.uid + '.jpg');

        //   await ref.putFile(image);
        //   final url = await ref.getDownloadURL();

        //   await FirebaseFirestore.instance
        //       .collection('users')
        //       .doc(authResult.user!.uid)
        //       .set({
        //     'username': username,
        //     'email': email,
        //     'image_url': url,
        //   });
        // } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
        });
      }
      // }
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        message = err.message!;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: AuthForm(
          _submitAuthForm,
          _isLoading,
        ),
      ),
    );
  }
}
