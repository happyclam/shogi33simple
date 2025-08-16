/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

var isAppForeground = true;
var backCounter = 0;
var admobid = {};
if( /(android)/i.test(navigator.userAgent) ) {
    admobid = { // for Android
        banner : "ca-app-pub-9018029357773039/1929128183",
        interstitial : "ca-app-pub-9018029357773039/7848835826"
	};
} else if(/(ipod|iphone|ipad)/i.test(navigator.userAgent)) {
	admobid = { // for iOS
        banner : "ca-app-pub-9018029357773039/1929128183",
        interstitial : "ca-app-pub-9018029357773039/7848835826"
	};
} else {
	admobid = { // for Windows Phone
        banner : "ca-app-pub-9018029357773039/1929128183",
        interstitial : "ca-app-pub-9018029357773039/7848835826"
	};
}
var app = {
    // Application Constructor
    initialize: function() {
        this.bindEvents();
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
        document.addEventListener('backbutton', this.onBackButton, false);
        document.addEventListener('admob.interstitial.events.LOAD', this.onAdLoaded, false);
        document.addEventListener('admob.interstitial.events.LOAD_FAIL', this.onAdFailed, false);
        document.addEventListener('admob.interstitial.events.CLOSE', this.onAdClosed, false);
        // document.addEventListener("offline", this.onOffline, false);
        // document.addEventListener("online", this.onOnline, false);
//        document.addEventListener('bannerreceive', this.onBannerReceive, false);
        // document.addEventListener(admob.events.onAdLoaded, onAdLoaded);
        // document.addEventListener(admob.events.onAdOpened, function (e) {});
        // document.addEventListener(admob.events.onAdClosed, function (e) {});
        // document.addEventListener(admob.events.onAdLeftApplication, function (e) {});
        // document.addEventListener(admob.events.onInAppPurchaseRequested, function (e) {});
        // document.addEventListener(admob.events.onAdFailedToLoad, function (e) {});
    },
    // onOnline: function() {
    //     var networkState = navigator.connection.type;
    //     if (networkState !== Connection.NONE) {
    //         console.log("get connection");
    //     }
    // },
    // onOffline: function() {
    //     console.log("lost connection");
    // },
    onAdLoaded: function() {
        console.log("=== onAdLoaded ============================")
        admob.interstitial.show();
    },
    onAdFailed: function() {
        console.log("=== onAdFailed ============================")
    },
    onAdClosed: function() {
        console.log("=== onAdClosed ============================")
    },
    onConfirm: function(idx) {
        if (idx == 2) {
            navigator.app.exitApp();
        } else {
            backCounter = 0;
        }
    },
    // onAdLoaded: function() {
    //     if (e.adType === window.plugins.AdMob.AD_TYPE.INTERSTITIAL) {
    //         window.plugins.AdMob.showInterstitialAd();
    //         showNextInterstitial = setTimeout(function() {
    //             window.plugins.AdMob.requestInterstitialAd();
    //         }, 2 * 60 * 1000); // 2 minutes
    //     }
    // },
    onBackButton: function() {
        backCounter += 1;
        navigator.notification.confirm(i18next.t('dlg2_exit'), app.onConfirm, i18next.t('dlg2_exitTitle'), [i18next.t('dlg2_exitItemNo'), i18next.t('dlg2_exitItemYes')]);

    },
    onDeviceReady: function() {
////        document.removeEventListener('deviceready', onDeviceReady, false);
        FastClick.attach(document.body);
        app.receivedEvent();
        // if ( window.plugins && window.plugins.AdMob ) {
        //     app.receivedEvent();
        // } else {
		//     alert( 'AdMob plugin not ready' ); return;
        // }
        var lng = '';
        navigator.globalization.getLocaleName(
            function (locale) {
                // console.log("=== " + locale.value);
                if (!locale.value) {
                    lng = 'en';
                } else {
                    lng = locale.value;
                }
                // console.log("=== " + lng);
                app.setLanguage(lng.slice(0,2));
            },
            function () {
                app.setLanguage('en');
            }
        );
        window.FirebasePlugin.hasPermission(function(data){
            console.log('hasPermission : '+data.isEnabled);
        });
        window.FirebasePlugin.getToken(function(token) {
            // console.log('token : '+token);
            localStorage.setItem("FCMtoken",token);
        }, function(error) {
            console.log('token : '+error);
        });
        window.FirebasePlugin.onTokenRefresh(function(token) {
            // console.log('tokenRefresh : '+token);
            localStorage.setItem("FCMtoken",token);            
        }, function(error) {
            console.log('tokenRefresh : '+error);
        });
        window.FirebasePlugin.onMessageReceived(function(data) {
            if (data.wasTapped) {
                // Notification was received on device tray and tapped by the user.
                localStorage.setItem("serverMsg33",JSON.stringify(data));
            } else {
                // Notification was received in foreground. Maybe the user needs to be notified.
                localStorage.setItem("serverMsg33",JSON.stringify(data));
                window.plugins.toast.showWithOptions({
                    message: data[lng.slice(0,2)],
                    duration: '15000',
                    position: 'center',
                    styling: {
                        opacity: 0.75,
                        backgroundColor: '#E6E6E6',
                        textColor: '#000000',
                        textSize: 40,
                        cornerRadius: 16
                    }
                });
            }
        }, function(msg) {
            console.log(msg);
        }, function(err) {
            console.log(err);
        });
        // window.FirebasePlugin.grantPermission();
    },
    setLanguage: function(lng) {
        localStorage.setItem("appLanguage", lng);
    },
    receivedEvent: function() {
        // var bOverLap = false;
        window.myVersionString = device.version;
        // if (device.version.search('4.1.') === 0) {
        //     bOverLap = true;
        // }
        // window.plugins.AdMob.setOptions({
        //     publisherId:      admobid.banner,
        //     interstitialAdId: admobid.interstitial,
        //     // tappxIdiOs:       "",
        //     // tappxIdAndroid:   "",
        //     // tappxShare:       "",
        //     adSize:           window.plugins.AdMob.AD_SIZE.SMART_BANNER,
        //     bannerAtTop:      false,
        //     overlap:          bOverLap,
        //     offsetStatusBar:  false,
        //     isTesting:        false,
        //     autoShow:         true
        //     // adExtras :        {},
        //     // autoShowBanner:   true,
        //     // autoShowInterstitial: true
        // });
        // window.plugins.AdMob.createBannerView();
        // window.plugins.AdMob.createInterstitialView();
        // window.plugins.AdMob.requestInterstitialAd();
        admob.banner.config({
            id: admobid.banner,
            isTesting: false,
            autoShow: true,
        });
        admob.banner.prepare();
        admob.interstitial.config({
            id: admobid.interstitial,
            isTesting: false,
            autoShow: false,
        });
        // admob.interstitial.prepare();
    }
};

app.initialize();
