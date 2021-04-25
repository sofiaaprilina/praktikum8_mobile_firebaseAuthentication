import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String name;
String email;
String imageUrl;
Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;
  if (user != null) {
// Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;
// Only taking the first part of the name, i.e., First Name
    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    print('signInWithGoogle succeeded: $user');
    return '$user';
  }
  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  print("User Signed Out");
}

Future<User> signUpWithEmail(String nameUser, String email, String password) async {
  await Firebase.initializeApp();
  try {
    UserCredential authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = authResult.user;
    if (user != null) {
// Checking if email and name is null
      assert(user.email != null);
      email = user.email;
      assert(nameUser != null);
      name = nameUser;
      
      return user;
    }
      return null;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<User> signInWithEmail(String emailUser, String password) async {
  await Firebase.initializeApp();
  try {
    UserCredential authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailUser, password: password);
    User user = authResult.user;
    if (user != null) {
// Checking if email and name is null
      assert(user.email != null);
      email = emailUser;
      assert(name != null);
      name = name;
      
      return user;
    }
    return null;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<void> signOutEmail() async {
  await FirebaseAuth.instance.signOut();
  print("User Signed Out");
}
