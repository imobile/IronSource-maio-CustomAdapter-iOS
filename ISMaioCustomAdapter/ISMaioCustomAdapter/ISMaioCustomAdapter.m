//
//  ISMaioCustomAdapter.m
//  ISMaioCustomAdapter
//

#import "ISMaioCustomAdapter.h"

@implementation ISMaioCustomAdapter

- (void)init:(ISAdData*)adData delegate:(id<ISNetworkInitializationDelegate>)delegate {

    [delegate onInitDidSucceed];
}


@end
