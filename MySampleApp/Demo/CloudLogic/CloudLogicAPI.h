//
//  CloudLogicAPI.h
//  MySampleApp
//
//
// Copyright 2017 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to 
// copy, distribute and modify it.
//
// Source code generated from template: aws-my-sample-app-ios-objc v0.15
//

#import <Foundation/Foundation.h>

@class AWSAPIGatewayClient;

NS_ASSUME_NONNULL_BEGIN

/**
 *  Represents the configuration for a single Cloud Logic API endpoint in Amazon API Gateway.
 */
@interface CloudLogicAPI : NSObject

// Cloud Logic API display name
@property (nonatomic, readonly) NSString *displayName;

// Cloud Logic API description
@property (nonatomic, readonly, nullable) NSString *apiDescription;

// List of paths configured for the Cloud Logic API
@property (nonatomic, readonly) NSArray<NSString *> *paths;

// The api endpoint for configured Cloud Logic API
@property (nonatomic, readonly) NSString *endPoint;

// The api invocation client from the API Gateway generated SDK
@property (nonatomic, readonly) AWSAPIGatewayClient *apiClient;

/**
 *  Initializer for the CloudLogicAPI object
 *
 *  @param displayName    Cloud Logic API display name
 *  @param apiDescription Cloud Logic API description
 *  @param paths          List of paths configured for the Cloud Logic API
 *  @param endPoint       The api endpoint for configured Cloud Logic API
 *  @param apiClient      The invocation client implementing AWSAPIGatewayClient
 *
 *  @return CloudLogicAPI object
 */
- (instancetype)initWithName:(NSString *)displayName
                       paths:(NSArray<NSString *> *)paths
                    endPoint:(NSString *)endPoint
                   apiClient:(AWSAPIGatewayClient *)apiClient
              apiDescription:(NSString * _Nullable)apiDescription;

@end

NS_ASSUME_NONNULL_END