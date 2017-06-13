//
//  MainViewController.m
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
#import "MainViewController.h"
#import "DemoFeature.h"
#import <AWSMobileHubHelper/AWSMobileHubHelper.h>
#import "ColorThemeSettings.h"

static NSString * LOG_TAG = @"MainViewController";

@interface MainViewController ()

@property (nonatomic, strong) NSMutableArray *demoFeatures;

@property (nonatomic, strong) id didSignInObserver;
@property (nonatomic, strong) id didSignOutObserver;
@property (nonatomic, strong) id willEnterForegroundObserver;

@end

@implementation MainViewController

#pragma mark - View Controller lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.backBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                         style:UIBarButtonItemStylePlain
                                        target:nil
                                        action:nil];
    
    // You need to call `- updateTheme` here in case the sign-in happens before `- viewWillAppear:` is called.
    [self updateTheme];

    self.willEnterForegroundObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification
                                                                                         object:nil
                                                                                          queue:[NSOperationQueue mainQueue]
                                                                                     usingBlock:^(NSNotification * _Nonnull note) {
                                                                                         [self updateTheme];
                                                                                     }];


    NSLog(@"%@: Loading...", LOG_TAG);
    self.demoFeatures = [[NSMutableArray alloc] init];

    DemoFeature *demoFeature =
        [[DemoFeature alloc] initWithName:NSLocalizedString(@"User Sign-in",
                                                            @"Label for demo menu option.")
                                   detail:NSLocalizedString(@"Enable user login with popular 3rd party providers.",
                                                            @"Description for demo menu option.")
                                     icon:@"UserIdentityIcon"
                               storyboard:@"UserIdentity"];
    [self.demoFeatures addObject:demoFeature];
    
    
    
    

    demoFeature =
        [[DemoFeature alloc] initWithName:NSLocalizedString(@"User Data Storage",
                                                            @"Label for demo menu option.")
                                   detail:NSLocalizedString(@"Save user files in the cloud and sync user data in key/value pairs.",
                                                            @"Description for demo menu option.")
                                     icon:@"UserFilesIcon"
                               storyboard:@"UserDataStorage"];
    [self.demoFeatures addObject:demoFeature];
    demoFeature =
    [[DemoFeature alloc] initWithName:NSLocalizedString(@"Cloud Logic",
                                                        @"Label for demo menu option.")
                               detail:NSLocalizedString(@"Run business logic in the cloud without managing servers. Integrate functionality with your app using APIs.",
                                                        @"Description for demo menu option.")
                                 icon:@"CloudLogicAPIIcon"
                           storyboard:@"CloudLogicAPI"];
    [self.demoFeatures addObject:demoFeature];
    demoFeature =
    [[DemoFeature alloc] initWithName:NSLocalizedString(@"NoSQL Database",
                                                        @"Label for demo menu option.")
                               detail:NSLocalizedString(@"Store data in the cloud.",
                                                        @"Description for demo menu option.")
                                 icon:@"NoSQLIcon"
                           storyboard:@"NoSQLDatabase"];
    [self.demoFeatures addObject:demoFeature];
    __weak MainViewController *weakSelf = self;
    self.didSignInObserver =
        [[NSNotificationCenter defaultCenter]
            addObserverForName:AWSIdentityManagerDidSignInNotification
                        object:[AWSIdentityManager defaultIdentityManager]
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification * _Nonnull note) {
                                   [weakSelf setupRightBarButtonItem];
                                   // You need to call `- updateTheme` here in case the sign-in happens after `- viewWillAppear:` is called.
                                   [weakSelf updateTheme];
                               }];
    self.didSignOutObserver =
        [[NSNotificationCenter defaultCenter]
            addObserverForName:AWSIdentityManagerDidSignOutNotification
                        object:[AWSIdentityManager defaultIdentityManager]
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification * _Nonnull note) {
                                   [weakSelf setupRightBarButtonItem];
                                   [weakSelf updateTheme];
                               }];

    [self setupRightBarButtonItem];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self.didSignInObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self.didSignOutObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self.willEnterForegroundObserver];
}

- (void)setupRightBarButtonItem {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithTitle:nil
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:nil];
        self.navigationItem.rightBarButtonItem = loginButton;
    });

    if ([[AWSIdentityManager defaultIdentityManager] isLoggedIn]) {
        self.navigationItem.rightBarButtonItem.title = NSLocalizedString(@"Sign-Out", @"Label for the logout button.");
        self.navigationItem.rightBarButtonItem.action = @selector(handleLogout);
    }

    if (![[AWSIdentityManager defaultIdentityManager] isLoggedIn]) {
        self.navigationItem.rightBarButtonItem.title = NSLocalizedString(@"Sign-In", @"Label for the login button.");
        self.navigationItem.rightBarButtonItem.action = @selector(goToLogin);
    }
}

#pragma mark - UITableViewController delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainViewCell"];
    
    DemoFeature *demoFeature = self.demoFeatures[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[demoFeature icon]];
    cell.textLabel.text = [demoFeature displayName];
    cell.detailTextLabel.text = [demoFeature detailText];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.demoFeatures count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    DemoFeature *demoFeature = [self.demoFeatures objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:demoFeature.storyboard
                                                         bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:demoFeature.storyboard];
    
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}

#pragma mark -

- (void)updateTheme {
    ColorThemeSettings *settings = [ColorThemeSettings sharedInstance];
    [settings loadSettings:^(ColorThemeSettings *themeSettings, NSError *error) {
        if (error) {
            NSLog(@"Failed to load the color theme settings. %@", error);
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            UIColor *titleTextColor = UIColorFromARGB(themeSettings.theme.titleTextColor);
            self.navigationController.navigationBar.barTintColor = UIColorFromARGB(themeSettings.theme.titleBarColor)
            self.view.backgroundColor = UIColorFromARGB(themeSettings.theme.backgroundColor);
            self.navigationController.navigationBar.tintColor = titleTextColor;
            [self.navigationController.navigationBar setTitleTextAttributes: @{ NSForegroundColorAttributeName : titleTextColor }];
        });
    }];
}

- (void)goToLogin {
    NSLog(@"%@: Handling optional sign-in", LOG_TAG);
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"SignIn"
                                                              bundle:nil];
    UIViewController *loginController = [loginStoryboard instantiateViewControllerWithIdentifier:@"SignIn"];
    [self.navigationController pushViewController:loginController
                                         animated:YES];
}

- (void)handleLogout {
    if ([[AWSIdentityManager defaultIdentityManager] isLoggedIn]) {
        [[ColorThemeSettings sharedInstance] wipe];
        [[AWSIdentityManager defaultIdentityManager] logoutWithCompletionHandler:^(id result, NSError *error) {
            [self.navigationController popToRootViewControllerAnimated:NO];
            [self setupRightBarButtonItem];
        }];
        //NSLog(@"%@: %@ Logout Successful", LOG_TAG, [signInProvider getDisplayName]);
    } else {
        assert(false);
    }
}

@end

@implementation FeatureDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.backBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                         style:UIBarButtonItemStylePlain
                                        target:nil
                                        action:nil];
}

@end