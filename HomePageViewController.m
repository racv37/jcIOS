//
//  HomePageViewController.m
//  MySampleApp
//
//  Created by Dongeui  on 6/10/17.
//
//

#import "HomePageViewController.h"
#import "ChurchInfoViewController.h"
#import "SermonTableViewController.h"
#import "AnnouncementTableViewController.h"
#import "LoginViewController.h"



@interface HomePageViewController ()

@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIView *announcementView;
@property (weak, nonatomic) IBOutlet UIView *sermonView;
@property (weak, nonatomic) IBOutlet UIImageView *topView;

@property (weak, nonatomic) IBOutlet UILabel *sermonLabel;
@property (weak, nonatomic) IBOutlet UILabel *announcementLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *joyfulLabel;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

@end

@implementation HomePageViewController

typedef double CGFloat;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addLabelManager];
    [self addTopUIViewTapRecognizer];
    [self addSermonUIViewTapRecognizer];
    [self addAnnouncementUIViewTapRecognizer];
    [self addChurchInfoUIViewTapRecognizer];
    [self addLayerManagerBtwEachUIView];
}

-(void)addLabelManager {
    self.sermonLabel.font = [UIFont fontWithName:@"System" size:20];
    [self.sermonLabel sizeToFit];
    self.infoLabel.font = [UIFont fontWithName:@"System" size:20];
    [self.infoLabel sizeToFit];
    self.announcementLabel.font = [UIFont fontWithName:@"System" size:20];
    [self.announcementLabel sizeToFit];
}

-(void)addTopUIViewTapRecognizer {
    UITapGestureRecognizer *topTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapDetected:)];
    topTap.numberOfTapsRequired = 7;
    [self.topView setUserInteractionEnabled:YES];
    [self.topView addGestureRecognizer:topTap];
}

-(void)addSermonUIViewTapRecognizer {
    UITapGestureRecognizer *sermonTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSermonTap:)];
    [self.sermonView addGestureRecognizer:sermonTap];
}

-(void)addAnnouncementUIViewTapRecognizer {
    UITapGestureRecognizer *announcementTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleAnnouncementTap:)];
    [self.announcementView addGestureRecognizer:announcementTap];
}

-(void)addChurchInfoUIViewTapRecognizer {
    UITapGestureRecognizer *infoTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleInfoTap:)];
    [self.infoView addGestureRecognizer:infoTap];
}


-(void)addLayerManagerBtwEachUIView {
    _topView.layer.borderWidth = .6f;
    _topView.layer.borderColor = [[UIColor colorWithRed:(80.0f/255.0f) green:(168.0f/255.0f) blue:(215.0f/255.0f) alpha:1.0f]CGColor];
    
    _infoView.layer.borderWidth = .6f;
    _infoView.layer.borderColor = [[UIColor colorWithRed:(80.0f/255.0f) green:(168.0f/255.0f) blue:(215.0f/255.0f) alpha:1.0f]CGColor];
    
    _announcementView.layer.borderWidth = .6f;
    _announcementView.layer.borderColor = [[UIColor colorWithRed:(80.0f/255.0f) green:(168.0f/255.0f) blue:(215.0f/255.0f) alpha:1.0f]CGColor];
    
    _sermonView.layer.borderWidth = .6f;
    _sermonView.layer.borderColor = [[UIColor colorWithRed:(80.0f/255.0f) green:(168.0f/255.0f) blue:(215.0f/255.0f) alpha:1.0f]CGColor];
}

-(void)tapDetected:(UITapGestureRecognizer*)recognizer {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginStoryboard"];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

-(void)handleInfoTap:(UITapGestureRecognizer*)recognizer {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ChurchInfo" bundle:nil];
    ChurchInfoViewController *churchInfoViewController = [storyboard instantiateViewControllerWithIdentifier:@"ChurchInfoStoryboard"];
    [self.navigationController pushViewController:churchInfoViewController animated:YES];
}

-(void)handleSermonTap:(UITapGestureRecognizer*)recognizer {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Sermon" bundle:nil];
    SermonTableViewController *sermonViewController = [storyboard instantiateViewControllerWithIdentifier:@"SermonTableStoryboard"];
    [self.navigationController pushViewController:sermonViewController animated:YES];
}

-(void)handleAnnouncementTap:(UITapGestureRecognizer*)recognizer {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Announcement" bundle:nil];
    AnnouncementTableViewController *announcementViewController = [storyboard instantiateViewControllerWithIdentifier:@"AnnouncementStoryBoard"];
    [self.navigationController pushViewController:announcementViewController animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if(!self.navigationController.navigationBar.isHidden) {
        self.navigationController.navigationBar.hidden = YES;
    } else {
        self.navigationController.navigationBar.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
