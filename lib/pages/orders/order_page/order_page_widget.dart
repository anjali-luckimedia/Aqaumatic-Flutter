import 'package:aqaumatic_app/Cart/CartModel.dart';
import 'package:aqaumatic_app/Cart/cart_service.dart';

import '../../../Cart/cart_page.dart';
import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
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

import 'order_page_model.dart';
export 'order_page_model.dart';

class OrderPageWidget extends StatefulWidget {
  const OrderPageWidget({super.key});

  @override
  State<OrderPageWidget> createState() => _OrderPageWidgetState();
}

class _OrderPageWidgetState extends State<OrderPageWidget> {
  late OrderPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  @override
  void initState() {
    super.initState();
    _loadCart();
    _model = createModel(context, () => OrderPageModel());
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: Drawer(
          elevation: 16,
          child: WebViewAware(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25, 40, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Main menu',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Open Sans',
                      fontSize: 20,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RichText(
                    textScaler: MediaQuery.of(context).textScaler,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: FFAppState().firstName,
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFF43484B),
                            fontSize: 16,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: ' ',
                          style: TextStyle(),
                        ),
                        TextSpan(
                          text: FFAppState().lastName,
                          style: TextStyle(),
                        )
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF43484B),
                        fontSize: 16,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed('CatalougePage');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 8,
                            buttonSize: 40,
                            fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                            icon: FaIcon(
                              FontAwesomeIcons.home,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              'Home',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Open Sans',
                                color: Color(0xFF43484B),
                                fontSize: 16,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (Navigator.of(context).canPop()) {
                          context.pop();
                        }
                        context.pushNamed('NewsPage');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 8,
                            buttonSize: 40,
                            fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                            icon: FaIcon(
                              FontAwesomeIcons.newspaper,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              'News',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Open Sans',
                                color: Color(0xFF43484B),
                                fontSize: 16,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed('DownloadPage');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 8,
                            buttonSize: 40,
                            fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                            icon: FaIcon(
                              FontAwesomeIcons.cloudDownloadAlt,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              'Downloads',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Open Sans',
                                color: Color(0xFF43484B),
                                fontSize: 16,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed('ProfilePage');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 8,
                            buttonSize: 40,
                            fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                            icon: FaIcon(
                              FontAwesomeIcons.userCircle,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              'Profile',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Open Sans',
                                color: Color(0xFF43484B),
                                fontSize: 16,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await launchUrl(Uri(
                          scheme: 'tel',
                          path: valueOrDefault<String>(
                            FFAppConstants.contact.toString(),
                            '+44 1483 861599',
                          ),
                        ));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 8,
                            buttonSize: 40,
                            fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                            icon: FaIcon(
                              FontAwesomeIcons.phone,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              'Call Aqaumatic',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Open Sans',
                                color: Color(0xFF43484B),
                                fontSize: 16,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        GoRouter.of(context).prepareAuthEvent();
                        await authManager.signOut();
                        GoRouter.of(context).clearRedirectLocation();

                        FFAppState().userId = 0;
                        FFAppState().firstName = '';
                        FFAppState().lastName = '';
                        FFAppState().telephone = '';
                        FFAppState().email = '';
                        safeSetState(() {});

                        context.goNamedAuth('LoginPage', context.mounted);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 8,
                            buttonSize: 40,
                            fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                            icon: Icon(
                              Icons.login_sharp,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              'Logout',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Open Sans',
                                color: Color(0xFF43484B),
                                fontSize: 16,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/Group.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFF27AEDF),
          automaticallyImplyLeading: false,
          leading: Align(
            alignment: AlignmentDirectional(0, 0),
            child: FlutterFlowIconButton(
             // borderColor: Color(0xFF27AEDF),
              borderRadius: 0,
              borderWidth: 1,
              buttonSize: 46,
             // fillColor: Color(0xFF27AEDF),
              icon: Icon(
                Icons.menu_sharp,
                color: FlutterFlowTheme.of(context).secondaryBackground,
                size: 24,
              ),
              onPressed: () async {
                scaffoldKey.currentState!.openDrawer();
              },
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
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Orders',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Open Sans',
                color: Colors.white,
                fontSize: 22,
                letterSpacing: 0.0,
              ),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 0,
        ),
        bottomNavigationBar: CustomBottomNavigationWidget(
          selectedPage: 'orders', // Pass the selected page
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      safeSetState(() => _model.listViewPagingController?.refresh());
                      await _model.waitForOnePageForListView();
                    },
                    child: PagedListView<ApiPagingParams, dynamic>.separated(

                      pagingController: _model.setListViewController(
                            (nextPageMarker) => GetOrderListCall.call(
                          page: functions
                              .getPageNumber(nextPageMarker.nextPageNumber)
                              .toString(),
                          userId: FFAppState().userId,
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(
                        0,
                        0,
                        0,
                        50,
                      ),
                      shrinkWrap: true,
                      reverse: false,
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (_, __) => SizedBox(height: 15),
                      builderDelegate: PagedChildBuilderDelegate<dynamic>(
                        // Customize what your widget looks like when it's loading the first page.
                        firstPageProgressIndicatorBuilder: (_) => Align(
                          alignment: Alignment.center,
                          child: Center(

                            child: SpinKitFadingCircle(

                              color: FlutterFlowTheme.of(context).primary,
                              size: 40,
                            ),
                          ),
                        ),
                        // Customize what your widget looks like when it's loading another page.
                        newPageProgressIndicatorBuilder: (_) => Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: SpinKitFadingCircle(
                              color: FlutterFlowTheme.of(context).primary,
                              size: 40,
                            ),
                          ),
                        ),

                        itemBuilder: (context, _, getOrderIndex) {
                          final getOrderItem = _model
                              .listViewPagingController!
                              .itemList![getOrderIndex];
                          return Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  'OrderDetailsPage',
                                  queryParameters: {
                                    'orderId': serializeParam(
                                      getJsonField(
                                        getOrderItem,
                                        r'''$.id''',
                                      ),
                                      ParamType.int,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                   /* Builder(
                                      builder: (context) {
                                        if (_model.orderCancel ==
                                            getJsonField(
                                              getOrderItem,
                                              r'''$.status''',
                                            ).toString()) {
                                          return FlutterFlowIconButton(
                                            borderColor: Color(0xFFFF0000),
                                            borderRadius: 20,
                                            borderWidth: 1,
                                            buttonSize: 40,
                                            fillColor: Color(0xFFFF0000),
                                            icon: Icon(
                                              Icons.close_outlined,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                              size: 24,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          );
                                        } else if (_model.orderProcessing ==
                                            getJsonField(
                                              getOrderItem,
                                              r'''$.status''',
                                            ).toString()) {
                                          return FlutterFlowIconButton(
                                            borderColor:
                                            FlutterFlowTheme.of(context)
                                                .warning,
                                            borderRadius: 20,
                                            borderWidth: 1,
                                            buttonSize: 40,
                                            fillColor:
                                            FlutterFlowTheme.of(context)
                                                .warning,
                                            icon: Icon(
                                              Icons.sync_problem_outlined,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                              size: 24,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          );
                                        } else if (_model.orderPending ==
                                            getJsonField(
                                              getOrderItem,
                                              r'''$.status''',
                                            ).toString()) {
                                          return FlutterFlowIconButton(
                                            borderColor:
                                            FlutterFlowTheme.of(context)
                                                .warning,
                                            borderRadius: 20,
                                            borderWidth: 1,
                                            buttonSize: 40,
                                            fillColor:
                                            FlutterFlowTheme.of(context)
                                                .warning,
                                            icon: Icon(
                                              Icons.pending,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                              size: 24,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          );
                                        } else if (_model.orderComplete ==
                                            getJsonField(
                                              getOrderItem,
                                              r'''$.status''',
                                            ).toString()) {
                                          return FlutterFlowIconButton(
                                            borderColor: Color(0xB22EAB03),
                                            borderRadius: 20,
                                            borderWidth: 1,
                                            buttonSize: 40,
                                            fillColor: Color(0xB22EAB03),
                                            icon: Icon(
                                              Icons.check_sharp,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                              size: 24,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          );
                                        } else {
                                          return Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .warning,
                                              shape: BoxShape.circle,
                                            ),
                                            alignment:
                                            AlignmentDirectional(0, 0),
                                            child: Text(
                                              getJsonField(
                                                getOrderItem,
                                                r'''$.status''',
                                              ).toString(),
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily:
                                                'Open Sans',
                                                fontSize: 10,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),*/
                                    Builder(
                                      builder: (context) {
                                        final status = getJsonField(
                                                getOrderItem, r'''$.status''')
                                            .toString();

                                        // Define a map of status to corresponding button properties with proper typing
                                        final Map<String,
                                                Map<String, dynamic>>
                                            statusMap = {
                                          _model.orderCancel: {
                                            'borderColor': Color(0xFFFF0000),
                                            'fillColor': Color(0xFFFF0000),
                                            'icon': Icons.close_outlined,
                                          },
                                          _model.orderProcessing: {
                                            'borderColor':
                                                FlutterFlowTheme.of(context)
                                                    .warning,
                                            'fillColor':
                                                FlutterFlowTheme.of(context)
                                                    .warning,
                                            'icon':
                                                Icons.sync_problem_outlined,
                                          },
                                          _model.orderPending: {
                                            'borderColor':
                                                FlutterFlowTheme.of(context)
                                                    .warning,
                                            'fillColor':
                                                FlutterFlowTheme.of(context)
                                                    .warning,
                                            'icon': Icons.pending,
                                          },
                                          _model.orderComplete: {
                                            'borderColor': Color(0xB22EAB03),
                                            'fillColor': Color(0xB22EAB03),
                                            'icon': Icons.check_sharp,
                                          },
                                        };

                                        // Check if the status exists in the map, else show default container
                                        if (statusMap.containsKey(status)) {
                                          final properties =
                                              statusMap[status]!;
                                          return FlutterFlowIconButton(
                                            borderColor:
                                                properties['borderColor']
                                                    as Color?,
                                            borderRadius: 20,
                                            borderWidth: 1,
                                            buttonSize: 40,
                                            fillColor: properties['fillColor']
                                                as Color?,
                                            icon: Icon(
                                              properties['icon'] as IconData?,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              size: 24,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          );
                                        } else {
                                          return Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .warning,
                                              shape: BoxShape.circle,
                                            ),
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Text(
                                              status,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Open Sans',
                                                        fontSize: 10,
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          25, 5, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(0, 5, 0, 0),
                                            child: RichText(
                                              textScaler:
                                              MediaQuery.of(context)
                                                  .textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Order ID: - ',
                                                    style: FlutterFlowTheme
                                                        .of(context)
                                                        .bodyMedium
                                                        .override(
                                                      fontFamily:
                                                      'Open Sans',
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: getJsonField(
                                                      getOrderItem,
                                                      r'''$.id''',
                                                    ).toString(),
                                                    style: TextStyle(),
                                                  )
                                                ],
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Open Sans',
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(0, 5, 0, 0),
                                            child: RichText(
                                              textScaler:
                                              MediaQuery.of(context)
                                                  .textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Status :- ',
                                                    style: FlutterFlowTheme
                                                        .of(context)
                                                        .bodyMedium
                                                        .override(
                                                      fontFamily:
                                                      'Open Sans',
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: getJsonField(
                                                      getOrderItem,
                                                      r'''$.status''',
                                                    ).toString(),
                                                    style: TextStyle(),
                                                  )
                                                ],
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Open Sans',
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(0, 5, 0, 0),
                                            child: RichText(
                                              textScaler:
                                              MediaQuery.of(context)
                                                  .textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Updated  ',
                                                    style: FlutterFlowTheme
                                                        .of(context)
                                                        .bodyMedium
                                                        .override(
                                                      fontFamily:
                                                      'Open Sans',
                                                      color: Color(
                                                          0xFF43484B),
                                                      fontSize: 16,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: functions
                                                        .formatDateTimeCustom(
                                                        getJsonField(
                                                          getOrderItem,
                                                          r'''$.date_created''',
                                                        ).toString()),
                                                    style: TextStyle(),
                                                  )
                                                ],
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Open Sans',
                                                  color:
                                                  Color(0xFF43484B),
                                                  fontSize: 16,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(0, 8, 0, 0),
                                            child: Container(
                                              width: 283,
                                              height: 1,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
