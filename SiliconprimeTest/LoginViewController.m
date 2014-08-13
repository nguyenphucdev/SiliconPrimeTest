//
//  LoginViewController.m
//  SiliconprimeTest
//
//  Created by Apple on 7/31/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import "LoginViewController.h"
#import "Constants.h"
#import "PlaceTableViewController.h"
@interface LoginViewController ()

-(void)toggleHiddenState:(BOOL)shouldHide;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self toggleHiddenState:YES];
     self.logo.hidden = NO;
    self.lblLoginStatus.text = @"";
    
    self.loginButton.delegate = self;
    self.loginButton.readPermissions = @[@"public_profile", @"email"];
    self.logo.frame = CGRectMake(20, 10, 300, 50);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private method implementation

-(void)toggleHiddenState:(BOOL)shouldHide{
    self.lblUsername.hidden = shouldHide;
    self.lblEmail.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;
    self.gotoMainView.hidden = shouldHide;
    
}


#pragma mark - FBLoginView Delegate method implementation

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    
    [self toggleHiddenState:NO];
}


-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    self.logo.hidden = YES;
    self.profilePicture.profileID = user.objectID;
    self.lblUsername.text = user.name;
    self.lblEmail.text = [user objectForKey:@"email"];
    [[NSUserDefaults standardUserDefaults]  setObject:[user objectForKey:@"email"] forKey:defaultUserID];
 
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PlaceTableViewController * placeTableViewController = (PlaceTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"PlaceView"];
    placeTableViewController.view.frame = CGRectMake(0, 20, placeTableViewController.view.frame.size.width, placeTableViewController.view.frame.size.height);
    [self presentViewController:placeTableViewController animated:YES completion:nil];
}


-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    self.logo.hidden = NO;
    [self toggleHiddenState:YES];
}
-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
}
- (IBAction)MainView:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PlaceTableViewController * placeTableViewController = (PlaceTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"PlaceView"];
    [self presentViewController:placeTableViewController animated:YES completion:nil];
}


@end
