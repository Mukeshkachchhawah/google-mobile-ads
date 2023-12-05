import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  /// ads show mobile ads
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Mobile Ads',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const GoogleMobileAds(),
      home: FullScreensAds(),

      // home: NativeAds(),
    );
  }
}

class GoogleMobileAds extends StatefulWidget {
  const GoogleMobileAds({super.key});

  @override
  State<GoogleMobileAds> createState() => _GoogleMobileAdsState();
}

class _GoogleMobileAdsState extends State<GoogleMobileAds> {
  BannerAd? _bannerads;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BannerAds();
  }

  void BannerAds() {
    _bannerads = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        listener: BannerAdListener(
          onAdFailedToLoad: (ad, error) {
            print("ads loding failed!! ${error.message}");
          },
          onAdLoaded: (ad) {
            print("ads lading success!! ");
          },
        ),
        request: AdRequest())
      ..load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GoogleMobileAds"),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: _bannerads != null
                  ? SizedBox(
                      height: _bannerads!.size.height.toDouble(),
                      width: _bannerads!.size.width.toDouble(),
                      child: AdWidget(ad: _bannerads!))
                  : Container(),
            )
          ],
        ));
  }
}

class FullScreensAds extends StatefulWidget {
  const FullScreensAds({super.key});

  @override
  State<FullScreensAds> createState() => _FullScreensAdsState();
}

class _FullScreensAdsState extends State<FullScreensAds> {
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadAds();
  }

  void LoadAds() {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            print("Ads Load");
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (error) {
            print("ads loding failed!! ${error.message}");
          },
        ));
  }

  void showInterstititalAds() {
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) => print("Show Ads Full Screens"),
      onAdDismissedFullScreenContent: (ad) {
        print("$ad onDismissedFullScreens");
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print("$ad onFailedShowFull Screens Ads :- ${error.message}");
        ad.dispose();
      },
    );
    _interstitialAd!.show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Ads"),
      ),
      body: Column(
        children: [
          Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(color: Colors.red),
              child: ElevatedButton(
                  onPressed: () {
                    showInterstititalAds();
                  },
                  child: Text("Tap"))),
        ],
      ),
    );
  }
}

/* class NativeAds extends StatefulWidget {
  const NativeAds({super.key});

  @override
  State<NativeAds> createState() => _NativeAdsState();
}

class _NativeAdsState extends State<NativeAds> {
  NativeAd? nativeAd;

  void AddNativeAds() {
    nativeAd = NativeAd(
        adUnitId: "ca-app-pub-3940256099942544/2247696110",
        listener: NativeAdListener(onAdLoaded: (ad) {
          print("$ad Ad Load");

          nativeAd = ad;
        }),
        request: AdRequest());
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Text("Notive Ads"));
  }
}
 */