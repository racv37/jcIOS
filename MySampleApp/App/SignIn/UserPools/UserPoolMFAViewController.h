//
//  UserPoolMFAViewController.h
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
//

#import <UIKit/UIKit.h>
#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@interface UserPoolMFAViewController : UIViewController<AWSCognitoIdentityMultiFactorAuthentication>

@property (weak, nonatomic) IBOutlet UITextField *authenticationCode;
@property (weak, nonatomic) IBOutlet UILabel *codeSentTo;

@end