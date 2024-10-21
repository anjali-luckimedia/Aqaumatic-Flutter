
import 'package:aqaumatic_app/Cart/CartModel.dart';
import 'package:aqaumatic_app/Cart/cart_page.dart';
import 'package:aqaumatic_app/Cart/cart_service.dart';
import 'package:aqaumatic_app/favourite/favorite_service.dart';
import 'package:aqaumatic_app/favourite/favourite_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../catalouge_details_page/catalouge_details_page_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/count_controller_component_widget.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:badges/badges.dart' as badges;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'catalouge_list_page_model.dart';
export 'catalouge_list_page_model.dart';

class CatalougeListPageWidget extends StatefulWidget {
  const CatalougeListPageWidget({
    super.key,
    required this.catId,
    required this.catName,
  });

  final int? catId;
  final String? catName;

  @override
  State<CatalougeListPageWidget> createState() =>
      _CatalougeListPageWidgetState();
}

class _CatalougeListPageWidgetState extends State<CatalougeListPageWidget> {
  late CatalougeListPageModel _model;
  static const _pageSize = 10;

  final PagingController<int, dynamic> _pagingController = PagingController(firstPageKey: 1);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final CartService _cartService = CartService();
  bool isLoading = false;  // Loading state

  List<CartItem> _cartItems = [];
  // final FavouriteService _favoritesService = FavouriteService();
  // List<int> favorites = [];
  int count = 0;
  List<int> quantity = [];

  // Future<void> _loadFavorites() async {
  //   List<FavoriteItem> favoritesList = await _favoritesService.getFavourite();
  //   setState(() {
  //     favorites = favoritesList.map((item) => item.id).toList(); // Assuming FavoriteItem has an 'id'
  //   });
  // }

  @override
  void initState() {
    super.initState();
    print(widget.catId);
   // _loadFavorites();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    //_loadCartCount();
     FFAppState().cartCount = 1;
    _loadCart();
    _model = createModel(context, () => CatalougeListPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }


  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await GetProductListByCatalougeCall.call(
        categoryId: widget.catId,
        page: pageKey,
        userId: FFAppState().userId, // Assuming FFAppState().userId exists
       
      );

      // Parse the response to extract the list of orders
      final List<dynamic> fetchedOrders = response.jsonBody as List<dynamic>;

      final isLastPage = fetchedOrders.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(fetchedOrders);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(fetchedOrders, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<void> _loadCart() async {
    final cartItems = await _cartService.getCart();
    setState(() {
      _cartItems = cartItems;
      print(_cartItems.length);
      //FFAppState().cartCount = _cartItems.length;
      count = _cartItems.length;


      print('count instant -------$count');
    });
  }


  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();// Ensure this is set up correctly
    return Scaffold(
      key: scaffoldKey,
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF27AEDF),
        automaticallyImplyLeading: false,
        leading: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: FlutterFlowIconButton(
           // borderColor: Color(0xFF27AEDF),
            borderRadius: 0.0,
            borderWidth: 0.0,
           // fillColor: Color(0xFF27AEDF),
            icon: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              size: 24.0,
            ),
            onPressed: () async {
              context.pushNamed('CatalougePage');
            },
          ),
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
        title: Text(
          valueOrDefault<String>(
            widget.catName,
            'CatName',
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          //minFontSize: 10.0,
          style: FlutterFlowTheme.of(context).headlineMedium.override(
            fontFamily: 'Open Sans',
            color: Colors.white,
            fontSize: 18.0,
            letterSpacing: 0.0,
          ),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: PagedListView<int, dynamic>(
                pagingController: _pagingController,
                /*pagingController: _model.setListViewController(
                  (nextPageMarker) => GetProductListByCatalougeCall.call(
                    userId: FFAppState().userId,
                    page: functions.getPageNumber(nextPageMarker.nextPageNumber),
                    categoryId: widget.catId,
                  ),
                ),*/
                shrinkWrap: true,
                reverse: false,
                scrollDirection: Axis.vertical,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                  // Customize what your widget looks like when it's loading the first page.
                  firstPageProgressIndicatorBuilder: (_) => Center(
                    child: SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: SpinKitFadingCircle(
                  color: Color(0xFF27AEDF),
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
                  color: Color(0xFF27AEDF),
                        size: 40.0,
                      ),
                    ),
                  ),



                  itemBuilder: (context, item, getCatalougeProductListIndex) {
                    final getListItem = item;
                    //final getCatalougeProductListItem = _model.listViewPagingController!.itemList![getCatalougeProductListIndex];
                    bool isFavorite = getListItem['is_favorite'] ?? false;
                   // bool isFavourite1 = favorites.contains(getListItem['id']); // Use map access

                    quantity = List.filled(getCatalougeProductListIndex + 1, 1);



                    return SizedBox(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 120.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    // borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          child: FlutterFlowExpandedImageView(
                                            image: Image.network(
                                              getJsonField(
                                                getListItem,
                                                r'''$.images[:].src''',
                                              ).toString(),
                                              fit: BoxFit.contain,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                'assets/images/error_image.png',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            allowRotation: false,
                                            tag: getJsonField(
                                              getListItem,
                                              r'''$.images[:].src''',
                                            ).toString(),
                                            useHeroAnimation: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: getJsonField(
                                        getListItem,
                                        r'''$.images[:].src''',
                                      ).toString(),
                                      transitionOnUserGestures: true,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          getJsonField(
                                            getListItem,
                                            r'''$.images[:].src''',
                                          ).toString(),
                                          width: 50.0,
                                          height: 50.0,
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            'assets/images/error_image.png',
                                            width: 50.0,
                                            height: 50.0,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 170.0,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          getJsonField(
                                            getListItem,
                                            r'''$.name''',
                                          ).toString(),
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Open Sans',
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                        child: RichText(
                                          textScaler: MediaQuery.of(context)
                                              .textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'P/N : ',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: getJsonField(
                                                  getListItem,
                                                  r'''$.sku''',
                                                ).toString(),
                                                style: TextStyle(),
                                              )
                                            ],
                                            style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 5.0, 0.0, 0.0),
                                        child: RichText(
                                          textScaler: MediaQuery.of(context)
                                              .textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Price : ',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: '£',
                                                style: TextStyle(),
                                              ),
                                              TextSpan(
                                                text: getJsonField(
                                                  getListItem,
                                                  r'''$.price''',
                                                ).toString(),
                                                style: TextStyle(),
                                              )
                                            ],
                                            style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 8.0, 0.0, 0.0),
                                        child: InkWell(
                                          onTap: () async {
                                            final slug = serializeParam(
                                              getJsonField(getListItem, r'''$.slug''').toString(),
                                              ParamType.String,
                                            );

                                            final name = serializeParam(
                                              getJsonField(
                                                getListItem,
                                                r'''$.name''',
                                              ).toString(),
                                              ParamType.String,
                                            );

                                            if (slug != null && name != null) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CatalougeDetailsPageWidget(
                                                    slugName: slug,
                                                    catName: widget.catName,
                                                    name: name,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              print(
                                                  'Slug is null, cannot navigate');
                                            }
                                          },
                                          child: Container(
                                            width: 110.0,
                                            height: 24.0,
                                            decoration: BoxDecoration(
                                              //color: FlutterFlowTheme.of(context).secondaryBackground,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(5.0),
                                                bottomRight:
                                                    Radius.circular(5.0),
                                                topLeft: Radius.circular(5.0),
                                                topRight:
                                                    Radius.circular(5.0),
                                              ),
                                              border: Border.all(
                                                color: Color(0xFF019ADE),
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Row(
                                              //mainAxisSize:MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    'VIEW MORE',
                                                    style: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          color: Color(
                                                              0xFF019ADE),
                                                          fontSize: 13.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: Color(0xFF019ADE),
                                                  size: 15.0,
                                                ),
                                              ].divide(SizedBox(width: 10.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [


                                 Row(
                                  children: [
                                  /*  SizedBox(
                                      width: 140,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(0.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 20.0,
                                              buttonSize: 30.0,
                                              fillColor: Color(0xFFEB445A),
                                              icon: FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: FlutterFlowTheme.of(context).info,
                                                size: 15.0,
                                              ),
                                              showLoadingIndicator: true,
                                              onPressed: () async {

                                                //_decrementQuantity(item.id);
                                              },
                                            ),
                                          ),
                                          Text('${FFAppState().cartCount}',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Open Sans',
                                              letterSpacing: 0.0,
                                            ),
                                          ),
                                          FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 20.0,
                                            buttonSize:30.0,
                                            fillColor:  Color(0xFF2DD36F) ,
                                            icon: FaIcon(
                                              FontAwesomeIcons.plus,
                                              color: FlutterFlowTheme.of(context).info,
                                              size: 15.0,
                                            ),
                                            showLoadingIndicator: true,
                                            onPressed: () async {
                                            //  _incrementQuantity(item.id);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),*/
                                    CountControllerComponentWidget(
                                    //  key: Key('Keyqvb_${getCatalougeProductListIndex}_of_${_model.listViewPagingController!.itemList!.length}'),
                                      countValue: FFAppState().cartCount,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 0.0, 0.0),
                                      child: FFButtonWidget(
                                        onPressed: () {

                                          print( FFAppState().cartCount,);
                                          _addItem(
                                            getJsonField(getListItem, r'''$.id''',),
                                            getJsonField(getListItem, r'''$.name''',).toString(),
                                            getJsonField(getListItem, r'''$.price''',),
                                            FFAppState().cartCount,
                                            getJsonField(getListItem, r'''$.sku''',).toString(),
                                            getJsonField(getListItem, r'''$.images[:].src''',).toString(),
                                            getJsonField(getListItem, r'''$.slug''',),
                                          ).then((_) {
                                            // Show a dialog box after the item has been added successfully
                                            _showDialog(context, "Item Added", "Item hase been added to the cart");
                                            FFAppState().cartCount = 1;
                                          }).catchError((error) {
                                            // Handle any errors here
                                            _showDialog(context, "Error", "An error occurred while adding the item to the cart.");
                                          });
                                        },

                                        text: 'Add',
                                        icon: Icon(
                                          Icons.shopping_cart_outlined,
                                          size: 15.0,
                                        ),
                                        options: FFButtonOptions(
                                          height: 30.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          //color: Color(0xFFE00F0F),
                                          color: Color(0xFF2DD36F),
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: Colors.white,
                                                    fontSize: 13.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                  ),
                                          elevation: 0.0,
                                          borderSide: BorderSide(
                                           // color: Color(0xFFE00F0F),
                                            color: Color(0xFF2DD36F),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                /* Row(
                                  children: [
                                    SizedBox(
                                      width: 140,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(0.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 20.0,
                                              buttonSize: 30.0,
                                              fillColor: Color(0xFFEB445A),
                                              icon: FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: FlutterFlowTheme.of(context).info,
                                                size: 15.0,
                                              ),
                                              showLoadingIndicator: true,
                                              onPressed: () async {
                                                // Decrement the quantity if it's greater than 1

                                              },
                                            ),
                                          ),
                                          Text('${FFAppState().cartCount}',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Open Sans',
                                              letterSpacing: 0.0,
                                            ),
                                          ),
                                          FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 20.0,
                                            buttonSize: 30.0,
                                            fillColor: Color(0xFF2DD36F),
                                            icon: FaIcon(
                                              FontAwesomeIcons.plus,
                                              color: FlutterFlowTheme.of(context).info,
                                              size: 15.0,
                                            ),
                                            showLoadingIndicator: true,
                                            onPressed: () async {
                                              // Increment the quantity

                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          print(FFAppState().cartCount);
                                          _addItem(
                                            getJsonField(getListItem, r'''$.id'''),
                                            getJsonField(getListItem, r'''$.name''').toString(),
                                            getJsonField(getListItem, r'''$.price'''),
                                          //  FFAppState().cartCount,
                                            quantity[getCatalougeProductListIndex],
                                            getJsonField(getListItem, r'''$.sku''').toString(),
                                            getJsonField(getListItem, r'''$.images[:].src''').toString(),
                                            getJsonField(getListItem, r'''$.slug'''),
                                          ).then((_) {
                                            // Show a dialog box after the item has been added successfully
                                            _showDialog(context, "Item Added", "Item has been added to the cart");
                                          }).catchError((error) {
                                            // Handle any errors here
                                            _showDialog(context, "Error", "An error occurred while adding the item to the cart.");
                                          });
                                        },
                                        text: 'Add',
                                        icon: Icon(
                                          Icons.shopping_cart_outlined,
                                          size: 15.0,
                                        ),
                                        options: FFButtonOptions(
                                          height: 30.0,
                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                          color: Color(0xFF2DD36F),
                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                            fontFamily: 'Open Sans',
                                            color: Colors.white,
                                            fontSize: 13.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          elevation: 0.0,
                                          borderSide: BorderSide(
                                            color: Color(0xFF2DD36F),
                                          ),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
*/
                                FFButtonWidget(
                                  onPressed: () async {


                                    // Check if the product is already marked as favorite
                                    if (isFavorite) {
                                      // Make API call to remove from wishlist
                                      final removeResponse = await RemoveProductToWishlistCallNew.call(
                                        userId: FFAppState().userId,
                                        productSku: getJsonField(
                                          getListItem,
                                          r'''$.sku''',
                                        ).toString(),
                                         
                                      );

                                      // Update UI and local state if API call is successful
                                      if (removeResponse.succeeded) {
                                        setState(() {
                                          isFavorite = false;  // Change isFavorite
                                          getListItem['is_favorite'] = false;
                                          print('removeResponse-->>${getListItem['is_favorite']}');// Sync with item
                                        });
                                      }
                                    } else {
                                      // Make API call to add to wishlist
                                      final addResponse = await AddProductToWishlistCallNew.call(
                                        userId: FFAppState().userId,
                                        productSku: getJsonField(
                                          getListItem,
                                          r'''$.sku''',
                                        ).toString(),
                                         
                                      );

                                      // Update UI and local state if API call is successful
                                      if (addResponse.succeeded) {
                                        setState(() {
                                          isFavorite = true;  // Change isFavorite
                                          getListItem['is_favorite'] = true;  // Sync with item

                                          print('addResponse-->>${getListItem['is_favorite']}');
                                        });
                                      }
                                    }
                                  },
                                  text: isFavorite ? 'Remove' : 'Add',
                                  icon: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,  // Update icon instantly
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 30.0,
                                    color: isFavorite ? Color(0xFFE00F0F) : Color(0xFF27AEDF),  // Instant color change
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Open Sans',
                                      color: Colors.white,
                                      fontSize: 13.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: isFavorite ? Color(0xFFE00F0F) : Color(0xFF27AEDF),
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),



                              ],
                            ),
                          /*  IconButton(
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                if (isFavorite) {
                                  RemoveProductToWishlistCallNew.call(
                                    userId: FFAppState().userId,
                                    productSku: getJsonField(
                                      getListItem,
                                      r'''$.sku''',
                                    ).toString(),
                                  );
                                  // Remove from favorites
                                  //removeFromFavorites(getListItem['id']);
                                } else {
                                  AddProductToWishlistCallNew.call(
                                    userId: FFAppState().userId,
                                    productSku: getJsonField(
                                      getListItem,
                                      r'''$.sku''',
                                    ).toString(),
                                  );
                                  // Add to favorites
                                  //addToFavorites(getListItem['id']);
                                }
                              },
                            ),*/
                            Divider()
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationWidget(
        selectedPage: 'catalouge', // Pass the selected page
      ),
    );
  }

  Future<void> _addItem(int id, String name , String price ,int quantity, String pn , String image,String slug) async {

    final newItem = CartItem(id: id, name: name, price: price, quantity: quantity, pn: pn,image: image, slug: slug);
    _cartService.addToCart(newItem);
    _loadCart();

    setState(() {

    });
  }


  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () async {
                _loadCart();
                final cartItems = await _cartService.getCart();
                setState(() {
                  _cartItems = cartItems;
                  print(_cartItems.length);
                  //FFAppState().cartCount = _cartItems.length;
                  count = _cartItems.length;


                  print('count instant -------$count');
                });
                setState(() {

                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}



