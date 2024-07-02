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
        let ad = MaioInterstitial.loadAd(request: request, callback: self)
        self.ad = ad;
    }
}

extension ISMaioCustomInterstitial: MaioInterstitialLoadCallback {
    func didLoad(_ ad: MaioInterstitial) {
        self.loadDelegate?.adDidLoad()
    }

    func didFail(_ ad: MaioInterstitial, errorCode: Int) {
        if 10000..<20000 ~= errorCode {

            let errorMessage = ISMaioCustomAdapter.errorMessage(from: errorCode)

            if 10700..<10800 ~= errorCode {
                self.loadDelegate?.adDidFailToLoadWith(.noFill, errorCode: errorCode, errorMessage: errorMessage)
            } else {
                self.loadDelegate?.adDidFailToLoadWith(.internal, errorCode: errorCode, errorMessage: errorMessage)
            }
        }
    }
}
