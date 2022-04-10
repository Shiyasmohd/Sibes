import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodie/Models/user_model.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<UserModel> get user {
    late UserModel loggedInUser;
    return FirebaseAuth.instance.authStateChanges().map((event) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(event!.uid)
          .get()
          .then((value) {
        loggedInUser = UserModel.fromMap(value.data());
      }).catchError((err) => null);
      return loggedInUser;
    });
  }
}










// class Users {
//   final String uid;

//   Users({@required this.uid});
// }

// abstract class AuthBase {
//   Stream<Users> get authStateChanges;
//   Future<Users> currentUser();
//   Future<Users> signInAnonymously();
//   Future<Users> signInWithEmailAndPassword(String email, String password);
//   Future<Users> createUserWithEmailAndPassword(String email, String password);
//   Future<Users> signInWithGoogle();
//   Future<void> signOut();
// }

// class Auth implements AuthBase {
//   final _firebaseAuth = FirebaseAuth.instance;

//   //To avoid confusion due to updates, "Users" come from the class Users and "User" replaces the deprecated "FirebaseUser".

//   Users _userFromFirebase(User user) {
//     if (user == null) {
//       return null;
//     }
//     return Users(uid: user.uid);
//   }

//   @override
//   Stream<Users> get authStateChanges {
//     return _firebaseAuth.authStateChanges.map(_userFromFirebase);
//   }

//   @override
//   Future<Users> currentUser() async {
//     final user = _firebaseAuth.currentUser;
//     return _userFromFirebase(user);
//   }

//   @override
//   Future<Users> signInAnonymously() async {
//     final authResult = await _firebaseAuth.signInAnonymously();
//     return _userFromFirebase(authResult.user);
//   }

//   @override
//   Future<Users> signInWithEmailAndPassword(String email, String password) async {
//     final authResult = await _firebaseAuth.signInWithEmailAndPassword(
//         email: email, password: password);
//     return _userFromFirebase(authResult.user);
//   }

//   @override
//   Future<Users> createUserWithEmailAndPassword(
//       String email, String password) async {
//     final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email, password: password);
//     return _userFromFirebase(authResult.user);
//   }

//   @override
//   Future<Users> signInWithGoogle() async {
//     final googleSignIn = GoogleSignIn();
//     final googleAccount = await googleSignIn.signIn();
//     if (googleAccount != null) {
//       final googleAuth = await googleAccount.authentication;
//       if (googleAuth.accessToken != null && googleAuth.idToken != null) {
//         final authResult = await _firebaseAuth.signInWithCredential(
//           GoogleAuthProvider.credential(
//               idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
//         );
//         return _userFromFirebase(authResult.user);
//       } else {
//         throw PlatformException(
//             code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
//             message: 'Missing Google Auth Token');
//       }
//     } else {
//       throw PlatformException(
//           code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
//     }
//   }

//   @override
//   Future<void> signOut() async {
//     final googleSignin = GoogleSignIn();
//     await googleSignin.signOut();
//     await _firebaseAuth.signOut();
//   }
// }
