/*
import 'package:aqaumatic_app/Cart/cart_service.dart';
import 'package:aqaumatic_app/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

import '../app_state.dart';
import '../components/customDrawer.dart';
import '../components/custom_bottom_navigation_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'CartModel.dart';


class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final cartItems = await _cartService.getCart();
    setState(() {
      _cartItems = cartItems;
    });
    // print(cartItems.length);
    print("Cart Items after loading: ${cartItems.map((item) => item.quantity).toList()}"); // Log quantities

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadCart();  // Load the cart again every time you come back to the cart page
  }

  void _removeItem(int id) {
    _cartService.removeFromCart(id);
    _loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
            borderColor: Color(0xFF27AEDF),
            borderRadius: 0.0,
            borderWidth: 0.0,
            buttonSize: 46.0,
            fillColor: Color(0xFF27AEDF),
            icon: Icon(
              Icons.menu_sharp,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              size: 24.0,
            ),
            onPressed: () async {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
            child: FlutterFlowIconButton(
              borderColor: Color(0xFF27AEDF),
              borderRadius: 0.0,
              borderWidth: 0.0,
              buttonSize: 40.0,
              fillColor: Color(0xFF27AEDF),
              icon: Icon(
                Icons.close,
                color: FlutterFlowTheme.of(context).secondaryBackground,
                size: 24.0,
              ),
              onPressed: () async {
                await _cartService.clearCart();
                _loadCart();

              },
            ),
          ),
        ],
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            'Your Cart',
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

      body:ListView.builder(

        padding: EdgeInsets.zero,
        itemCount: _cartItems.length,
        itemBuilder: (context, index) {
          final item = _cartItems[index];
          return _cartItems.isEmpty?Text('Your Cart is empty',style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Open Sans',
            color: Colors.black,
            fontSize: 16.0,
            letterSpacing: 0.0,
            fontWeight: FontWeight.w600,
          ),): Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        '${item.image}',
                        width: 130.0,
                        height: 130.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              maxLines: 2,
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Open Sans',
                                color: Colors.black,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'P/N: ',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Open Sans',
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: item.pn,
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Open Sans',
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Price: £ ',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Open Sans',
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: item.price.toString(), // Ensure price is a string
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Open Sans',
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                buttonSize: 35.0,
                                fillColor: Color(0xFFEB445A),
                                icon: FaIcon(
                                  FontAwesomeIcons.minus,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 20.0,
                                ),
                                showLoadingIndicator: true,
                                onPressed: () async {
                                  _decrementQuantity(item.id);
                                  // Pass the item id to increment the quantity
                                },
                              ),
                            ),
                            Text(
                              '${item.quantity}',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Open Sans',
                                letterSpacing: 0.0,
                              ),
                            ),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 20.0,
                              buttonSize: 35.0,
                              fillColor: Color(0xFF2DD36F),
                              icon: Icon(
                                Icons.add,
                                color: FlutterFlowTheme.of(context).info,
                                size: 20.0,
                              ),
                              showLoadingIndicator: true,
                              onPressed: () async {
                                _incrementQuantity(item.id);

                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            _removeItem(item.id);
                          },
                          text: 'Remove',
                          icon: Icon(
                            Icons.delete_outline,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            height: 30.0,
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFE00F0F),
                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Open Sans',
                              color: Colors.white,
                              fontSize: 13.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                            ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Color(0xFFE00F0F),
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),

              ],
            ),
          );
        },
      ),

      bottomNavigationBar: CustomBottomNavigationWidget(selectedPage: '',),
    );
  }

  Future<void> _incrementQuantity(int id) async {

    setState(() {
      for (var item in _cartItems) {
        if (item.id == id) {
          item.quantity++; // Increment the quantity
          _cartService.updateCartItem(id, item.quantity); // Update in the backend or shared preferences
          break;
        }


      }

    });
   await _loadCart();

  }

  Future<void> _decrementQuantity(int id) async {
    setState(() {
      for (var item in _cartItems) {
        if (item.id == id && item.quantity > 1) {
          item.quantity--;  // Decrement the quantity in UI
          _cartService.updateCartItem(id, item.quantity);  // Update in shared preferences
          break;
        }
      }
    });
    await _loadCart();
  }


}
*/
import 'dart:io';

import 'package:aqaumatic_app/Cart/cart_service.dart';
import 'package:aqaumatic_app/app_constants.dart';
import 'package:aqaumatic_app/backend/api_requests/api_calls.dart';
import 'package:aqaumatic_app/flutter_flow/flutter_flow_util.dart';
import 'package:aqaumatic_app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import '../flutter_flow/custom_functions.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '../app_state.dart';
import '../components/customDrawer.dart';
import '../components/custom_bottom_navigation_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'CartModel.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  final CartService _cartService = CartService();
  List<CartItem>? _cartItems; // Allow cart items to be null initially
  final scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic items;
  bool isLoading = false;
  String selectedAddress = 'Billing Address';
  final TextEditingController purchaseOrderController = TextEditingController();
  final TextEditingController customerNotesController = TextEditingController();
   Future<dynamic>? userProfileFuture;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    _loadCart();
    userProfileFuture = fetchUserProfile();
  }
  Future<dynamic> fetchUserProfile() async {
    try {
      var userProfile = await GetUserProfileCall.call(userId: FFAppState().userId,);
      print('Error fetching user profile: ${userProfile.jsonBody}');
      return userProfile.jsonBody;
      // Return the profile data
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }
  Future<void> _loadCart() async {
    List<CartItem> cart = await _cartService.getCart();
    setState(() {
      _cartItems = cart;
      if (_cartItems != null && _cartItems!.isNotEmpty) {
        items = lineItems(_cartItems!); // Use _cartItems to get the products
        print("Formatted Line Items: $items");
      }
    });
  }




  /*Future<void> _loadCart() async {
    // Fetch cart items from SharedPreferences using _cartService
    final cartItems = await _cartService.getCart();

    setState(() {
      _cartItems = cartItems;

      // If cart items are not empty, transform them into the desired format
      if (_cartItems != null && _cartItems!.isNotEmpty) {
        items = lineItems(_cartItems!); // Use _cartItems to get the products
        print("Formatted Line Items: $items");
      }
    });

    // Log cart items quantities to verify
    print("Cart Items after loading: ${_cartItems?.map((item) => item.quantity).toList()}");
  }*/

  dynamic lineItems(List<CartItem> cartItems) {
    // Transform cart items into the required format for order creation
    return cartItems
        .map((item) => {
      "product_id": item.id, // Set 0 if no variation
      "quantity": item.quantity,
      "SKU": item.pn
    }).toList();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadCart();  // Load the cart again every time you come back to the cart page
  }

  void _removeItem(int id) async{
    await _cartService.removeFromCart(id);
    _loadCart();
  }

  double _calculateTotal() {
    double total = 0.0;
    if (_cartItems != null) {
      for (var item in _cartItems!) {
        total += double.parse(item.price.toString()) * item.quantity;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,

      onPopInvoked: (didPop) {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
        // SystemNavigator.pop();
        // faça o que precisar...
      },
      child: Scaffold(
         backgroundColor: Colors.white,
        key: scaffoldKey,
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
              borderWidth: 0.0,
              buttonSize: 46.0,
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
          ),
          actions: [
            _cartItems == null || _cartItems!.isEmpty?Wrap():Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
              child: FlutterFlowIconButton(
              //  borderColor: Color(0xFF27AEDF),
                borderRadius: 0.0,
                borderWidth: 0.0,
                buttonSize: 40.0,
                //fillColor: Color(0xFF27AEDF),
                icon: Icon(
                  Icons.close,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  size: 24.0,
                ),
               /* onPressed: () async {
                  // Check if cart is empty before showing the dialog
                  if (_cartItems == null || _cartItems!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Your cart is already empty.',
                          style: TextStyle(
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                        backgroundColor: Colors.red, // Error color
                        duration: Duration(milliseconds: 3000),
                      ),
                    );
                    return; // Do nothing if the cart is already empty
                  }

                  // Show confirmation dialog
                  bool? confirmed = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: Text('Confirm'),
                        content: Text('Are you sure you want to clear the cart?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop(false); // User canceled
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop(true); // User confirmed
                            },
                            child: Text('Clear Cart'),
                          ),
                        ],
                      );
                    },
                  );

                  // If the user confirmed, clear the cart
                  if (confirmed == true) {
                    await _cartService.clearCart();
                    _loadCart();
                  }
                },*/

                onPressed: () async {
                  // Show confirmation dialog
                  bool? confirmed = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: Text('Confirm'),
                        content: Text('Are you sure you want to clear the cart?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop(false); // User canceled
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop(true); // User confirmed
                            },
                            child: Text('Clear Cart'),
                          ),
                        ],
                      );
                    },
                  );

                  // If the user confirmed, clear the cart
                  if (confirmed == true) {
                    await _cartService.clearCart();
                    _loadCart();
                  }
                },
              ),
            ),
          ],

          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Your Cart',
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
        body: _cartItems == null
            ? Center(child: CircularProgressIndicator()) // Show loading while cart items are being loaded
            : _cartItems!.isEmpty
            ? Center(child: Text('Your cart is empty',style: FlutterFlowTheme.of(context).bodyMedium.override(
          fontFamily: 'Open Sans',
          color: Colors.black,
          fontSize: 18.0,
          letterSpacing: 0.0,
          fontWeight: FontWeight.w600,
        ),))
            : SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true, // Ensure the ListView takes only as much space as it needs
                  padding: EdgeInsets.zero,
                  itemCount: _cartItems!.length,
                  itemBuilder: (context, index) {
                    final item = _cartItems![index];
                    return Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  '${item.image}',
                                  width: 120.0,
                                  height: 120.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        maxLines: 2,
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
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'P/N: ',
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
                                                text: item.pn,
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Price: £',
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
                                                text: item.price.toString(), // Ensure price is a string
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                          buttonSize: 35.0,
                                          fillColor: Color(0xFFEB445A),
                                          icon: FaIcon(
                                            FontAwesomeIcons.minus,
                                            color: FlutterFlowTheme.of(context).info,
                                            size: 20.0,
                                          ),
                                          showLoadingIndicator: true,
                                          onPressed: () async {
                                            _decrementQuantity(item.id);
                                          },
                                        ),
                                      ),
                                      Text(
                                        '${item.quantity}',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Open Sans',
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 20.0,
                                        buttonSize: 35.0,
                                        fillColor:  Color(0xFF2DD36F) ,
                                        icon: FaIcon(
                                          FontAwesomeIcons.plus,
                                          color: FlutterFlowTheme.of(context).info,
                                          size: 20.0,
                                        ),
                                        showLoadingIndicator: true,
                                        onPressed: () async {
                                          _incrementQuantity(item.id);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                FFButtonWidget(
                                  //showLoadingIndicator: true,
                                  onPressed: () async {
                                    // _removeItem(item.id);
                                    await _cartService.removeFromCart(item.id);
                                    _removeItem(item.id); // Trigger the callback to refresh favorites
                                    },
                                  text: 'Remove',
                                  icon: Icon(
                                    Icons.close,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    //width: 100.0,
                                    height: 30.0,
                                    color: Color(0xFFE00F0F),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      fontFamily: 'Open Sans',
                                      color: Colors.white,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    elevation: 0.0,

                                    borderSide: BorderSide(
                                      color: Color(0xFFE00F0F),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total: £${_calculateTotal().toStringAsFixed(2)}',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Open Sans',
                          fontSize: 23.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),

                ///Radio button add
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 15.0, 0.0),
                  child: Text(
                    'Delivery',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Open Sans',
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                RadioListTile(
                  dense: true,
                  activeColor:Color(0xFF27AEDF),
                  selectedTileColor: Color(0xFF27AEDF),
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text('Billing Address', style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Open Sans',
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w400,
                  ),),
                  value: 'Billing Address',
                  groupValue: selectedAddress,
                  onChanged: (value) {
                    setState(() {
                      selectedAddress = value!;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                  child: Divider(),
                ),
                RadioListTile(
                  activeColor:Color(0xFF27AEDF),
                  controlAffinity: ListTileControlAffinity.trailing,
                  dense: true,
                  selectedTileColor: Color(0xFF27AEDF),
                  title: Text('Delivery Address',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Open Sans',
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w400,
                  ),),
                  value: 'Delivery Address',
                  groupValue: selectedAddress,
                  onChanged: (value) {
                    setState(() {
                      selectedAddress = value!;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                  child: Divider(),
                ),
                RadioListTile(
                  activeColor:Color(0xFF27AEDF),
                  dense: true,
                  selectedTileColor: Color(0xFF27AEDF),
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text('Other Address', style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Open Sans',
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w400,
                  ),),
                  value: 'Other Address',
                  groupValue: selectedAddress,
                  onChanged: (value) {
                    setState(() {
                      selectedAddress = value!;
                      print(selectedAddress);
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                  child: Divider(),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 15.0, 0.0),
                  child: Text(
                    // Set the text conditionally based on selectedAddress
                    selectedAddress == 'Billing Address'
                        ? ''
                        : selectedAddress == 'Delivery Address'
                        ? 'Current delivery address'
                        : 'Please enter an alternate address in the customer notes section below',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Open Sans',
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                  child: Text('Details', style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Open Sans',
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),),
                ),
                selectedAddress == 'Delivery Address'
                              ? FutureBuilder<dynamic>(
                                  future: userProfileFuture,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child:
                                              CircularProgressIndicator()); // Loading indicator
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text('Error fetching profile data'));
                                    } else if (!snapshot.hasData ||
                                        snapshot.data == null) {
                                      return Center(
                                          child: Text('No data available'));
                                    }

                                    var userData = snapshot.data;

                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 5.0, 15.0, 0.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          userData['shipping']['address_1'] ==''?Wrap():Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text('Address :- ${userData['shipping']['address_1'] ?? ''}',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ),
                                          userData['shipping']['city'] ==''?Wrap():Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              'City :- ${userData['shipping']['city'] ?? ''}',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ),
                                          userData['shipping']['postcode'] ==''?Wrap(): Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              'Postcode :- ${userData['shipping']['postcode'] ?? ''}',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ),
                                          userData['shipping']['country'] ==''?Wrap(): Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              'Country :- ${userData['shipping']['country'] ?? ''}',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ),
                                          Divider(),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : Wrap(),
                          SizedBox(height: 10),

                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                  child: Text('Purchase Order',style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Open Sans',
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w400,
                  ),),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                  child: TextFormField(
                    controller: purchaseOrderController,
                    //autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelStyle: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                     // hintText: 'Type Old Password',
                      hintStyle: FlutterFlowTheme.of(context)
                          .labelMedium
                          .override(
                        fontFamily: 'Open Sans',
                        color:
                        FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 13.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w300,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF43484B),

                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF43484B),
                         // color: FlutterFlowTheme.of(context).primaryText,

                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF43484B),
                          //color: FlutterFlowTheme.of(context).error,

                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF43484B),
                         // color: FlutterFlowTheme.of(context).error,

                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                    ),
                    style:
                    FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Open Sans',
                      letterSpacing: 0.0,
                    ),

                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                  child: Text('Customer Notes', style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Open Sans',
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w400,
                  ),),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                  child: TextFormField(
                    maxLines: 4,
                    controller: customerNotesController,
                    //autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelStyle: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                     // hintText: 'Type Old Password',
                      hintStyle: FlutterFlowTheme.of(context)
                          .labelMedium
                          .override(
                        fontFamily: 'Open Sans',
                        color:
                        FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 13.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w300,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF43484B),


                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF43484B),
                          //color: FlutterFlowTheme.of(context).primaryText,

                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF43484B),
                          //color: FlutterFlowTheme.of(context).error,

                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF43484B),
                          //color: FlutterFlowTheme.of(context).error,

                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                    ),
                    style:
                    FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Open Sans',
                      letterSpacing: 0.0,
                    ),

                  ),
                ),

                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 15.0),
                  child: InkWell(
                  /*  onTap: () async {
                      // Validation check for Other Address
                      if (selectedAddress == 'Other Address') {
                        if (customerNotesController.text.trim().isEmpty) {
                          // Show validation error message if either of the fields are empty
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please fill in Customer Notes',
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              backgroundColor: Colors.red, // Error color
                              duration: Duration(milliseconds: 3000),
                            ),
                          );
                          return; // Stop execution if validation fails
                        }
                      }

                      // Show loading indicator
                      setState(() {
                        isLoading = true;
                      });

                      // Fetch user profile
                      var userProfile = await GetUserProfileCall.call(userId: FFAppState().userId);
                      var userData = userProfile.jsonBody;

                      // Extract user profile data
                      var bFName = GetUserProfileCall.bFName(userData);
                      var bLName = GetUserProfileCall.bLName(userData);
                      var bPhone = GetUserProfileCall.bPhone(userData);
                      var address1 = GetUserProfileCall.bAdd(userData);
                      var address2 = GetUserProfileCall.bAdd2(userData);
                      var city = GetUserProfileCall.bCity(userData);
                      var state = GetUserProfileCall.bState(userData);
                      var postcode = GetUserProfileCall.bPostCode(userData);
                      var country = GetUserProfileCall.bCountry(userData);

                      var shippingFirstName = GetUserProfileCall.shippingFName(userData);
                      var shippingLastName = GetUserProfileCall.shippingLName(userData);
                      var shippingPhone = GetUserProfileCall.shippingPhone(userData);
                      var shippingAddress1 = GetUserProfileCall.shippingAdd(userData);
                      var shippingAddress2 = GetUserProfileCall.shippingAdd2(userData);
                      var shippingCity = GetUserProfileCall.shippingCity(userData);
                      var shippingState = GetUserProfileCall.shippingState(userData);
                      var shippingPostcode = GetUserProfileCall.shippingPostCode(userData);
                      var shippingCountry = GetUserProfileCall.shippingCountry(userData);



                      // Create order
                      var orderCreate = await CreateOrderCall.call(
                        firstName: bFName,
                        lastName: bLName,
                        address1: address1,
                        address2: address2,
                        city: city,
                        state: state,
                        postcode: postcode,
                        country: country,
                        phone: bPhone,
                        customerNote: customerNotesController.text.trim(),
                        shippingFirstName: shippingFirstName,
                        shippingLastName: shippingLastName,
                        shippingAddress1: shippingAddress1,
                        shippingAddress2: shippingAddress2,
                        shippingCity: shippingCity,
                        shippingState: shippingState,
                        shippingPostcode: shippingPostcode,
                        shippingCountry: shippingCountry,
                        shippingPhone: shippingPhone,
                        billingMethod: selectedAddress,
                        purchaseNote: purchaseOrderController.text.trim(),
                        lineItemsJson: items,
                        customerId: FFAppState().userId.toString(),
                      );

                      // Handle order creation result
                      if (orderCreate.succeeded == true) {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPageWidget()));
                        await _cartService.clearCart();
                        _loadCart();
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Order not created',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      }
                    },*/
                    onTap: () async {
                      // Fetch user profile
                      var userProfile = await GetUserProfileCall.call(userId: FFAppState().userId,);
                      var userData = userProfile.jsonBody;

                      // Extract user profile data
                      var bFName = GetUserProfileCall.bFName(userData);
                      var bLName = GetUserProfileCall.bLName(userData);
                      var bPhone = GetUserProfileCall.bPhone(userData);
                      var address1 = GetUserProfileCall.bAdd(userData);
                      var address2 = GetUserProfileCall.bAdd2(userData);
                      var city = GetUserProfileCall.bCity(userData);
                      var state = GetUserProfileCall.bState(userData);
                      var postcode = GetUserProfileCall.bPostCode(userData);
                      var country = GetUserProfileCall.bCountry(userData);

                      var shippingFirstName = GetUserProfileCall.shippingFName(userData);
                      var shippingLastName = GetUserProfileCall.shippingLName(userData);
                      var shippingPhone = GetUserProfileCall.shippingPhone(userData);
                      var shippingAddress1 = GetUserProfileCall.shippingAdd(userData);
                      var shippingAddress2 = GetUserProfileCall.shippingAdd2(userData);
                      var shippingCity = GetUserProfileCall.shippingCity(userData);
                      var shippingState = GetUserProfileCall.shippingState(userData);
                      var shippingPostcode = GetUserProfileCall.shippingPostCode(userData);
                      var shippingCountry = GetUserProfileCall.shippingCountry(userData);

                      // Validation check for Other Address
                      if (selectedAddress == 'Other Address') {
                        if (customerNotesController.text.trim().isEmpty) {
                          // Show validation error message if either of the fields are empty
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please enter your address under the customer notes',
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              backgroundColor: Colors.red, // Error color
                              duration: Duration(milliseconds: 3000),
                            ),
                          );
                          return; // Stop execution if validation fails
                        }
                      }
                      // Validation for Billing Address
                      else if (selectedAddress == 'Billing Address') {
                        if (bFName == '' || bLName == '' || bPhone == '' ||
                            address1 == '' || city == '' || state == '' || postcode == '' || country == '') {
                          // Show validation error if any billing field is null
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Your billing address is empty please contact your administrator',
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              backgroundColor: Colors.red, // Error color
                              duration: Duration(milliseconds: 3000),
                            ),
                          );
                          setState(() {
                            isLoading = false;
                          });
                          return; // Stop execution if validation fails
                        }
                      }

                      // Validation for Delivery Address
                      else if (selectedAddress == 'Delivery Address') {
                        if (shippingFirstName == '' || shippingLastName == '' || shippingPhone == '' ||
                            shippingAddress1 == '' || shippingCity == '' || shippingState == '' || shippingPostcode == '' || shippingCountry == '') {
                          // Show validation error if any billing field is null
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Your delivery address is empty please contact your administrator',
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              backgroundColor: Colors.red, // Error color
                              duration: Duration(milliseconds: 3000),
                            ),
                          );
                          setState(() {
                            isLoading = false;
                          });
                          return; // Stop execution if validation fails
                        }
                      }

                      // Show loading indicator
                      setState(() {
                        isLoading = true;
                      });



                      // Create order
                      var orderCreate = await CreateOrderCall.call(
                        firstName: bFName,
                        lastName: bLName,
                        address1: address1,
                        address2: address2,
                        city: city,
                        state: state,
                        postcode: postcode,
                        country: country,
                        phone: bPhone,
                        customerNote: customerNotesController.text.trim(),
                        shippingFirstName: shippingFirstName,
                        shippingLastName: shippingLastName,
                        shippingAddress1: shippingAddress1,
                        shippingAddress2: shippingAddress2,
                        shippingCity: shippingCity,
                        shippingState: shippingState,
                        shippingPostcode: shippingPostcode,
                        shippingCountry: shippingCountry,
                        shippingPhone: shippingPhone,
                        billingMethod: selectedAddress,
                        purchaseNote: purchaseOrderController.text.trim(),
                        lineItemsJson: items,
                        customerId: FFAppState().userId.toString(),
                          
                      );

                      // Handle order creation result
                      if (orderCreate.succeeded == true) {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPageWidget()));
                        await _cartService.clearCart();
                        _loadCart();
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Order not created',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      }
                    },

                    child: Container(
                      width: double.infinity,
                      height: 45.0,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Color(0xFF27AEDF)),
                      child: Center(
                        child: isLoading
                            ? SizedBox(width: 23, height: 23,child: CircularProgressIndicator(color: Colors.white,))
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Submit order to aquamatic'.toUpperCase(),
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Open Sans',
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationWidget(selectedPage: '',),
      ),
    );
  }

  Future<void> _incrementQuantity(int id) async {
    await _cartService.incrementQuantity(id);
    _loadCart();  // Refresh the cart items after updating quantity
  }

  Future<void> _decrementQuantity(int id) async {
    await _cartService.decrementQuantity(id);
    _loadCart();  // Refresh the cart items after updating quantity
  }




}
