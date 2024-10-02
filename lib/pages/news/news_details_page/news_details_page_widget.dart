import 'package:aqaumatic_app/Cart/CartModel.dart';
import 'package:aqaumatic_app/Cart/cart_page.dart';
import 'package:aqaumatic_app/Cart/cart_service.dart';
import 'package:flutter_html/flutter_html.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:badges/badges.dart' as badges;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'news_details_page_model.dart';
export 'news_details_page_model.dart';

class NewsDetailsPageWidget extends StatefulWidget {
  const NewsDetailsPageWidget({
    super.key,
    this.slugName,
  });

  final String? slugName;

  @override
  State<NewsDetailsPageWidget> createState() => _NewsDetailsPageWidgetState();
}

class _NewsDetailsPageWidgetState extends State<NewsDetailsPageWidget> {
  late NewsDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  int count = 0;
  @override
  void initState() {
    super.initState();
    _loadCart();
    _model = createModel(context, () => NewsDetailsPageModel());
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
      count = _cartItems.length;


      print('count instant -------$count');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
         backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF27AEDF),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
           // borderColor: Color(0xFF27AEDF),
            borderRadius: 20.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            //fillColor: Color(0xFF27AEDF),
            icon: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).primaryBackground,
              size: 24.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          actions: [
            badges.Badge(
              position: badges.BadgePosition.topEnd(top: -5, end: 15),
              //badgeContent: FFAppState().cartCount > 0
              badgeContent: count > 0
                  ? Text(
                //FFAppState().cartCount.toString(),
                count.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                ),
              )
                  : null,
              //showBadge: FFAppState().cartCount > 0,
              showBadge: count > 0,
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
              'News Details',
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
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 0.0, 0.0),
            child: FutureBuilder<ApiCallResponse>(
              future: GetNewsDetailsCall.call(
                slug: widget.slugName,
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                 if (!snapshot.hasData) {
                  return Wrap();
                }
                final columnGetNewsDetailsResponse = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                        child: RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: valueOrDefault<String>(
                                  GetNewsDetailsCall.title(
                                    columnGetNewsDetailsResponse.jsonBody,
                                  ),
                                  'title',
                                ),
                                style: TextStyle(),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Open Sans',
                                  color: Color(0xFF43484B),
                                  fontSize: 22.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: functions.formatDateTimeCustom(
                                    GetNewsDetailsCall.date(
                                  columnGetNewsDetailsResponse.jsonBody,
                                )!),
                                style: TextStyle(),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Open Sans',
                                  color: Color(0xFF43484B),
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                      Html(
                        data:  GetNewsDetailsCall.content(
                          columnGetNewsDetailsResponse.jsonBody,
                        )!,
                        // Optional styling
                        style: {
                          "p": Style(
                            fontSize: FontSize.large,
                            color: Colors.black87,
                          ),
                          "src": Style(

                            //padding:  HtmlPaddings(top: 8,bottom: 8,left: 8,right: 8),
                            width: Width(MediaQuery.of(context).size.width * 0.3), // Resizes image width
                          ),
                        },
                      ),
                    /*  Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 8.0, 15.0, 35.0),
                        child: FlutterFlowWebView(
                          content: GetNewsDetailsCall.content(
                            columnGetNewsDetailsResponse.jsonBody,
                          )!,
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          verticalScroll: true,
                          horizontalScroll: false,
                          html: true,
                        ),
                      ),*/
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
