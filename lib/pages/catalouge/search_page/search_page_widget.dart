import 'package:aqaumatic_app/Cart/CartModel.dart';
import 'package:aqaumatic_app/Cart/cart_page.dart';
import 'package:aqaumatic_app/Cart/cart_service.dart';
import 'package:aqaumatic_app/components/count_controller_component_widget.dart';
import 'package:aqaumatic_app/favourite/favorite_service.dart';

import '../../../favourite/favourite_model.dart';
import '../../../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../catalouge_details_page/catalouge_details_page_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'search_page_model.dart';
export 'search_page_model.dart';

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({
    super.key,
    this.name,

  });

  final String? name;

  @override
  State<SearchPageWidget> createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  late SearchPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  final FavouriteService _favoritesService = FavouriteService();
  List<int> favorites = [];
  int count = 0;
  Future<void> _loadFavorites() async {
    List<FavoriteItem> favoritesList = await _favoritesService.getFavourite();
    setState(() {
      favorites = favoritesList.map((item) => item.id).toList(); // Assuming FavoriteItem has an 'id'
    });
  }
  @override
  void initState() {
    super.initState();
    _loadFavorites();
    FFAppState().cartCount = 1;
    _loadCart();
    _model = createModel(context, () => SearchPageModel());

    // On page load action.
    // SchedulerBinding.instance.addPostFrameCallback((_) async {
    //   context.safePop();
    // });
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
      print(_cartItems.length);
      FFAppState().cartCount = _cartItems.length;
      count = _cartItems.length;


      print('count instant -------$count');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: Color(0xFF27AEDF),
        automaticallyImplyLeading: false,
        leading: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: FlutterFlowIconButton(
          //  borderColor: Color(0xFF27AEDF),
            borderRadius: 0.0,
            borderWidth: 1.0,
            //fillColor: Color(0xFF27AEDF),
            icon: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              size: 24.0,
            ),
            onPressed: () async {
             // Navigator.pop(context);
              context.safePop();
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
        flexibleSpace: FlexibleSpaceBar(
          title: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 200.0, 0.0),
            child: Text(
              'Search ',
              textAlign: TextAlign.justify,
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Open Sans',
                    color: Colors.white,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          centerTitle: true,
          expandedTitleScale: 1.0,
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        top: true,
        child: FutureBuilder<ApiCallResponse>(
          future: GetCatalougeSearchCall.call(
            catalougeName: widget.name,
          ),
          builder: (context, snapshot) {
            // Show loading spinner while data is being fetched
            if (!snapshot.hasData) {
              return Center(
                child: SpinKitFadingCircle(
                  color: FlutterFlowTheme.of(context).primary,
                  size: 40.0,
                ),
              );
            }

            // Fetch response data
            final listViewGetCatalougeSearchResponse = snapshot.data!;

            // Extract the list from the JSON response using correct handling
            final getSearchList = getJsonField(
              listViewGetCatalougeSearchResponse.jsonBody,
              r'''$[:]''', // Ensure this path correctly targets the list
            );

            // Check the type and content of getSearchList
            print(getSearchList);

            // Check if the extracted data is a list
            if (getSearchList is List) {
              return getSearchList.isEmpty ?Text('No result found',style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Open Sans',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),):ListView.builder(
                itemCount: getSearchList.length,
                itemBuilder: (context, index) {
                  final itemList = getSearchList[index];
                  bool isFavourite1 = favorites.contains(itemList['id']); // Use map access
                  return GestureDetector(
                    onTap: (){
                      context.pushNamed(
                        'CatalougeDetailsPage',
                        queryParameters: {
                          'slugName': serializeParam(
                            itemList['slug'].toString(),
                            ParamType.String,
                          ),
                        }.withoutNulls,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
                      child: Column(
                        //mainAxisSize: MainAxisSize.max,
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
                                            itemList['images'][0]['src'],
                                            fit: BoxFit.contain,
                                            errorBuilder: (context, error,
                                                stackTrace) =>
                                                Image.asset(
                                                  'assets/images/error_image.png',
                                                  fit: BoxFit.contain,
                                                ),
                                          ),
                                          allowRotation: false,
                                          tag: itemList['image'][0]['src'],
                                          useHeroAnimation: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag:itemList['images'][0]['src'],
                                    transitionOnUserGestures: true,
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      child: Image.network(
                                        itemList['images'][0]['src'],
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
                                        itemList['name'] ?? 'No name',
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
                                              text: itemList['sku'] ?? 'No name',/*,getJsonField(
                                                getCatalougeProductListItem,
                                                r'''$.sku''',
                                              ).toString(),*/
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
                                              text: '£ ',
                                              style: TextStyle(),
                                            ),
                                            TextSpan(
                                              text: itemList['price'] ?? 'No name',/*getJsonField(
                                                getCatalougeProductListItem,
                                                r'''$.price''',
                                              ).toString(),*/
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
                                          final slug = itemList['slug'] ?? 'No name';/*serializeParam(
                                            getJsonField(getCatalougeProductListItem,
                                                r'''$.slug''')
                                                .toString(),
                                            ParamType.String,
                                          );
              */
                                          if (slug != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CatalougeDetailsPageWidget(
                                                      slugName: slug,
                                                      catName: '',
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
                                  CountControllerComponentWidget(
                                   // key: Key('Keyqvb_${getCatalougeProductListIndex}_of_${_model.listViewPagingController!.itemList!.length}'),
                                    countValue: FFAppState().cartCount,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        _addItem(
                                          itemList['id'],
                                          itemList['name'].toString(),
                                          itemList['price'],
                                          FFAppState().cartCount,
                                          itemList['sku'],
                                          itemList['images'][0]['src'],

                                          itemList['sku'],
                                        ).then((_) {
                                          // Show a dialog box after the item has been added successfully
                                          _showDialog(context, "Item Added", "The item has been successfully added to your cart.");
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
                                        color: Color(0xFFE00F0F),
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
                                          color: Color(0xFFE00F0F),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              FFButtonWidget(
                                onPressed: () async {
                                  if (isFavourite1) {
                                    await _favoritesService.removeFromFavourite(itemList['id']); // Access via map
                                  } else {
                                    FavoriteItem newItem = FavoriteItem(

                                      id: itemList['id'],
                                      name: itemList['name'].toString(),
                                      price: itemList['price'],
                                      sku: itemList['sku'],
                                      imageUrl:  itemList['images'][0]['src'],

                                      // id: getJsonField(getCatalougeProductListItem, r'''$.id''',),
                                      // name: getJsonField(getCatalougeProductListItem, r'''$.name''',).toString(),
                                      // sku: getJsonField(getCatalougeProductListItem, r'''$.sku''',).toString(),
                                      // price: getJsonField(getCatalougeProductListItem, r'''$.price''',),
                                      // imageUrl: getJsonField(getCatalougeProductListItem, r'''$.images[:].src''',).toString(),

                                    );
                                    //  await favouriteService.addToFavourite(newItem);
                                    await _favoritesService.addToFavourite(newItem); // Access via map
                                  }
                                  await _loadFavorites(); // Refresh favorites list
                                },
                               text: isFavourite1 ? 'Remove' : 'Add',
                               // text:'Add',
                                icon:Icon(
                                  Icons.favorite_border,
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                  size: 20.0,
                                ),
                                options: FFButtonOptions(
                                  width: 100.0,
                                  height: 30.0,
                                 color: isFavourite1 ? Color(0xFFE00F0F) : Color(0xFF27AEDF),
                                 // color:  Color(0xFFE00F0F) ,
                                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Open Sans',
                                    color: Colors.white,
                                  ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                   // color:  Color(0xFFE00F0F) ,
                                  color: isFavourite1 ? Color(0xFFE00F0F) : Color(0xFF27AEDF),
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    ),
                  );
                  // Customize list item appearance
                  /*return ListTile(
                    leading: item['image'] != null
                        ? Image.network(
                      item['image'][0]['src'], // Adjust based on actual key structure
                      fit: BoxFit.cover,
                      width: 130.0,
                      height: 130.0,
                    )
                        : Icon(Icons.image), // Fallback icon if no image
                    title: Text(item['name'] ?? 'No name'),
                  );*/
                },
              );
            } else if (getSearchList is Map) {
              // Handle map case differently, wrap in a list if needed
              final item = [getSearchList];
              return ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  final itemMap = item[index];
                  bool isFavouriteMap = favorites.contains(itemMap['id']);
                  return GestureDetector(
                    onTap: (){
                      context.pushNamed(
                        'CatalougeDetailsPage',
                        queryParameters: {
                          'slugName': serializeParam(
                            itemMap['slug'].toString(),
                            ParamType.String,
                          ),
                        }.withoutNulls,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
                      child: Column(
                        //mainAxisSize: MainAxisSize.max,
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
                                            itemMap['images'][0]['src'],
                                            fit: BoxFit.contain,
                                            errorBuilder: (context, error,
                                                stackTrace) =>
                                                Image.asset(
                                                  'assets/images/error_image.png',
                                                  fit: BoxFit.contain,
                                                ),
                                          ),
                                          allowRotation: false,
                                          tag: itemMap['images'][0]['src'],
                                          useHeroAnimation: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag:itemMap['images'][0]['src'],
                                    transitionOnUserGestures: true,
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      child: Image.network(
                                        itemMap['images'][0]['src'],
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
                                        itemMap['name'] ?? 'No name',
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
                                              text: itemMap['sku'] ?? 'No name',/*,getJsonField(
                                                getCatalougeProductListItem,
                                                r'''$.sku''',
                                              ).toString(),*/
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
                                              text: '£ ',
                                              style: TextStyle(),
                                            ),
                                            TextSpan(
                                              text: itemMap['price'] ?? 'No name',/*getJsonField(
                                                getCatalougeProductListItem,
                                                r'''$.price''',
                                              ).toString(),*/
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
                                          final slug = itemMap['slug'] ?? 'No name';/*serializeParam(
                                            getJsonField(getCatalougeProductListItem,
                                                r'''$.slug''')
                                                .toString(),
                                            ParamType.String,
                                          );
              */
                                          if (slug != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CatalougeDetailsPageWidget(
                                                      slugName: slug,
                                                      catName: '',
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
                                  CountControllerComponentWidget(
                                    // key: Key('Keyqvb_${getCatalougeProductListIndex}_of_${_model.listViewPagingController!.itemList!.length}'),
                                    countValue: FFAppState().cartCount,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        _addItem(
                                          itemMap['id'],
                                          itemMap['name'].toString(),
                                          itemMap['price'],
                                          FFAppState().cartCount,
                                          itemMap['sku'],
                                          itemMap['images'][0]['src'],

                                          itemMap['sku'],
                                        ).then((_) {
                                          // Show a dialog box after the item has been added successfully
                                          _showDialog(context, "Item Added", "The item has been successfully added to your cart.");
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
                                        color: Color(0xFFE00F0F),
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
                                          color: Color(0xFFE00F0F),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              FFButtonWidget(
                                onPressed: () async {
                                  if (isFavouriteMap) {
                                    await _favoritesService.removeFromFavourite(itemMap['id']); // Access via map
                                  } else {
                                    FavoriteItem newItem = FavoriteItem(

                                      id: itemMap['id'],
                                      name: itemMap['name'].toString(),
                                      price: itemMap['price'],
                                      sku: itemMap['sku'],
                                      imageUrl:  itemMap['images'][0]['src'],

                                      // id: getJsonField(getCatalougeProductListItem, r'''$.id''',),
                                      // name: getJsonField(getCatalougeProductListItem, r'''$.name''',).toString(),
                                      // sku: getJsonField(getCatalougeProductListItem, r'''$.sku''',).toString(),
                                      // price: getJsonField(getCatalougeProductListItem, r'''$.price''',),
                                      // imageUrl: getJsonField(getCatalougeProductListItem, r'''$.images[:].src''',).toString(),

                                    );
                                    //  await favouriteService.addToFavourite(newItem);
                                    await _favoritesService.addToFavourite(newItem); // Access via map
                                  }
                                  await _loadFavorites(); // Refresh favorites list
                                },
                                text: isFavouriteMap ? 'Remove' : 'Add',
                                // text:'Add',
                                icon:Icon(
                                  Icons.favorite_border,
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                  size: 20.0,
                                ),
                                options: FFButtonOptions(
                                  width: 100.0,
                                  height: 30.0,
                                  color: isFavouriteMap ? Color(0xFFE00F0F) : Color(0xFF27AEDF),
                                  // color:  Color(0xFFE00F0F) ,
                                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Open Sans',
                                    color: Colors.white,
                                  ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    // color:  Color(0xFFE00F0F) ,
                                    color: isFavouriteMap ? Color(0xFFE00F0F) : Color(0xFF27AEDF),
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              // Handle unexpected data type
              return Center(
                child: Text(
                  'Data format error: expected a list but got ${getSearchList.runtimeType}.',
                ),
              );
            }
          },
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
