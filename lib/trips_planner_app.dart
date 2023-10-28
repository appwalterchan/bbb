import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:bbb/common/navigation/router/router.dart';
import 'package:bbb/common/utils/colors.dart' as constants;
import 'package:flutter/material.dart';

class TripsPlannerApp extends StatelessWidget {
  const TripsPlannerApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp.router(
        routerConfig: router,
        builder: Authenticator.builder(),
        theme: ThemeData(
          primarySwatch: constants.primaryColor,
          scaffoldBackgroundColor: Colors.grey[50],
        ),
      ),
    );
  }
}
