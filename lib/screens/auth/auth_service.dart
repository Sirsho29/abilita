import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
    );
  }

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> signInWithEmail(String email, String password) async {
    var authResult;
    try {
      authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return _userFromFirebase(authResult.user);
  }

  Future<User> signUpWithEmail(
      String email, String password, String name) async {
    //var authResult;
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    try {
      // authResult =
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
      userUpdateInfo.displayName = name;
      await user.updateProfile(userUpdateInfo);
      await user.reload();
      user = await FirebaseAuth.instance.currentUser();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return _userFromFirebase(user);
  }

  Future<User> signInWithGoogle() async {
    var authResult;
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      authResult = await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }
}
