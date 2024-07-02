//
//  ISMaioCustomRewardedVideo.swift
//  ISMaioCustomAdapter
//

import IronSource
import Maio

@objc(ISMaioCustomRewardedVideo)
class ISMaioCustomRewardedVideo: ISBaseRewardedVideo {

    var isReady = false

    var ad: MaioRewarded?
    var loadDelegate: ISRewardedVideoAdDelegate?

    override func loadAd(with adData: ISAdData, delegate: ISRewardedVideoAdDelegate) {
        guard let zoneId = adData.getString(paramKeyZoneId) else {
            DispatchQueue.main.async {
                delegate.adDidFailToLoadWith(.internal, errorCode: 10601, errorMessage: "Missing parameter: zoneId")
            }
            return
        }

        self.loadDelegate = delegate

        let request = MaioRequest(zoneId: zoneId, testMode: false)
        let ad = MaioRewarded.loadAd(request: request, callback: self)
        self.ad = ad;
    }

    override func isAdAvailable(with adData: ISAdData!) -> Bool {
        return isReady
    }
}

extension ISMaioCustomRewardedVideo: MaioRewardedLoadCallback, MaioRewardedShowCallback {
    func didLoad(_ ad: MaioRewarded) {
        isReady = true
        self.loadDelegate?.adDidLoad()
    }

    func didFail(_ ad: MaioRewarded, errorCode: Int) {
        let errorMessage = ISMaioCustomAdapter.errorMessage(from: errorCode)

        if 10000..<20000 ~= errorCode {
            if 10700..<10800 ~= errorCode {
                self.loadDelegate?.adDidFailToLoadWith(.noFill, errorCode: errorCode, errorMessage: errorMessage)
            } else {
                self.loadDelegate?.adDidFailToLoadWith(.internal, errorCode: errorCode, errorMessage: errorMessage)
            }

        }

        // fallback
        if !isReady {
            self.loadDelegate?.adDidFailToLoadWith(.internal, errorCode: errorCode, errorMessage: errorMessage)
        }
    }
}
