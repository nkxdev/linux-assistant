import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/after_installation/office_selection.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/layouts/system_icon.dart';
import 'package:linux_assistant/services/after_installation_service.dart';
import 'package:linux_assistant/services/icon_loader.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';

class AfterInstallationBrowserSelection extends StatelessWidget {
  AfterInstallationBrowserSelection({super.key});

  static Future<bool> firefoxInstalled =
      Linux.areApplicationsInstalled(["firefox"]);
  static Future<bool> chromiumInstalled =
      Linux.areApplicationsInstalled(["chromium"]);
  static Future<bool> googleChromeStableInstalled =
      Linux.areApplicationsInstalled(
          ["google-chrome-stable", "com.google.Chrome"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MintYPage(
        title: "Browser Selection",
        contentElements: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: firefoxInstalled,
                builder: (context, snapshot) {
                  AfterInstallationService.firefox =
                      snapshot.data.toString() == 'true';
                  if (snapshot.hasData) {
                    return MintYSelectableCardWithIcon(
                      icon: const SystemIcon(
                          iconString: "firefox", iconSize: 150),
                      title: "Firefox",
                      text:
                          "Open Source browser with focus on privacy by Mozilla.",
                      selected: snapshot.data.toString() == 'true',
                      onPressed: () {
                        AfterInstallationService.firefox =
                            !AfterInstallationService.firefox;
                      },
                    );
                  } else {
                    return const MintYProgressIndicatorCircle();
                  }
                },
              ),
              SizedBox(
                width: 10,
              ),
              FutureBuilder(
                future: chromiumInstalled,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    AfterInstallationService.chromium =
                        snapshot.data.toString() == 'true';
                    return MintYSelectableCardWithIcon(
                      icon: const SystemIcon(
                          iconString: "chromium", iconSize: 150),
                      title: "Chromium",
                      text: "Open Source browser. Free base of Google Chrome.",
                      selected: snapshot.data.toString() == 'true',
                      onPressed: () {
                        AfterInstallationService.chromium =
                            !AfterInstallationService.chromium;
                      },
                    );
                  } else {
                    return const MintYProgressIndicatorCircle();
                  }
                },
              ),
              SizedBox(
                width: 10,
              ),
              FutureBuilder(
                future: googleChromeStableInstalled,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    AfterInstallationService.googleChrome =
                        snapshot.data.toString() == 'true';
                    return MintYSelectableCardWithIcon(
                      icon: const SystemIcon(
                          iconString: "google-chrome", iconSize: 150),
                      title: "Google Chrome",
                      text: "Proprietary browser from Google.",
                      selected: snapshot.data.toString() == 'true',
                      onPressed: () {
                        AfterInstallationService.googleChrome =
                            !AfterInstallationService.googleChrome;
                      },
                    );
                  } else {
                    return const MintYProgressIndicatorCircle();
                  }
                },
              ),
            ],
          ),
        ],
        bottom: MintYButtonNext(
          route: const AfterInstallationOfficeSelection(),
          onPressed: () {
            AfterInstallationService.applyCurrentBrowserSituation();
          },
        ),
      ),
    );
  }
}
