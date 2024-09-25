import 'package:aqaumatic_app/Cart/cart_page.dart';
import 'package:aqaumatic_app/Cart/cart_service.dart';

import '../../../Cart/CartModel.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'order_details_page_model.dart';
export 'order_details_page_model.dart';

class OrderDetailsPageWidget extends StatefulWidget {
  const OrderDetailsPageWidget({
    super.key,
    this.orderId,
  });

  final int? orderId;

  @override
  State<OrderDetailsPageWidget> createState() => _OrderDetailsPageWidgetState();
}

class _OrderDetailsPageWidgetState extends State<OrderDetailsPageWidget> {
  late OrderDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  @override
  void initState() {
    super.initState();
    _loadCart();
    _model = createModel(context, () => OrderDetailsPageModel());
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0xFF27AEDF),
          automaticallyImplyLeading: false,
          leading: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: FlutterFlowIconButton(
             // borderColor: Color(0xFF27AEDF),
              borderRadius: 0.0,
              borderWidth: 0.0,
              buttonSize: 46.0,
             // fillColor: Color(0xFF27AEDF),
              icon: Icon(
                Icons.arrow_back,
                color: FlutterFlowTheme.of(context).secondaryBackground,
                size: 24.0,
              ),
              onPressed: () async {
                context.safePop();
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
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                  ),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 0.0,
        ),
        bottomNavigationBar: CustomBottomNavigationWidget(
          selectedPage: 'orders', // Pass the selected page
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, -1.0),
            child: Stack(
              children: [
                /*Align(
                  alignment: AlignmentDirectional(-1.0, -1.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 20.0),
                    child: FutureBuilder<ApiCallResponse>(
                      future: GetOrderDetailsCall.call(
                        orderId: widget!.orderId,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: SpinKitFadingCircle(
                                color: FlutterFlowTheme.of(context).primary,
                                size: 40.0,
                              ),
                            ),
                          );
                        }
                        final columnGetOrderDetailsResponse = snapshot.data!;

                        return SingleChildScrollView(
                          child: Column(
                            //mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  'Order Details',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        fontSize: 22.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  'Order Id',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF43484B),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    GetOrderDetailsCall.id(
                                      columnGetOrderDetailsResponse.jsonBody,
                                    )?.toString(),
                                    'id',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 1.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  'Status',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF43484B),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    GetOrderDetailsCall.status(
                                      columnGetOrderDetailsResponse.jsonBody,
                                    ),
                                    'status',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 1.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  'User',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF43484B),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 5.0, 0.0, 0.0),
                                  child: RichText(
                                    textScaler:
                                        MediaQuery.of(context).textScaler,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: valueOrDefault<String>(
                                            GetOrderDetailsCall.firstName(
                                              columnGetOrderDetailsResponse
                                                  .jsonBody,
                                            ),
                                            'fname',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Open Sans',
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        TextSpan(
                                          text: valueOrDefault<String>(
                                            GetOrderDetailsCall.lastName(
                                              columnGetOrderDetailsResponse
                                                  .jsonBody,
                                            ),
                                            'lName',
                                          ),
                                          style: TextStyle(),
                                        )
                                      ],
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 1.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  'Date Created',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF43484B),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Text(
                                  functions.formatDateTimeCustom(
                                      GetOrderDetailsCall.createDate(
                                    columnGetOrderDetailsResponse.jsonBody,
                                  )!),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 1.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  'Date Updated',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF43484B),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Text(
                                  functions.formatDateTimeCustom(
                                      GetOrderDetailsCall.updatedDate(
                                    columnGetOrderDetailsResponse.jsonBody,
                                  )!),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 1.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  'Order Total (£)',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF43484B),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    GetOrderDetailsCall.total(
                                      columnGetOrderDetailsResponse.jsonBody,
                                    ),
                                    'total',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 1.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  'Purchase Order',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF43484B),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'POR- ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Open Sans',
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      TextSpan(
                                        text: valueOrDefault<String>(
                                          GetOrderDetailsCall.number(
                                            columnGetOrderDetailsResponse
                                                .jsonBody,
                                          ),
                                          'no',
                                        ),
                                        style: TextStyle(),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 1.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  'Phone Number',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF43484B),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    GetOrderDetailsCall.phoneNumber(
                                      columnGetOrderDetailsResponse.jsonBody,
                                    ),
                                    'Phone number is not store',
                                  ),
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF43484B),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 1.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  'Products',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF43484B),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 15.0, 0.0, 0.0),
                                  child: FutureBuilder<ApiCallResponse>(
                                    future: GetOrderDetailsCall.call(
                                      orderId: widget!.orderId,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 40.0,
                                            height: 40.0,
                                            child: SpinKitFadingCircle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 40.0,
                                            ),
                                          ),
                                        );
                                      }
                                      final listViewGetOrderDetailsResponse =
                                          snapshot.data!;

                                      return Builder(
                                        builder: (context) {
                                          final getOrderDetails = getJsonField(
                                            listViewGetOrderDetailsResponse
                                                .jsonBody,
                                            r'''$.line_items''',
                                          ).toList();

                                          return ListView.separated(
                                            // padding: EdgeInsets.fromLTRB(
                                            //   0,
                                            //   0.0,
                                            //   0,
                                            //   50.0,
                                            // ),
                                            primary: false,
                                            shrinkWrap: false,
                                            physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: getOrderDetails.length,
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 15.0),
                                            itemBuilder: (context,
                                                getOrderDetailsIndex) {
                                              final getOrderDetailsItem =
                                                  getOrderDetails[
                                                      getOrderDetailsIndex];
                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 0.0,
                                                                5.0, 0.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 120.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  15.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  15.0),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                child: Image
                                                                    .network(
                                                                  getJsonField(
                                                                    getOrderDetailsItem,
                                                                    r'''$.image.src''',
                                                                  ).toString(),
                                                                  width: 58.0,
                                                                  height: 52.0,
                                                                  fit: BoxFit
                                                                      .none,
                                                                  alignment:
                                                                      Alignment(
                                                                          0.0,
                                                                          0.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        25.0,
                                                                        5.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              getJsonField(
                                                                            getOrderDetailsItem,
                                                                            r'''$.name''',
                                                                          ).toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15.0,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Open Sans',
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                15.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              'Sku :- ',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Open Sans',
                                                                                color: Colors.black,
                                                                                fontSize: 15.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              getJsonField(
                                                                            getOrderDetailsItem,
                                                                            r'''$.sku''',
                                                                          ).toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15.0,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Open Sans',
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                18.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
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
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 10.0,
                                                                0.0, 0.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 1.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ].addToEnd(SizedBox(height: 50.0)),
                          ),
                        );
                      },
                    ),
                  ),
                ),*/
                Align(
                  alignment: AlignmentDirectional(-1.0, -1.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 20.0),
                    child: FutureBuilder<ApiCallResponse>(
                      future: GetOrderDetailsCall.call(orderId: widget.orderId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: SpinKitFadingCircle(
                                color: FlutterFlowTheme.of(context).primary,
                                size: 40.0,
                              ),
                            ),
                          );
                        }

                        final response = snapshot.data!;
                        final orderDetails = response.jsonBody;

                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  'Order Details',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Order ID
                              _buildDetailRow(context, 'Order ID', GetOrderDetailsCall.id(orderDetails).toString()),
                              // Status
                              _buildDetailRow(context, 'Status', GetOrderDetailsCall.status(orderDetails).toString()),
                              // User Details
                              _buildDetailRow(context, 'User', '${GetOrderDetailsCall.firstName(orderDetails)} ${GetOrderDetailsCall.lastName(orderDetails)}'),
                              // Dates
                              _buildDetailRow(context, 'Date Created', functions.formatDateTimeCustom(GetOrderDetailsCall.createDate(orderDetails).toString())),
                              _buildDetailRow(context, 'Date Updated', functions.formatDateTimeCustom(GetOrderDetailsCall.updatedDate(orderDetails).toString())),
                              // Total
                              _buildDetailRow(context, 'Order Total (£)', GetOrderDetailsCall.total(orderDetails).toString()),
                              // Purchase Order
                              _buildDetailRow(context, 'Purchase Order', 'POR-${GetOrderDetailsCall.number(orderDetails)}'),
                              // Phone Number
                              _buildDetailRow(context, 'Phone Number', GetOrderDetailsCall.phoneNumber(orderDetails) ?? 'Phone number not stored'),
                              // Products
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  'Products',
                                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF43484B),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              FutureBuilder<ApiCallResponse>(
                                future: GetOrderDetailsCall.call(orderId: widget.orderId),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 40.0,
                                        height: 40.0,
                                        child: SpinKitFadingCircle(
                                          color: FlutterFlowTheme.of(context).primary,
                                          size: 40.0,
                                        ),
                                      ),
                                    );
                                  }

                                  final products = getJsonField(snapshot.data!.jsonBody, r'''$.line_items''').toList();

                                  return ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: products.length,
                                    separatorBuilder: (_, __) => SizedBox(height: 15.0),
                                    itemBuilder: (context, index) {
                                      final product = products[index];
                                      return Container(
                                        width: double.infinity,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        child: Row(
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          //mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  getJsonField(product, r'''$.image.src''').toString(),
                                                  width: 58.0,
                                                  height: 52.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(25.0, 20.0, 0.0, 0.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    getJsonField(product, r'''$.name''').toString(),
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Open Sans',
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    'SKU: ${getJsonField(product, r'''$.sku''').toString()}',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Open Sans',
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: FlutterFlowTheme.of(context).bodyLarge.override(
              fontFamily: 'Open Sans',
              color: Color(0xFF43484B),
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
            child: Text(
              value,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Open Sans',
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(color: Colors.black),
        ],
      ),
    );
  }
}
