//
//  BranchTest.m
//  Branch-TestBed
//
//  Created by Graham Mueller on 4/27/15.
//  Copyright (c) 2015 Branch Metrics. All rights reserved.
//

#import "BranchTest.h"
#import "BNCPreferenceHelper.h"

@interface BranchTest ()

@property (assign, nonatomic) BOOL hasExceededExpectations;

@end

@implementation BranchTest

+ (void)setUp {
    [super setUp];

    BNCPreferenceHelper *preferenceHelper = [BNCPreferenceHelper preferenceHelper];
    if (!preferenceHelper.deviceFingerprintID) {
        preferenceHelper.deviceFingerprintID = @"foo_fingerprint";
    }

    if (!preferenceHelper.identityID) {
        preferenceHelper.identityID = @"foo_identity";
    }

    if (!preferenceHelper.sessionID) {
        preferenceHelper.sessionID = @"foo_sesion";
    }
}

- (void)setUp {
    [super setUp];
    
    [self resetExpectations];
}

- (void)resetExpectations {
    self.hasExceededExpectations = NO;
}

- (void)safelyFulfillExpectation:(XCTestExpectation *)expectation {
    if (!self.hasExceededExpectations) {
        [expectation fulfill];
    }
}

- (void)awaitExpectations {
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        self.hasExceededExpectations = YES;
    }];
}

@end
