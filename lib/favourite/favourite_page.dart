import 'package:aqaumatic_app/Cart/cart_page.dart';
import 'package:aqaumatic_app/flutter_flow/flutter_flow_theme.dart';
import 'package:aqaumatic_app/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import '../Cart/CartModel.dart';
import '../Cart/cart_service.dart';
import '../app_constants.dart';
import '../app_state.dart';
import '../components/count_controller_component_widget.dart';
import '../components/customDrawer.dart';
import '../components/custom_bottom_navigation_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'favorite_service.dart';
import 'favourite_model.dart';
import 'package:badges/badges.dart' as badges;

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FavouriteService _favoritesService = FavouriteService();
  List<FavoriteItem> _favorites = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  int count = 0;
  @override
  void initState() {
    super.initState();
    FFAppState().cartCount = 1;
    _loadCart();
    _loadFavorites();
  }


  @override
  void dispose() {
    //_model.dispose();

    super.dispose();
  }
  Future<void> _loadCart() async {
    final cartItems = await _cartService.getCart();
    setState(() {
      _cartItems = cartItems;
     // FFAppState().cartCount = _cartItems.length;
      count = _cartItems.length;


      print('count instant -------$count');
    });
  }

  Future<void> _loadFavorites() async {
    List<FavoriteItem> favorites = await _favoritesService.getFavourite();
    setState(() {
      _favorites = favorites;
    });
  }
  //


  void _addToFavorites(FavoriteItem item) async {
    await _favoritesService.addToFavourite(item);
    _loadFavorites(); // Refresh the list
  }

  void _removeFromFavorites(int id) async {
    await _favoritesService.removeFromFavourite(id);
    _loadFavorites(); // Refresh the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      drawer: CustomDrawer(
        firstName: FFAppState().firstName,
        lastName: FFAppState().lastName,
        contactNumber: FFAppConstants.contact.toString(),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF27AEDF),
        automaticallyImplyLeading: false,
        leading: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: FlutterFlowIconButton(
            //borderColor: Color(0xFF27AEDF),
            borderRadius: 0.0,
            borderWidth: 1.0,
            buttonSize: 46.0,
            //fillColor: Color(0xFF27AEDF),
            icon: Icon(
              Icons.menu_rounded,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              size: 24.0,
            ),
            onPressed: () async {
              scaffoldKey.currentState!.openDrawer();
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
          title: Text(
            'Favourites',
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
        selectedPage: 'favourites', // Pass the selected page
      ),
      body:  _favorites.isEmpty
          ? Center(
        child: Text(
          'No favorites added yet!',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Open Sans',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
          : ListView.builder(
        itemCount: _favorites.length,
        itemBuilder: (context, index) {
          final item = _favorites[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        item.imageUrl,  // Display the image from FavoriteItem
                        width: double.infinity,
                        height: 209.0,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error,
                            stackTrace) =>
                            Image.asset(
                              'assets/images/error_image.png',
                              fit: BoxFit.contain,
                            ),
                      ),
                    ),
                    Positioned(
                      top: 30.0,
                      right: 10.0,
                      child: FlutterFlowIconButton(
                        borderColor: Color(0xFFE00F0F),
                        borderRadius: 20.0,
                        borderWidth: 1.0,
                        buttonSize: 40.0,
                        fillColor: Color(0xFFE00F0F),
                        icon: Icon(
                          Icons.favorite,
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          size: 24.0,
                        ),
                        onPressed: () async {


                          await _favoritesService.removeFromFavourite(item.id);
                          _removeFromFavorites(item.id); // Trigger the callback to refresh favorites



                          // You can add remove from favorites functionality here
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                      child: Text(
                        'P/N : ${item.sku}',  // Display SKU
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Open Sans',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: Text(
                        item.name,  // Display name from FavoriteItem
                        maxLines: 2,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Open Sans',
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                      child: Text(
                        'Price : £ ${item.price}',  // Display price from FavoriteItem
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Open Sans',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CountControllerComponentWidget(
                            countValue: FFAppState().cartCount,  // Your cart counter logic
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              final newItem = CartItem(
                                id: item.id,
                                name: item.name,
                                price: item.price,
                                quantity: FFAppState().cartCount,
                                pn: item.sku,
                                image: item.imageUrl, slug: '',
                                // Add slug if needed
                              );
                              await _cartService.addToCart(newItem);
                              _showDialog(context, "Added to Cart", "Item added successfully.");


                              // Add to cart functionality here
                            },
                            text: 'Add to cart',
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              size: 15.0,
                            ),
                            options: FFButtonOptions(
                              width: 150.0,
                              height: 30.0,
                              color: Color(0xFF1076BA),
                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Open Sans',
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                              ),
                              borderSide: BorderSide(
                                color: Color(0xFF1076BA),
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          );/*WishlistItem(
            item: item,  // Pass the FavoriteItem
            favorites: _favorites,
            favoritesService: _favoritesService,
            cartService: _cartService,
            onRemove: () => _removeFromFavorites(item.id),
            loadCart:() => _loadCart,
            cartNewItems:_cartItems,
            count: count,


          );*/
        },
      ),

    );
  }

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // stream: null,
            builder: (context, bSetState) {
              return AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: <Widget>[
                  TextButton(
                    child: Text("OK"),
                    onPressed: () async {


                      final cartItems = await _cartService.getCart();
                      bSetState(() {
                        _cartItems = cartItems;
                        print(cartItems.length);
                        //FFAppState().cartCount = _cartItems.length;
                        count = cartItems.length;


                        print('count instant -------$count');
                        _loadCart();
                      });
                      bSetState(() {

                      });
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              );
            }
        );
      },
    );
}}
/*class WishlistItem extends StatelessWidget {
  final FavoriteItem item;  // Update to FavoriteItem type
  List<FavoriteItem> favorites = [];
   FavouriteService favoritesService = FavouriteService();
  final VoidCallback onRemove;
  final VoidCallback loadCart;
  final CartService cartService;
  List<CartItem> cartNewItems = [];
  int count;
  WishlistItem({super.key,required this.item, required this.favorites,required this.favoritesService, required this.onRemove, required this.cartService, required this.loadCart, required this.cartNewItems, required this.count});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional(0.0, -1.0),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  item.imageUrl,  // Display the image from FavoriteItem
                  width: double.infinity,
                  height: 209.0,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error,
                      stackTrace) =>
                      Image.asset(
                        'assets/images/error_image.png',
                        fit: BoxFit.contain,
                      ),
                ),
              ),
              Positioned(
                top: 30.0,
                right: 10.0,
                child: FlutterFlowIconButton(
                  borderColor: Color(0xFFE00F0F),
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  fillColor: Color(0xFFE00F0F),
                  icon: Icon(
                    Icons.favorite,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    size: 24.0,
                  ),
                  onPressed: () async {


                      await favoritesService.removeFromFavourite(item.id);
                      onRemove(); // Trigger the callback to refresh favorites



                    // You can add remove from favorites functionality here
                  },
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                child: Text(
                  'P/N : ${item.sku}',  // Display SKU
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Open Sans',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: Text(
                  item.name,  // Display name from FavoriteItem
                  maxLines: 2,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Open Sans',
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: Text(
                  'Price : £ ${item.price}',  // Display price from FavoriteItem
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Open Sans',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CountControllerComponentWidget(
                      countValue: FFAppState().cartCount,  // Your cart counter logic
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        final newItem = CartItem(
                          id: item.id,
                          name: item.name,
                          price: item.price,
                          quantity: FFAppState().cartCount,
                          pn: item.sku,
                          image: item.imageUrl, slug: '',
                         // Add slug if needed
                        );
                        await cartService.addToCart(newItem);
                        _showDialog(context, "Added to Cart", "Item added successfully.");


                        // Add to cart functionality here
                      },
                      text: 'Add to cart',
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        width: 150.0,
                        height: 30.0,
                        color: Color(0xFF1076BA),
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Open Sans',
                          color: Colors.white,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                        ),
                        borderSide: BorderSide(
                          color: Color(0xFF1076BA),
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
         // stream: null,
          builder: (context, bSetState) {
            return AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () async {


                    final cartItems = await cartService.getCart();
                    bSetState(() {
                      cartNewItems = cartItems;
                      print(cartItems.length);
                      //FFAppState().cartCount = _cartItems.length;
                      count = cartItems.length;


                      print('count instant -------$count');
                      loadCart();
                    });
                    bSetState(() {

                    });
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          }
        );
      },
    );
  }
}*/