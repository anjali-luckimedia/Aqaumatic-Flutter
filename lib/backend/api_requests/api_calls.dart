import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;
import 'dart:developer' as dev;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/*class GetCatalougeCall {
  static Future<ApiCallResponse> call({
    String? page = '1',
    int? userId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getCatalouge',
      apiUrl:
          'https://aquamaticwp.elate-ecommerce.com/wp-json/wc/v3/products/categories?per_page=10&user_id=${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {
        'page': page,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}*/
class GetCatalougeCall {
  static Future<ApiCallResponse> call({
    String? page = '1',
    int? userId,


  }) async {
    print(userId);
    ApiCallResponse response = await ApiManager.instance.makeApiCall(
      callName: 'getCatalouge',
      apiUrl:
      'https://aquamaticwp.elate-ecommerce.com/wp-json/wc/v3/products/categories?per_page=10&user_id=${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
        'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {
        'page': page,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    // Print the JSON body of the API response
    debugPrint(response.jsonBody.toString());

    return response;
  }

  static List<int>? id(dynamic response) => (getJsonField(
    response,
    r'''$[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();

  static List<String>? name(dynamic response) => (getJsonField(
    response,
    r'''$[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class GetOrderListCall {
  static Future<ApiCallResponse> call({
    String? page = '1',
    int? userId,
  }) async {

    print(userId);
    return ApiManager.instance.makeApiCall(
      callName: 'getOrderList',
      apiUrl:
          'https://aquamaticwp.elate-ecommerce.com/wp-json/wc/v3/orders?per_page=10&customer=${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {
        //'customer':userId,
        'page': page,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? orderId(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetCatalougeSearchCall {
  static Future<ApiCallResponse> call({
    String? catalougeName = '',
  }) async {
    final response = await ApiManager.instance.makeApiCall(
    //return ApiManager.instance.makeApiCall(
      callName: 'getCatalougeSearch',
      apiUrl:
          'https://aquamaticwp.elate-ecommerce.com/wp-json/wc/v3/products?search=${catalougeName}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    debugPrint(response.jsonBody.toString());
    return response;
  }

}

class LoginCall {
  static Future<ApiCallResponse> call({
    String? password = '',
    String? username = '',
  }) async {
    final ffApiRequestBody = '''{ "username": "${username}","password": "${password}"}''';

    print('BodyType.JSON: ${ffApiRequestBody}');
    print('BodyType.JSON: ${username}');
    print('BodyType.JSON: ${password}');
    /*return ApiManager.instance.makeApiCall(
      callName: 'login',
      apiUrl: 'https://aquamaticwp.elate-ecommerce.com/wp-json/custom/v1/login',
     // apiUrl: 'https://aquamaticwp.elate-ecommerce.com/wp-json/jwt-auth/v1/token',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );*/
    final response = await ApiManager.instance.makeApiCall(
      callName: 'login',
     // apiUrl: 'https://aquamaticwp.elate-ecommerce.com/wp-json/custom/v1/login',
      apiUrl: 'https://aquamaticwp.elate-ecommerce.com/wp-json/jwt-auth/v1/token',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    // Print the entire response
    print('Response: ${response.jsonBody}');

    return response;
  }



  static String? token(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.token''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.email''',
      ));
  static String? firstName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.firstName''',
      ));
  static String? lastName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.lastName''',
      ));
  static String? displayName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.displayName''',
      ));
  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.id''',
      ));
  static String? shareKey(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.wishlist.share_key''',
  ));
  static int? wishlistId(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.wishlist.id''',
  ));

}

class GetProductListByCatalougeCall {
  static Future<ApiCallResponse> call({
    int? categoryId,
    int? page,
    int? userId,
  }) async {
    // Call the API and capture the response
    final response = await ApiManager.instance.makeApiCall(
      callName: 'getProductListByCatalouge',
     // apiUrl: 'https://aquamaticwp.elate-ecommerce.com/wp-json/custom/v1/products?per_page=10&category=${categoryId}&user_id=${userId}',
      apiUrl: 'https://aquamaticwp.elate-ecommerce.com/wp-json/wc/v3/products?per_page=10&category=${categoryId}&user_id=${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
        'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {
        'page': page,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    // Print the entire response to see the structure
   dev.log('API Response: ${response.jsonBody}');

    // Return the response
    return response;
  }

  static List<int>? id(dynamic response) => (getJsonField(
    response,
    r'''$[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();

  static List<String>? fav(dynamic response) => (getJsonField(
    response,
    //r'''$.data[:].is_favourite''',
    r'''$[:].is_favourite''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}


/*class GetProductListByCatalougeCall {
  static Future<ApiCallResponse> call({
    int? categoryId,
    int? page,
    int? userId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getProductListByCatalouge',
      apiUrl: 'https://aquamaticwp.elate-ecommerce.com/wp-json/custom/v1/products?per_page=10&category=${categoryId}&user_id=${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {
        'page': page,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? fav(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_favourite''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}*/

class GetProductDetailsCall {
  static Future<ApiCallResponse> call({
    String? slug = '',
    required int userId,
  }) async {

    print(slug);
    print(userId);

    final response = await ApiManager.instance.makeApiCall(
      callName: 'getProductDetails',
      apiUrl:
     'https://aquamaticwp.elate-ecommerce.com/wp-json/custom/v1/product-detail?slug=${slug}&user_id=${userId}',
      //'https://aquamaticwp.elate-ecommerce.com/wp-json/wc/v3/products?slug=${slug}&user_id=${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
        'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    // Print the response for debugging
    //dev.log('response ${response.jsonBody}');

    return response;

  }

  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.id''',
      ));
  static String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.name''',
      ));
  static String? slug(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.slug''',
      ));
  static String? sku(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.sku''',
      ));
  static String? price(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.price''',
      ));
  static String? image(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.images[:].src''',
      ));
  static List? relatedProduct(dynamic response) => getJsonField(
        response,
        r'''$.data.related_products''',
        true,
      ) as List?;
  static bool? favourite(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.is_favourite''',
      ));
  static int? itemid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.item_id''',
      ));
}

class GetCartCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'getCart',
      apiUrl: 'https://aquamaticwp.elate-ecommerce.com/wp-json/cocart/v2/cart',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.items[:].id''',
      ));
  static String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.items[:].name''',
      ));
  static String? price(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.items[:].price''',
      ));
  static String? sku(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.items[:].meta.sku''',
      ));
  static String? image(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.items[:].featured_image''',
      ));
  static List? items(dynamic response) => getJsonField(
        response,
        r'''$.items''',
        true,
      ) as List?;
  static int? quantity(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.items[:].quantity.value''',
      ));
  static String? company(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.billing_address.billing_company''',
      ));
  static String? country(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.billing_address.billing_country''',
      ));
  static String? address1(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.billing_address.billing_address_1''',
      ));
  static String? address2(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.billing_address.billing_address_2''',
      ));
  static String? city(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.billing_address.billing_city''',
      ));
  static String? state(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.billing_address.billing_state''',
      ));
  static String? postcode(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.billing_address.billing_postcode''',
      ));
  static String? phone(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.billing_address.billing_phone''',
      ));
  static dynamic? rates(dynamic response) => getJsonField(
        response,
        r'''$.shipping.packages.default.rates''',
      );
  static String? biillingemail(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.customer.billing_address.billing_email''',
      ));
  static String? sFIrstName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.customer.shipping_address.shipping_first_name''',
      ));
  static String? sLastName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.shipping_address.shipping_last_name''',
      ));
  static String? sCompnay(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.shipping_address.shipping_company''',
      ));
  static String? sCountry(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.shipping_address.shipping_country''',
      ));
  static String? sAddess1(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.shipping_address.shipping_address_1''',
      ));
  static String? sAddess2(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.shipping_address.shipping_address_2''',
      ));
  static String? sCity(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.shipping_address.shipping_city''',
      ));
  static String? sState(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.shipping_address.shipping_state''',
      ));
  static String? sPostcode(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer.shipping_address.shipping_postcode''',
      ));
  static int? cartCount(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.item_count''',
      ));
}

class AddToCartCall {
  static Future<ApiCallResponse> call({
    int? id,
    int? quantity,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'addToCart',
      apiUrl:
          'https://aquamaticwp.elate-ecommerce.com/wp-json/cocart/v2/cart/add-item',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {
        'id': id,
        'quantity': quantity,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? items(dynamic response) => getJsonField(
        response,
        r'''$.items''',
        true,
      ) as List?;
}

class CartClearCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'cartClear',
      apiUrl:
          'https://aquamaticwp.elate-ecommerce.com/wp-json/cocart/v2/cart/clear',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {},
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddProductToWishlistCall {
  static Future<ApiCallResponse> call({
    int? productId,
    required String shareKey,
  }) async {
    final ffApiRequestBody = '''
{
  "product_id": ${productId},
  "variation_id": 0,
  "meta": {
    "test": "text"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addProductToWishlist',
      apiUrl: 'https://aquamaticwp.elate-ecommerce.com/wp-json/wc/v3/wishlist/$shareKey/add_product',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? products(dynamic response) => getJsonField(
        response,
        r'''$.items''',
        true,
      ) as List?;
}

class UpdateInCartCall {
  static Future<ApiCallResponse> call({
    String? itemkey = '',
    String? quantity = '',
  }) async {
    final ffApiRequestBody = '''
{
  "quantity": "${quantity}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateInCart',
      apiUrl:
          'https://aquamaticwp.elate-ecommerce.com/wp-json/cocart/v2/cart/item/${itemkey}',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetNewsCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'getNews',
      apiUrl: 'https://aquamaticwp.elate-ecommerce.com/wp-json/wp/v2/posts',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetNewsDetailsCall {
  static Future<ApiCallResponse> call({
    String? slug = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getNewsDetails',
      apiUrl:
          'https://aquamaticwp.elate-ecommerce.com/wp-json/wp/v2/posts?slug=${slug}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].id''',
      ));
  static String? date(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].date''',
      ));
  static String? slug(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].slug''',
      ));
  static String? title(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].title.rendered''',
      ));
  static String? content(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].content.rendered''',
      ));
}

class GetOrderDetailsCall {
  static Future<ApiCallResponse> call({
    int? orderId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getOrderDetails',
      apiUrl:
          'https://aquamaticwp.elate-ecommerce.com/wp-json/wc/v3/orders/${orderId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  static String? status(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.status''',
      ));
  static String? currency(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.currency''',
      ));
  static String? createDate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.date_created''',
      ));
  static String? total(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.total''',
      ));
  static String? updatedDate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.date_modified''',
      ));
  static String? firstName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.shipping.first_name''',
      ));
  static String? lastName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.shipping.last_name''',
      ));
  static String? number(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.number''',
      ));
  static String? phoneNumber(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.shipping.phone''',
      ));
  static List? lineItems(dynamic response) => getJsonField(
        response,
        r'''$.line_items''',
        true,
      ) as List?;
}

class GetUserProfileCall {
  static Future<ApiCallResponse> call({
    int? userId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getUserProfile',
      apiUrl:
          'https://aquamaticwp.elate-ecommerce.com/wp-json/wc/v3/customers/${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic billing(dynamic response) => getJsonField(
        response,
        r'''$.billing''',
      );

  static int? id(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.id''',
  ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.email''',
  ));
  static String? fName(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.first_name''',
  ));
  static String? lName(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.last_name''',
  ));
  static String? role(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.role''',
  ));
  static String? userName(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.username''',
  ));
  static String? bFName(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.first_name''',
  ));
  static String? bLName(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.last_name''',
  ));
  static String? bPostCode(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.postcode''',
  ));
  static String? bEmail(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.email''',
  ));
  static String? bPhone(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.phone''',
  ));
  static String? bAdd(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.address_1''',
  ));
  static String? bAdd2(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.address_2''',
  ));
  static String? bCity(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.city''',
  ));
  static String? bCountry(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.country''',
  ));
  static String? bState(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.state''',
  ));

}

class DeleteItemInCartCall {
  static Future<ApiCallResponse> call({
    String? itemkey = '',
    int? quantity,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'deleteItemInCart',
      apiUrl:
          'https://aquamaticwp.elate-ecommerce.com/wp-json/cocart/v2/cart/item/${itemkey}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {
        'quantity': quantity,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateOrderCall {
  static Future<ApiCallResponse> call({
    String? firstName = '',
    String? lastName = '',
    String? address1 = '',
    String? address2 = '',
    String? city = '',
    String? state = '',
    String? postcode = '',
    String? country = '',
    String? phone = '',
    dynamic? lineItemsJson,
    String? customerId = '',
  }) async {
    final lineItems = _serializeJson(lineItemsJson);
    final ffApiRequestBody = '''
{
  "payment_method": "bacs",
  "payment_method_title": "Direct Bank Transfer",
  "set_paid": true,
  "customer_id": "${customerId}",
  "billing": {
    "first_name": "${firstName}",
    "last_name": "${lastName}",
    "address_1": "${address1}",
    "address_2": "${address2}",
    "city": "${city}",
    "state": "${state}",
    "postcode": "${postcode}",
    "country": "${country}",
    "phone": "${phone}"
  },
  "shipping": {
    "first_name": "${firstName}",
    "last_name": "${lastName}",
    "address_1": "${address1}",
    "address_2": "${address2}",
    "city": "${city}",
    "state": "${state}",
    "postcode": "${postcode}",
    "country": "${country}"
  },
  "line_items": ${lineItems},
  "shipping_lines": [
    {
      "method_id": "flat_rate",
      "method_title": "Flat Rate",
      "total": "10.00"
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createrOrder',
      apiUrl: 'https://aquamaticwp.elate-ecommerce.com/wp-json/wc/v3/orders',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateWishlistCall {
  static Future<ApiCallResponse> call({
    String? title = '',
    int? userId,
  }) async {
    final ffApiRequestBody = '''
{
  "title": "${title} Wishlist",
  "user_id": ${userId},
  "staus": "shared"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createWishlist',
      apiUrl:
          'https://aquamaticwp.elate-ecommerce.com/wp-json/wc/v3/wishlist/create',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? shareKey(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.share_key''',
      ));
  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
}

class RemoveProductWishlistCall {
  static Future<ApiCallResponse> call({
    int? itemId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'removeProductWishlist',
      apiUrl:
          'https://aquamaticwp.elate-ecommerce.com/wp-json/wc/v3/wishlist/remove_product/${itemId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetDownloadDataListCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'getDownloadDataList',
      apiUrl:
          'https://aquamaticwp.elate-ecommerce.com/wp-json/custom/v1/downloads',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetNewWishlistDataCall {
  static Future<ApiCallResponse> call({

    int? userId,
  }) async {
    print(userId);
    return ApiManager.instance.makeApiCall(
      callName: 'getNewWishlistData',
      apiUrl: 'https://aquamaticwp.elate-ecommerce.com/wp-json/custom/v1/wishlist-products?user_id=${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? dataList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class ChangePasswordCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? password = '',
    String? newPassword = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'changePassword',
      apiUrl:
          'https://aquamaticwp.elate-ecommerce.com/wp-json/custom/v1/change-password',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Basic Y2tfZTZjMTYxYzRiMjEzZjM1YTRhZjVhNWRlMzkxZjcyNTUwYjA2ZmZhZjpjc18zNmRjMTllYzA3YjU5ODc2N2IzNjgzM2FkOGUyYTJkNDY5ZGVhMTlm',
      },
      params: {
        'user_id': userId,
        'password': password,
        'new_password': newPassword,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
