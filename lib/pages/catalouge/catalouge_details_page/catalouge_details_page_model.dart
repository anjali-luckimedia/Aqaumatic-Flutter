

import '/backend/api_requests/api_calls.dart';
import '/components/count_controller_component_widget.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'catalouge_details_page_widget.dart' show CatalougeDetailsPageWidget;
import 'package:badges/badges.dart' as badges;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CatalougeDetailsPageModel
    extends FlutterFlowModel<CatalougeDetailsPageWidget> {
  ///  Local state fields for this page.

  bool isLike = true;

  bool isRelatedProductLike = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (removeProductWishlist)] action in IconButton widget.
  ApiCallResponse? removeProductWishlist;
  // Stores action output result for [Backend Call - API (getProductDetails)] action in IconButton widget.
  ApiCallResponse? rebuildAPI;
  // Stores action output result for [Backend Call - API (addProductToWishlist)] action in IconButton widget.
  ApiCallResponse? addProductWishlist;
  // Stores action output result for [Backend Call - API (getProductDetails)] action in IconButton widget.
  ApiCallResponse? rebuildADDAPI;
  // Model for countControllerComponent component.
  late CountControllerComponentModel countControllerComponentModel1;
  // Stores action output result for [Backend Call - API (addToCart)] action in Button widget.
  ApiCallResponse? addToCart;
  // Stores action output result for [Backend Call - API (removeProductWishlist)] action in IconButton widget.
  ApiCallResponse? removeApiCall;
  // Stores action output result for [Backend Call - API (getProductDetails)] action in IconButton widget.
  ApiCallResponse? rebuildRelated;
  // Stores action output result for [Backend Call - API (addProductToWishlist)] action in IconButton widget.
  ApiCallResponse? addApiCall;
  // Stores action output result for [Backend Call - API (getProductDetails)] action in IconButton widget.
  ApiCallResponse? rebuildAddRelated;
  // Stores action output result for [Backend Call - API (addToCart)] action in Button widget.
  ApiCallResponse? relatedItemAddToCart;
  // Model for CustomBottomNavigation component.
  late CustomBottomNavigationModel customBottomNavigationModel;

  @override
  void initState(BuildContext context) {
    countControllerComponentModel1 =
        createModel(context, () => CountControllerComponentModel());
    customBottomNavigationModel =
        createModel(context, () => CustomBottomNavigationModel());
  }

  @override
  void dispose() {
    countControllerComponentModel1.dispose();
    customBottomNavigationModel.dispose();
  }
}
