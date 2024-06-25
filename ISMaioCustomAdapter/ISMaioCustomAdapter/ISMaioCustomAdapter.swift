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
}
