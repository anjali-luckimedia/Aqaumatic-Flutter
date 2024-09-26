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
import 'package:aqaumatic_app/Cart/cart_service.dart';
import 'package:aqaumatic_app/app_constants.dart';
import 'package:aqaumatic_app/backend/api_requests/api_calls.dart';
import 'package:aqaumatic_app/flutter_flow/flutter_flow_util.dart';
import 'package:aqaumatic_app/index.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    _loadCart();
  }

  Future<void> _loadCart() async {
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
  }

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

  void _removeItem(int id) {
    _cartService.removeFromCart(id);
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
        child: Column(
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
                              showLoadingIndicator: true,
                              onPressed: () {
                                _removeItem(item.id);
                              },
                              text: 'Remove',
                              icon: Icon(
                                Icons.close,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                                width: 100.0,
                                height: 35.0,
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
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total: £ ${_calculateTotal().toStringAsFixed(2)}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Open Sans',
                      fontSize: 23.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {


                        // Fetch user profile
                        var userProfile = await GetUserProfileCall.call(userId: FFAppState().userId);

                        // Extract user profile data
                        var userData = userProfile.jsonBody;
                        var address1 = GetUserProfileCall.bAdd(userData);
                        var address2 = GetUserProfileCall.bAdd2(userData);
                        var city = GetUserProfileCall.bCity(userData);
                        var state = GetUserProfileCall.bState(userData);
                        var postcode = GetUserProfileCall.bPostCode(userData);
                        var country = GetUserProfileCall.bCountry(userData);

                        // Create order
                        var orderCreate = await CreateOrderCall.call(
                          firstName: FFAppState().firstName,
                          lastName: FFAppState().lastName,
                          address1: address1,
                          address2: address2,
                          city: city,
                          state: state,
                          postcode: postcode,
                          country: country,
                          phone: FFAppState().telephone,
                          //lineItemsJson: _cartItems,
                          lineItemsJson: items,
                          customerId: FFAppState().userId.toString(),
                        );

                        // Handle order creation result
                        if ((orderCreate.succeeded == true)) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPageWidget(),));
                          context.pushNamed('OrderPage');
                          await _cartService.clearCart();
                          _loadCart();
                        } else {
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

                        // Payment logic can be added here
                      },
                      text: 'Checkout',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 45.0,
                        color: Color(0xFF27AEDF),
                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Open Sans',
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                        elevation: 3.0,
                        borderSide: BorderSide(
                          color: Color(0xFF27AEDF),
                          width: 1.0,
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
      bottomNavigationBar: CustomBottomNavigationWidget(selectedPage: 'catalouge',),
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
