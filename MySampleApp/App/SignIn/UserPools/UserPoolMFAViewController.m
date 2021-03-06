//
//  UserPoolMFAViewController.m
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

#import "UserPoolMFAViewController.h"
#import <AWSMobileHubHelper/AWSMobileHubHelper.h>

@interface UserPoolMFAViewController () 

@property (strong, nonatomic) NSString *destination;
@property (nonatomic,strong) AWSTaskCompletionSource<NSString *>* mfaCodeCompletionSource;
@property (weak, nonatomic) IBOutlet UILabel *cancel;

@end

@implementation UserPoolMFAViewController

#pragma mark - UIViewController

- (void) viewWillAppear:(BOOL)animated {
    self.codeSentTo.text = self.destination;
    self.authenticationCode.text = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)onSignIn:(id)sender {
    self.mfaCodeCompletionSource.result = self.authenticationCode.text;
}

-(void) getMultiFactorAuthenticationCode: (AWSCognitoIdentityMultifactorAuthenticationInput *)authenticationInput mfaCodeCompletionSource: (AWSTaskCompletionSource<NSString *> *) mfaCodeCompletionSource {
    self.mfaCodeCompletionSource = mfaCodeCompletionSource;
    self.destination = authenticationInput.destination;
}


-(void) didCompleteMultifactorAuthenticationStepWithError:(NSError*) error {
    dispatch_async(dispatch_get_main_queue(), ^{
        if(error){
            [[[UIAlertView alloc] initWithTitle:error.userInfo[@"__type"]
                                        message:error.userInfo[@"message"]
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"Retry", nil] show];
        }
    });
}

- (IBAction)onCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
