//
//  PBAppDelegate.m
//  TestMultipleStubPlaces
//
//  Created by Philippe Bernery on 28/01/2014.
//  Copyright (c) 2014 Philippe Bernery. All rights reserved.
//

#import "PBAppDelegate.h"

@implementation PBAppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupStub];
    
    self.ready = YES;
    
    return YES;
}

#pragma mark - Helpers

- (void)setupStub
{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:@"google.com"];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"test.txt", nil) statusCode:200 headers:@{@"Content-Type": @"text/plain"}];
    }].name = @"General stub";
}

@end
