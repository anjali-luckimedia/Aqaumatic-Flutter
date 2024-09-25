import 'package:aqaumatic_app/Cart/CartModel.dart';
import 'package:aqaumatic_app/Cart/cart_service.dart';
import 'package:aqaumatic_app/components/customDrawer.dart';

import '../../../Cart/cart_page.dart';
import '../search_page/search_page_widget.dart';
import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:badges/badges.dart' as badges;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'catalouge_page_model.dart';
export 'catalouge_page_model.dart';

class CatalougePageWidget extends StatefulWidget {
  const CatalougePageWidget({super.key});

  @override
  State<CatalougePageWidget> createState() => _CatalougePageWidgetState();
}

class _CatalougePageWidgetState extends State<CatalougePageWidget> {
  late CatalougePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<CartItem> _cartItems = [];
  final CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
    _loadCart();
    _model = createModel(context, () => CatalougePageModel());
    print( FFAppState().wishlistKey,);
   _model.searchTextFieldTextController ??= TextEditingController();
   _model.searchTextFieldFocusNode ??= FocusNode();

  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }
  Future<void> _loadCart() async {
    final cartItems = await _cartService.getCart();
    setState(() {
      _cartItems = cartItems;
      FFAppState().cartCount = _cartItems.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,

      drawer: CustomDrawer(
        firstName: FFAppState().firstName,
        lastName: FFAppState().lastName,
        contactNumber: FFAppConstants.contact.toString(),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF27AEDF),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
         // borderColor: Color(0xFF27AEDF),
          borderRadius: 0.0,
          borderWidth: 0.0,
          buttonSize: 40.0,
          //fillColor: Color(0xFF27AEDF),
          icon: Icon(
            Icons.menu_sharp,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            size: 24.0,
          ),
          onPressed: () async {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 22.0, 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/Group_(1).png',
              fit: BoxFit.fitWidth,
            ),
          ),
        ),

        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: -5, end: 15),
            badgeContent: FFAppState().cartCount > 0
                ? Text(
              FFAppState().cartCount.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                letterSpacing: 0.0,
              ),
            )
                : null,
            showBadge: FFAppState().cartCount > 0,
            badgeStyle: badges.BadgeStyle(
              shape: badges.BadgeShape.circle,
              badgeColor: Colors.red,
              elevation: 0.0,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 24.0,
                ),
                onPressed: () {
                  // Navigate to Cart Page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
                },
              ),
            ),
          ),

        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 10),
          child: TextFormField(
            controller: _model.searchTextFieldTextController,
            focusNode: _model.searchTextFieldFocusNode,
            onFieldSubmitted: (_) async {
              setState(() {
                final searchText = _model.searchTextFieldTextController.text.trim(); // Trim spaces
                if (searchText.isNotEmpty) {
                  print('Navigating to SearchPage with search text: $searchText'); // Debugging line
                  try {
                    context.pushNamed(
                      'SearchPage',
                      queryParameters: {
                        'name': serializeParam(
                          searchText,
                          ParamType.String,

                        ),
                      }.withoutNulls, // Consider removing this to test
                    );
                    _model.searchTextFieldTextController!.clear(); // Clear the text field
                  } catch (e) {
                    print('Error during navigation: $e');
                  }
                } else {
                  print('Search text is empty.');
                }
              });
            },
            autofocus: false,
            textInputAction: TextInputAction.search,
            obscureText: false,
            decoration: InputDecoration(
              isDense: true,
              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'Open Sans',
                letterSpacing: 0.0,
              ),
              alignLabelWithHint: false,
              hintText: 'Search Catalogue',
              hintStyle: FlutterFlowTheme.of(context).labelSmall.override(
                fontFamily: 'Inter',
                fontSize: 13,
                letterSpacing: 0.0,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              filled: true,
              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              contentPadding: EdgeInsetsDirectional.fromSTEB(15, 15, 0, 0),
              // prefixIcon: Icon(
              //   Icons.search_sharp,
              //   color: Color(0xFF43484B),
              //   size: 18,
              // ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    final searchText = _model.searchTextFieldTextController.text.trim(); // Trim spaces
                    if (searchText.isNotEmpty) {
                      print('Navigating to SearchPage with search text: $searchText'); // Debugging line
                      try {
                        context.pushNamed(
                          'SearchPage',
                          queryParameters: {
                            'name': serializeParam(
                              searchText,
                              ParamType.String,
                            ),
                          }.withoutNulls, // Consider removing this to test
                        );
                        _model.searchTextFieldTextController!.clear(); // Clear the text field
                      } catch (e) {
                        print('Error during navigation: $e');
                      }
                    } else {
                      print('Search text is empty.');
                    }
                  });

                },
                child: Icon(
                  Icons.search_sharp,
                  color: Color(0xFF43484B),
                  size: 18,
                ),
              ),

             /* suffixIcon: GestureDetector(
                onTap: () {
                  final searchText = _model.searchTextFieldTextController.text.trim(); // Trim spaces
                  if (searchText.isNotEmpty) {
                    try {
                      context.pushNamed(
                        'SearchPage',
                        queryParameters: {
                          'name': serializeParam(
                            searchText,
                            ParamType.String,
                          ),
                        }.withoutNulls,
                      );
                    } catch (e) {
                      print('Error during navigation: $e');
                    }
                  } else {
                    print('Search text is empty.');
                  }
                },
                child: Icon(
                  Icons.search_sharp,
                  color: Color(0xFF43484B),
                  size: 18,
                ),
              ),*/


/*
              suffixIcon: GestureDetector(
                onTap: (){
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPageWidget(name:  _model.searchTextFieldTextController.text,),));
                  context.pushNamed(
                  'SearchPage',
                  queryParameters: {
                  'name': serializeParam(
                  _model.searchTextFieldTextController.text,
                  ParamType.String,
                  ),
                  }.withoutNulls,
                  );
                },
                child: Icon(
                  Icons.search_sharp,
                  color: Color(0xFF43484B),
                  size: 18,
                ),
              ),*/
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Inter',
              letterSpacing: 0.0,
            ),
            textAlign: TextAlign.start,
            keyboardType: TextInputType.name,
            validator:
            _model.searchTextFieldTextControllerValidator.asValidator(context),
          ),
        )
        ),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [

            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 25.0, 20.0, 0.0),
              child: PagedGridView<ApiPagingParams, dynamic>(
              //  physics: NeverScrollableScrollPhysics(),
               // shrinkWrap: false,
                pagingController: _model.setGridViewController(
                  (nextPageMarker) => GetCatalougeCall.call(
                    userId: FFAppState().userId,
                    page: functions
                        .getPageNumber(nextPageMarker.nextPageNumber)
                        .toString(),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                  0,
                  0,
                  0,
                  100.0,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                scrollDirection: Axis.vertical,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                  // Customize what your widget looks like when it's loading the first page.
                  firstPageProgressIndicatorBuilder: (_) => Center(
                    child: SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: SpinKitFadingCircle(
                        color: FlutterFlowTheme.of(context).primary,
                        size: 40.0,
                      ),
                    ),
                  ),
                  // Customize what your widget looks like when it's loading another page.
                  newPageProgressIndicatorBuilder: (_) => Center(
                    child: SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: SpinKitFadingCircle(
                        color: FlutterFlowTheme.of(context).primary,
                        size: 40.0,
                      ),
                    ),
                  ),

                  itemBuilder: (context, _, getCatalougeIndex) {
                    final getCatalougeItem = _model.gridViewPagingController!.itemList![getCatalougeIndex];
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            getJsonField(
                              getCatalougeItem,
                              r'''$.image.src''',
                            ).toString(),
                            width: 300.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(decoration: BoxDecoration(color: Colors.black.withOpacity(0.3),borderRadius: BorderRadius.circular(8.0), )),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(
                              'CatalougeListPage',
                              queryParameters: {
                                'catId': serializeParam(
                                  getJsonField(
                                    getCatalougeItem,
                                    r'''$.id''',
                                  ),
                                  ParamType.int,
                                ),
                                'catName': serializeParam(
                                  getJsonField(
                                    getCatalougeItem,
                                    r'''$.name''',
                                  ).toString(),
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                            );
                          },
                          child: Container(
                            width: 300.0,
                            height: 200.0,
                            decoration: BoxDecoration(
                              color: Color(0x69363636),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 15.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  'CatalougeListPage',
                                  queryParameters: {
                                    'catId': serializeParam(
                                      getJsonField(
                                        getCatalougeItem,
                                        r'''$.id''',
                                      ),
                                      ParamType.int,
                                    ),
                                    'catName': serializeParam(
                                      getJsonField(
                                        getCatalougeItem,
                                        r'''$.name''',
                                      ).toString(),
                                      ParamType.String,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: Center(
                                child: Text(
                                  getJsonField(
                                    getCatalougeItem,
                                    r'''$.name''',
                                  ).toString().toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            // Align(
            //   alignment: AlignmentDirectional(0.0, 1.0),
            //   child: wrapWithModel(
            //     model: _model.customBottomNavigationModel,
            //     updateCallback: () => safeSetState(() {}),
            //     child: CustomBottomNavigationWidget(
            //       selectedPage: 'catalouge',
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationWidget(
        selectedPage: 'catalouge', // Pass the selected page
      ),
    );
  }
}
