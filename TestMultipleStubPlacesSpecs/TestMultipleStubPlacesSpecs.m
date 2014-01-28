//
//  TestMultipleStubPlacesSpecs.m
//  TestMultipleStubPlacesSpecs
//
//  Created by Philippe Bernery on 28/01/2014.
//  Copyright (c) 2014 Philippe Bernery. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import "PBAppDelegate.h"

SPEC_BEGIN(StubSpecs)

describe(@"stubs declaration", ^{
    beforeAll(^{
        PBAppDelegate *appDelegate = (PBAppDelegate *)[UIApplication sharedApplication].delegate;
        [[expectFutureValue(theValue(appDelegate.ready)) should] beTrue];
        
        [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
            return [request.URL.host isEqualToString:@"google.com"];
        } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
            return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"test.txt", nil) statusCode:200 headers:@{@"Content-Type": @"text/plain"}];
        }].name = @"Another stub";
    });
    
    it(@"should have 2 stubs", ^{
        [[[OHHTTPStubs allStubs] should] haveCountOf:2];
        NSLog(@"stubs: %@", [OHHTTPStubs allStubs]);
    });
});

SPEC_END
