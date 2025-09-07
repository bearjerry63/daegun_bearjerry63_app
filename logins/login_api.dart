import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInService {
  static final _googleSignIn = GoogleSignIn();
  static GoogleSignInAccount? currentUser;
  static String mail = '';
  static String name = '';
  static String imageUrl = '';
  static Future<GoogleSignInAccount?> login() async {
    currentUser = await _googleSignIn.signIn();
    if (currentUser != null) {
      // 로그인 상태를 저장합니다.
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      prefs.setString('email', currentUser!.email);
      prefs.setString('name', currentUser!.displayName.toString());
      prefs.setString('imageUrl', currentUser!.photoUrl.toString());
      mail = prefs.getString('email')!;
      name = prefs.getString('name')!;
      imageUrl = prefs.getString('imageUrl')!;
    }
    return currentUser;
  }

  static Future logout() {
    currentUser = null;
    // 로그아웃 상태를 저장합니다.
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isLoggedIn', false);
    });
    return _googleSignIn.signOut();
  }

  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    mail = prefs.getString('email')!;
    name = prefs.getString('name')!;
    imageUrl = prefs.getString('imageUrl')!;
  }
}
