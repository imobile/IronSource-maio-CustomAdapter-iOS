//
//  ISMaioCustomInterstitial.swift
//  ISMaioCustomAdapter
//

import IronSource
import Maio

@objc(ISMaioCustomInterstitial)
public class ISMaioCustomInterstitial: ISBaseInterstitial {

    var isReady = false

    var ad: MaioInterstitial?
    var loadDelegate: ISInterstitialAdDelegate?
    var showDelegate: ISInterstitialAdDelegate?

    public override func loadAd(with adData: ISAdData, delegate: ISInterstitialAdDelegate) {
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

    public override func isAdAvailable(with adData: ISAdData!) -> Bool {
        return isReady
    }

    public override func showAd(with viewController: UIViewController, adData: ISAdData, delegate: ISInterstitialAdDelegate) {
        guard let ad = self.ad else {
            DispatchQueue.main.async {
                delegate.adDidFailToShowWithErrorCode(20200, errorMessage: "Invalid show: Not ready")
            }
            return
        }

        self.showDelegate = delegate

        ad.show(viewContext: viewController, callback: self)
    }
}

extension ISMaioCustomInterstitial: MaioInterstitialLoadCallback, MaioInterstitialShowCallback {
    public func didLoad(_ ad: MaioInterstitial) {
        isReady = true
        self.loadDelegate?.adDidLoad()
    }

    public func didOpen(_ ad: MaioInterstitial) {
        self.showDelegate?.adDidOpen()
        self.showDelegate?.adDidShowSucceed()
    }
    public func didClose(_ ad: MaioInterstitial) {
        self.showDelegate?.adDidClose()
    }
    public func didClick(_ ad: MaioInterstitial) {
        self.showDelegate?.adDidClick()
    }

    public func didFail(_ ad: MaioInterstitial, errorCode: Int) {
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
