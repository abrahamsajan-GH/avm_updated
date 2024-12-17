// import 'package:flutter/material.dart';
// import 'package:friend_private/backend/mixpanel.dart';
// import 'package:friend_private/backend/preferences.dart';
// import 'package:friend_private/features/capture/logic/websocket_mixin.dart';
// import 'package:friend_private/pages/home/custom_scaffold.dart';
// import 'package:friend_private/pages/settings/widgets.dart';
// import 'package:friend_private/widgets/dialog.dart';
// import 'package:package_info_plus/package_info_plus.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> with WebSocketMixin {
//   late String _selectedLanguage;
//   late bool optInAnalytics;
//   late bool devModeEnabled;
//   late bool backupsEnabled;
//   late bool postMemoryNotificationIsChecked;
//   late bool reconnectNotificationIsChecked;
//   String? version;
//   String? buildVersion;
//   final bool _customTileExpanded = false;

//   @override
//   void initState() {
//     _selectedLanguage = SharedPreferencesUtil().recordingsLanguage;
//     optInAnalytics = SharedPreferencesUtil().optInAnalytics;
//     devModeEnabled = SharedPreferencesUtil().devModeEnabled;
//     postMemoryNotificationIsChecked =
//         SharedPreferencesUtil().postMemoryNotificationIsChecked;
//     reconnectNotificationIsChecked =
//         SharedPreferencesUtil().reconnectNotificationIsChecked;
//     backupsEnabled = SharedPreferencesUtil().backupsEnabled;
//     PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
//       version = packageInfo.version;
//       buildVersion = packageInfo.buildNumber.toString();
//       setState(() {});
//     });
//     super.initState();
//   }

//   bool loadingExportMemories = false;

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: true,
//       child: CustomScaffold(
//         //  backgroundColor: Theme.of(context).colorScheme.primary,
//         // appBar: AppBar(
//         //   backgroundColor: Theme.of(context).colorScheme.surface,
//         //   automaticallyImplyLeading: true,
//         //   title: const Text('Settings'),
//         //   centerTitle: false,
//         //   // leading: IconButton(
//         //   //   icon: const Icon(Icons.arrow_back_ios_new),
//         //   //   onPressed: () {
//         //   //     Navigator.pop(context);
//         //   //   },
//         //   // ),
//         //   elevation: 0,
//         // ),
//         body: Padding(
//           padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//               left: 8,
//               right: 8),
//           child: Column(
//             children: [
//               const SizedBox(height: 32.0),
//               ...getRecordingSettings((String? newValue) {
//                 if (newValue == null) return;
//                 if (newValue == _selectedLanguage) return;
//                 if (newValue != 'en') {
//                   showDialog(
//                     context: context,
//                     barrierDismissible: false,
//                     builder: (c) => getDialog(
//                       context,
//                       () => Navigator.of(context).pop(),
//                       () => {},
//                       'Language Limitations',
//                       'Speech profiles are only available for English language. We are working on adding support for other languages.',
//                       singleButton: true,
//                     ),
//                   );
//                 }
//                 setState(() => _selectedLanguage = newValue);
//                 SharedPreferencesUtil().recordingsLanguage = _selectedLanguage;
//                 MixpanelManager().recordingLanguageChanged(_selectedLanguage);
//               }, _selectedLanguage),
//               // do not works like this, fix if reusing
//               // ...getNotificationsWidgets(setState, postMemoryNotificationIsChecked, reconnectNotificationIsChecked),
//               //! Disabled As of now
//               /*
//                 ...getPreferencesWidgets(
//                   onOptInAnalytics: () {
//                     setState(() {
//                       optInAnalytics = !SharedPreferencesUtil().optInAnalytics;
//                       SharedPreferencesUtil().optInAnalytics =
//                           !SharedPreferencesUtil().optInAnalytics;
//                       optInAnalytics
//                           ? MixpanelManager().optInTracking()
//                           : MixpanelManager().optOutTracking();
//                     });
//                   },
//                   viewPrivacyDetails: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (c) => const PrivacyInfoPage()));
//                     MixpanelManager().privacyDetailsPageOpened();
//                   },
//                   optInAnalytics: optInAnalytics,
//                   devModeEnabled: devModeEnabled,
//                   onDevModeClicked: () {
//                     setState(() {
//                       if (devModeEnabled) {
//                         devModeEnabled = false;
//                         SharedPreferencesUtil().devModeEnabled = false;
//                         MixpanelManager().developerModeDisabled();
//                       } else {
//                         devModeEnabled = true;
//                         MixpanelManager().developerModeEnabled();
//                         SharedPreferencesUtil().devModeEnabled = true;
//                       }
//                     });
//                   },
//                   backupsEnabled: backupsEnabled,
//                   onBackupsClicked: () {
//                     setState(() {
//                       if (backupsEnabled) {
//                         showDialog(
//                           context: context,
//                           builder: (c) => getDialog(
//                             context,
//                             () => Navigator.of(context).pop(),
//                             () {
//                               backupsEnabled = false;
//                               SharedPreferencesUtil().backupsEnabled = false;
//                               MixpanelManager().backupsDisabled();
//                               deleteBackupApi();
//                               Navigator.of(context).pop();
//                               setState(() {});
//                             },
//                             'Disable Automatic Backups',
//                             'You will be responsible for backing up your own data. We will not be able to restore it automatically once you disable this feature. Are you sure?',
//                           ),
//                         );
//                       } else {
//                         SharedPreferencesUtil().backupsEnabled = true;
//                         setState(() => backupsEnabled = true);
//                         MixpanelManager().backupsEnabled();
//                         executeBackupWithUid();
//                       }
//                     });
//                   },
//                 ),
                
//                 const SizedBox(height: 16),
//                 ListTile(
//                   title: const Text('Need help?',
//                       style: TextStyle(color: Colors.white)),
//                   subtitle: const Text('team@basedhardware.com'),
//                   contentPadding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//                   trailing: const Icon(Icons.arrow_forward_ios,
//                       color: Colors.white, size: 16),
//                   onTap: () {
//                     launchUrl(Uri.parse('mailto:team@basedhardware.com'));
//                     MixpanelManager().supportContacted();
//                   },
//                 ),
//                 ListTile(
//                   contentPadding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//                   title: const Text('Join the community!',
//                       style: TextStyle(color: Colors.white)),
//                   subtitle: const Text('2300+ members and counting.'),
//                   trailing:
//                       const Icon(Icons.discord, color: Colors.purple, size: 20),
//                   onTap: () {
//                     launchUrl(Uri.parse('https://discord.gg/ZutWMTJnwA'));
//                     MixpanelManager().joinDiscordClicked();
//                   },
//                 ),
//                 const SizedBox(height: 32.0),
//                 */
//               // const Align(
//               //   alignment: Alignment.centerLeft,
//               //   child: Text(
//               //     'ADD ONS',
//               //     style: TextStyle(
//               //       color: Colors.white,
//               //     ),
//               //     textAlign: TextAlign.start,
//               //   ),
//               // ),
//               // getItemAddOn('Plugins', () {
//               //   MixpanelManager().pluginsOpened();
//               //   routeToPage(context, const PluginsPage());
//               // }, icon: Icons.integration_instructions),
//               // SharedPreferencesUtil().useTranscriptServer
//               //     ? getItemAddOn('Speech Profile', () {
//               //         routeToPage(context, const SpeakerIdPage());
//               //       }, icon: Icons.multitrack_audio)
//               //     : Container(),
//               // ItemAddOn('Profile', () {
//               //   routeToPage(context, const ProfilePage());
//               // }, icon: Icons.person),
//               // ItemAddon('Calendar Integration', () {
//               //   routeToPage(context, const CalendarPage());
//               // }, icon: Icons.calendar_month),
//               // ItemAddon('Developers Option', () {
//               //   routeToPage(context, const DeveloperPage());
//               // }, icon: Icons.settings_suggest),
//               // const SizedBox(height: 16),
//               // const BackupButton(),
//               // const SizedBox(height: 16), // Backup button added here
//               // const RestoreButton(), // Backup button added here

//               // const SizedBox(height: 16),
//               // const SizedBox(height: 12),
//               // CustomExpansionTile(
//               //   title: 'Transcript Scervice',
//               //   subtitle: SharedPreferencesUtil().getApiType('NewApiKey') ?? '',
//               //   children: [
//               //     ListTile(
//               //       title: const Text('Deepgram'),
//               //       onTap: () {
//               //         developerModeSelected(modeSelected: 'Deepgram');
//               //       },
//               //     ),
//               //     ListTile(
//               //       title: const Text('Sarvam'),
//               //       onTap: () {
//               //         developerModeSelected(modeSelected: 'Sarvam');
//               //       },
//               //     ),
//               //     Visibility(
//               //       visible: false,
//               //       child: ListTile(
//               //         title: const Text('Wisper'),
//               //         onTap: () {
//               //           developerModeSelected(modeSelected: 'Wisper');
//               //         },
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               // const SizedBox(height: 12),
//               // CustomExpansionTile(
//               //   title: 'Prompt',
//               //   children: [
//               //     ListTile(
//               //       title: const Text('Default'),
//               //       onTap: () {},
//               //     ),
//               //     ListTile(
//               //       title: const Text('Customize Prompt'),
//               //       onTap: () {
//               //         Navigator.of(context).push(
//               //           MaterialPageRoute(
//               //             builder: (context) => const CustomPromptPage(),
//               //           ),
//               //         );
//               //       },
//               //     ),
//               //   ],
//               // ),

//               // getItemAddOn('Speech Recognition', () {
//               //   routeToPage(context, const SpeakerIdPage());
//               // }, icon: Icons.multitrack_audio),
//               // getItemAddOn('Developer Mode', () async {
//               //   MixpanelManager().devModePageOpened();
//               //   await routeToPage(context, const DeveloperSettingsPage());
//               //   setState(() {});
//               // }, icon: Icons.code, visibility: devModeEnabled),

//               // const SizedBox(height: 32),
//               const Spacer(),
//               // Padding(
//               //   padding: const EdgeInsets.all(8),
//               //   child: Text(
//               //     SharedPreferencesUtil().uid,
//               //     style: const TextStyle(
//               //         color: Color.fromARGB(255, 150, 150, 150), fontSize: 16),
//               //     maxLines: 1,
//               //     textAlign: TextAlign.center,
//               //   ),
//               // ),

//               // Padding(
//               //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               //   child: Align(
//               //     alignment: Alignment.center,
//               //     child: Text(
//               //       'Version: $version+$buildVersion',
//               //       style: const TextStyle(
//               //           color: Color.fromARGB(255, 150, 150, 150),
//               //           fontSize: 16),
//               //     ),
//               //   ),
//               // ),
//               const SizedBox(height: 80),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // void developerModeSelected({required String modeSelected}) {
//   //   print('Mode Selected $modeSelected');
//   //   // setDiffApi(newApiType: modeSelected);
//   //   SharedPreferencesUtil().saveApiType('NewApiKey', modeSelected);
//   //   const AlertDialog(
//   //     content: Text('To Reflect selected Changes\nApp Restarting...'),
//   //   );
//   //   Future.delayed(const Duration(seconds: 3));
//   //   if (Platform.isAndroid) Restart.restartApp();

//   //   Restart.restartApp(
//   //     notificationTitle: 'Restarting App',
//   //     notificationBody: 'Please tap here to open the app again.',
//   //   );
//   // }
// }
