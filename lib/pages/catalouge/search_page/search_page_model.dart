import '/backend/api_requests/api_calls.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:badges/badges.dart' as badges;
import 'search_page_widget.dart' show SearchPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchPageModel extends FlutterFlowModel<SearchPageWidget> {
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