import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'news_page_widget.dart' show NewsPageWidget;
import 'package:badges/badges.dart' as badges;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class NewsPageModel extends FlutterFlowModel<NewsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CustomBottomNavigation component.
  late CustomBottomNavigationModel customBottomNavigationModel;

  @override
  void initState(BuildContext context) {
    customBottomNavigationModel =
        createModel(context, () => CustomBottomNavigationModel());
  }

  @override
  void dispose() {
    customBottomNavigationModel.dispose();
  }
}
