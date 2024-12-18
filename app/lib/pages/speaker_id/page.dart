import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:friend_private/backend/api_requests/api/server.dart';
import 'package:friend_private/backend/preferences.dart';
import 'package:friend_private/backend/schema/bt_device.dart';
import 'package:friend_private/backend/schema/sample.dart';
import 'package:friend_private/pages/home/page.dart';
import 'package:friend_private/utils/ble/connected.dart';
import 'package:friend_private/utils/ble/scan.dart';

class SpeakerIdPage extends StatefulWidget {
  final bool onbording;

  const SpeakerIdPage({super.key, this.onbording = false});

  @override
  State<SpeakerIdPage> createState() => _SpeakerIdPageState();
}

class _SpeakerIdPageState extends State<SpeakerIdPage>
    with TickerProviderStateMixin {
  TabController? _controller;
  int _currentIdx = 0;
  List<SpeakerIdSample> _samples = [];

  BTDeviceStruct? _device;
  StreamSubscription<OnConnectionStateChangedEvent>? _connectionStateListener;

  _init() async {
    _device = await scanAndConnectDevice();
    _samples = await getUserSamplesState(SharedPreferencesUtil().uid);
    _controller = TabController(length: 2 + _samples.length, vsync: this);
    _initiateConnectionListener();
    setState(() {});
  }

  _initiateConnectionListener() async {
    if (_connectionStateListener != null) return;
    _connectionStateListener = getConnectionStateListener(
        deviceId: _device!.id,
        onDisconnected: () => setState(() => _device = null),
        onConnected: ((d) => setState(() => _device = d)));
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _connectionStateListener?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            automaticallyImplyLeading: true,
            title: const Text(
              'Speech Profile',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            actions: [
              !widget.onbording
                  ? const SizedBox()
                  : TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (c) => const HomePageWrapper()));
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                      ),
                    ),
            ],
            centerTitle: true,
            elevation: 0,
            leading: widget.onbording
                ? const SizedBox()
                : IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      if (_currentIdx > 0 &&
                          _currentIdx < (_controller?.length ?? 0) - 1) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Are you sure?'),
                            content: const Text(
                                'You will lose all the samples you have recorded so far.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                        return;
                      }
                      Navigator.pop(context);
                    },
                  ),
          ),
          body: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Start stream'),
              ),
              TextButton(onPressed: () {}, child: const Text('cancel Stream'))
            ],
          )),
    );
  }
}
