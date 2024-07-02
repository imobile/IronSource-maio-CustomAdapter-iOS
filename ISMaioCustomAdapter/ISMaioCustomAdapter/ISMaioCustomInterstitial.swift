//
//  ISMaioCustomInterstitial.swift
//  ISMaioCustomAdapter
//

import IronSource
import Maio

@objc(ISMaioCustomInterstitial)
class ISMaioCustomInterstitial: ISBaseInterstitial {

    var ad: MaioInterstitial?
    var loadDelegate: ISInterstitialAdDelegate?

    override func loadAd(with adData: ISAdData, delegate: ISInterstitialAdDelegate) {
        guard let zoneId = adData.getString(paramKeyZoneId) else {
            DispatchQueue.main.async {
                delegate.adDidFailToLoadWith(.internal, errorCode: 10601, errorMessage: "Missing parameter: zoneId")
            }
            return
        }

        self.loadDelegate = delegate

        let request = MaioRequest(zoneId: zoneId, testMode: false)
        let ad = MaioInterstitial.loadAd(request: request, callback: nil)
        self.ad = ad;
    }
}
