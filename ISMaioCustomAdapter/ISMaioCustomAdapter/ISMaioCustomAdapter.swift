//
//  ISMaioCustomAdapter.swift
//  ISMaioCustomAdapter
//

import IronSource
import Maio

@objc(ISMaioCustomAdapter)
public class ISMaioCustomAdapter: ISBaseNetworkAdapter {

    public override func `init` (_ adData: ISAdData, delegate: ISNetworkInitializationDelegate) {
        delegate.onInitDidSucceed()
        return
    }

    public override func networkSDKVersion() -> String! {
        return MaioVersion.shared.toString()
    }

    public override func adapterVersion() -> String! {
        return ISMaioCustomAdapterVersion
    }

    static func errorMessage(from errorCode: Int) -> String {
        return switch errorCode {
        case 0: "Unknown error"
        case 10100..<10200: "No network"
        case 10200..<10300: "Network timeout"
        case 10300..<10400: "Aborted download"
        case 10400..<10500: "Invalid response"
        case 10500..<10600: "Zone not found"
        case 10600..<10700: "Unavailable zone"
        case 10700..<10800: "No fill"
        case 10800..<10900: "Null args: MaioRequest"
        case 10900..<11000: "Disc space not enough"
        case 11000..<11100: "Unsupported OS version"

        case 20100..<20200: "Ad expired"
        case 20200..<20300: "Not ready yet"
        case 20300..<20400: "Already shown"
        case 20400..<20500: "Failed playback"
        case 20500..<20600: "Null args: ViewContext"

        default:
            "Unhandled error code"
        }
    }
}
