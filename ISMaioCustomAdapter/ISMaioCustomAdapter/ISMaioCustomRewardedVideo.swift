//
//  ISMaioCustomRewardedVideo.swift
//  ISMaioCustomAdapter
//

import IronSource
import Maio

@objc(ISMaioCustomRewardedVideo)
public class ISMaioCustomRewardedVideo: ISBaseRewardedVideo {

    var isReady = false

    var ad: MaioRewarded?
    var loadDelegate: ISRewardedVideoAdDelegate?
    var showDelegate: ISRewardedVideoAdDelegate?

    public override func loadAd(with adData: ISAdData, delegate: ISRewardedVideoAdDelegate) {
        guard let zoneId = adData.getString(paramKeyZoneId) else {
            DispatchQueue.main.async {
                delegate.adDidFailToLoadWith(.internal, errorCode: 10601, errorMessage: "Missing parameter: zoneId")
            }
            return
        }

        self.loadDelegate = delegate

        let request = MaioRequest(zoneId: zoneId, testMode: false)
        DispatchQueue.main.async {
            let ad = MaioRewarded.loadAd(request: request, callback: self)
            self.ad = ad;
        }
    }

    public override func isAdAvailable(with adData: ISAdData!) -> Bool {
        return isReady
    }

    public override func showAd(with viewController: UIViewController, adData: ISAdData, delegate: ISRewardedVideoAdDelegate) {
        guard let ad = self.ad else {
            DispatchQueue.main.async {
                delegate.adDidFailToShowWithErrorCode(20200, errorMessage: "Invalid show: Not ready")
            }
            return
        }

        self.showDelegate = delegate

        DispatchQueue.main.async {
            ad.show(viewContext: viewController, callback: self)
        }
    }
}

extension ISMaioCustomRewardedVideo: MaioRewardedLoadCallback, MaioRewardedShowCallback {
    public func didLoad(_ ad: MaioRewarded) {
        isReady = true
        self.loadDelegate?.adDidLoad()
    }

    public func didOpen(_ ad: MaioRewarded) {
        self.showDelegate?.adDidOpen()
    }
    public func didClose(_ ad: MaioRewarded) {
        self.showDelegate?.adDidClose()
    }
    public func didClick(_ ad: MaioRewarded) {
        self.showDelegate?.adDidClick()
    }
    public func didReward(_ ad: MaioRewarded, reward: RewardData) {
        self.showDelegate?.adRewarded()
    }

    public func didFail(_ ad: MaioRewarded, errorCode: Int) {
        let errorMessage = ISMaioCustomAdapter.errorMessage(from: errorCode)

        if 10000..<20000 ~= errorCode {
            if 10700..<10800 ~= errorCode {
                self.loadDelegate?.adDidFailToLoadWith(.noFill, errorCode: errorCode, errorMessage: errorMessage)
            } else {
                self.loadDelegate?.adDidFailToLoadWith(.internal, errorCode: errorCode, errorMessage: errorMessage)
            }

        } else if 20000..<30000 ~= errorCode {
            self.showDelegate?.adDidFailToShowWithErrorCode(errorCode, errorMessage: errorMessage)
        }

        // fallback
        if !isReady {
            self.loadDelegate?.adDidFailToLoadWith(.internal, errorCode: errorCode, errorMessage: errorMessage)
        } else {
            self.showDelegate?.adDidFailToShowWithErrorCode(errorCode, errorMessage: errorMessage)
        }
    }
}
