//
//  ISMaioCustomAdapter.m
//  ISMaioCustomAdapter
//

#import "ISMaioCustomAdapter.h"
#import "ISMaioCustomAdapterConstants.h"

#import <Maio/Maio-Swift.h>

@implementation ISMaioCustomAdapter

- (void)init:(ISAdData*)adData delegate:(id<ISNetworkInitializationDelegate>)delegate {

    [delegate onInitDidSucceed];
}

- (NSString *)networkSDKVersion {
    return MaioVersion.shared.toString;
}

-(NSString *)adapterVersion {
    return ISMaioCustomAdapterversion;
}

@end
