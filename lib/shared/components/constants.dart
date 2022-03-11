



import 'package:social/modules/login/login_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/network/local/remote/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, SocialLoginScreen());
    }
  });
}

String? token;
String? uId;

