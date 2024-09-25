import 'package:aqaumatic_app/flutter_flow/flutter_flow_icon_button.dart';
import 'package:aqaumatic_app/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

import '../auth/custom_auth/auth_util.dart';
import '../flutter_flow/flutter_flow_theme.dart'; // for WebViewAware

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
  }) : super(key: key);

  final String firstName;
  final String lastName;
  final String contactNumber;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      child: WebViewAware(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(25.0, 40.0, 0.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Main menu',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Open Sans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: capitalizeFirstLetter(firstName),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Open Sans',
                        color: const Color(0xFF43484B),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(
                      text: ' ',
                    ),
                    TextSpan(
                      text: capitalizeFirstLetter(lastName),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Open Sans',
                        color: const Color(0xFF43484B),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35.0),
              _buildDrawerItem(
                context,
                icon: FontAwesomeIcons.home,
                label: 'Home',
                onTap: () => context.pushNamed('CatalougePage'),
              ),
              const SizedBox(height: 15.0),
              _buildDrawerItem(
                context,
                icon: FontAwesomeIcons.newspaper,
                label: 'News',
                onTap: () {
                  if (Navigator.of(context).canPop()) context.pop();
                  context.pushNamed('NewsPage');
                },
              ),
              const SizedBox(height: 15.0),
              _buildDrawerItem(
                context,
                icon: FontAwesomeIcons.cloudDownloadAlt,
                label: 'Downloads',
                onTap: () => context.pushNamed('DownloadPage'),
              ),
              const SizedBox(height: 15.0),
              _buildDrawerItem(
                context,
                icon: FontAwesomeIcons.userCircle,
                label: 'Profile',
                onTap: () => context.pushNamed('ProfilePage'),
              ),
              const SizedBox(height: 15.0),
              _buildDrawerItem(
                context,
                icon: FontAwesomeIcons.phone,
                label: 'Call Aqaumatic',
                onTap: () => _makePhoneCall(contactNumber),
              ),
              const SizedBox(height: 15.0),
              _buildDrawerItem(
                context,
                icon: Icons.login_sharp,
                label: 'Logout',
                onTap: () => _logout(context),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 20.0, bottom: 25.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
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
    );
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  Widget _buildDrawerItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          FlutterFlowIconButton(
            borderRadius: 8.0,
            buttonSize: 40.0,
            fillColor: FlutterFlowTheme.of(context).primaryBackground,
            icon: FaIcon(
              icon,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 24.0,
            ),
            onPressed: onTap,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10.0),
            child: Text(
              label,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Open Sans',
                color: const Color(0xFF43484B),
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final url = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(url);
  }

  void _logout(BuildContext context) async {
    // Show a loading dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissing the loader by tapping outside
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              FlutterFlowTheme.of(context).primaryColor, // Use primary color for the loader
            ),
          ),
        );
      },
    );

    try {
      // Prepare for auth event
      GoRouter.of(context).prepareAuthEvent();

      // Sign out the user
      await authManager.signOut();

      // Clear any redirect locations
      GoRouter.of(context).clearRedirectLocation();

      // Clearing state variables
      FFAppState().userId = 0;
      FFAppState().firstName = '';
      FFAppState().lastName = '';
      FFAppState().telephone = '';
      FFAppState().email = '';

      // Navigate to the login page
      context.goNamedAuth('LoginPage', context.mounted);
    } catch (e) {
      // Handle logout error if necessary
      print('Logout failed: $e');
    } finally {
      // Hide the loading dialog
      Navigator.of(context).pop(); // Close the loader
    }
  }

/*  void _logout(BuildContext context) async {
    GoRouter.of(context).prepareAuthEvent();
    await authManager.signOut();
    GoRouter.of(context).clearRedirectLocation();

    // Clearing state variables
    FFAppState().userId = 0;
    FFAppState().firstName = '';
    FFAppState().lastName = '';
    FFAppState().telephone = '';
    FFAppState().email = '';

    context.goNamedAuth('LoginPage', context.mounted);
  }*/
}
