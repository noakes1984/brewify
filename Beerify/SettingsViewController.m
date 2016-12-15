//
//  BeerLIstController.m
//  Beerify
//
//  Created by Matthew Noakes on 12/13/16.
//  Copyright © 2016 Matthew Noakes. All rights reserved.
//

//
//  ViewController.m
//  Beerify
//
//  Created by Matthew Noakes on 10/9/16.
//  Copyright © 2016 Matthew Noakes. All rights reserved.
//

#import "SettingsViewController.h"
#import "AFNetworking.h"
#import <pop/POP.h>

@import CoreLocation;

@interface SettingsViewController () <PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate, CLLocationManagerDelegate, CustomIOSAlertViewDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;

- (IBAction)logOut:(id)sender;




@end

@implementation SettingsViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidAppear:(BOOL)animated {
    if (![PFUser currentUser]) { // No user logged in
        
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        logInViewController.fields =  ( PFLogInFieldsUsernameAndPassword
                                       | PFLogInFieldsLogInButton
                                       | PFLogInFieldsSignUpButton
                                       | PFLogInFieldsPasswordForgotten
                                       | PFLogInFieldsDismissButton
                                       | PFLogInFieldsFacebook
                                       | PFLogInFieldsTwitter
                                       );
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        signUpViewController.fields =  ( PFSignUpFieldsUsernameAndPassword
                                        | PFSignUpFieldsEmail
                                        | PFSignUpFieldsDismissButton
                                        | PFSignUpFieldsSignUpButton
                                        );
        
        signUpViewController.minPasswordLength = 6;
        [signUpViewController emailAsUsername];
        
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:nil];
        
    }
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //self.view.backgroundColor = [UIColor colorWithRed:224.0f/255.0f green:227.0f/255.0f blue:229.0f/255.0f alpha:100];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    //self.fromLabel = [[UILabel alloc]init];
    //self.fromLabel.text = [[PFUser currentUser] valueForKey:@"username"];
    //NSLog(@"%@", self.fromLabel.text);
    
    self.usernameLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 60, 200, 20)];//Set frame of label in your viewcontroller.
    //[self.fromLabel setBackgroundColor:[UIColor lightGrayColor]];//Set background color of label.
    [self.usernameLabel setText:[[PFUser currentUser] valueForKey:@"username"]];
    [self.view addSubview:self.usernameLabel];
    
    self.emailLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 120, 200, 20)];//Set frame of label in your viewcontroller.
    //[self.fromLabel setBackgroundColor:[UIColor lightGrayColor]];//Set background color of label.
    [self.emailLabel setText:[[PFUser currentUser] valueForKey:@"email"]];
    [self.view addSubview:self.emailLabel];
    
    self.memberLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 180, 100, 20)];//Set frame of label in your viewcontroller.
    //[self.fromLabel setBackgroundColor:[UIColor lightGrayColor]];//Set background color of label.
    
    //NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [PFUser currentUser].createdAt;
    //[calendar components:(NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitMonth) fromDate:date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [self.memberLabel setText:[formatter stringFromDate:date]];

    
    NSLog(@"%@", [formatter stringFromDate:date]);
    
    [self.view addSubview:self.memberLabel];

    
    //[self.view addSubview:fromLabel];
    

    
    
    
    //NSLog(@"%@", [[PFUser currentUser] valueForKey:@"username"]);
    [self.locationManager startUpdatingLocation];
    //PFObject *object = (some object);
    }

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)signUpViewControllerDidCancelSignUP:(PFSignUpViewController *)signUpController {
    [self dismissModalViewControllerAnimated:YES];
}




- (IBAction)logOut:(id)sender {
    [PFUser logOut];
    
    self.usernameLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 60, 200, 20)];//Set frame of label in your viewcontroller.
    //[self.fromLabel setBackgroundColor:[UIColor lightGrayColor]];//Set background color of label.
    [self.usernameLabel setText:[[PFUser currentUser] valueForKey:@"username"]];
    [self.view addSubview:self.usernameLabel];
    
    self.emailLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 120, 200, 20)];//Set frame of label in your viewcontroller.
    //[self.fromLabel setBackgroundColor:[UIColor lightGrayColor]];//Set background color of label.
    [self.emailLabel setText:[[PFUser currentUser] valueForKey:@"email"]];
    [self.view addSubview:self.emailLabel];
    
    self.memberLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 180, 100, 20)];//Set frame of label in your viewcontroller.
    //[self.fromLabel setBackgroundColor:[UIColor lightGrayColor]];//Set background color of label.
    
    //NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [PFUser currentUser].createdAt;
    //[calendar components:(NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitMonth) fromDate:date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [self.memberLabel setText:[formatter stringFromDate:date]];
    
    
    NSLog(@"%@", [formatter stringFromDate:date]);
    
    [self.view addSubview:self.memberLabel];

    
    if (![PFUser currentUser]) { // No user logged in
        
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        logInViewController.fields =  ( PFLogInFieldsUsernameAndPassword
                                       | PFLogInFieldsLogInButton
                                       | PFLogInFieldsSignUpButton
                                       | PFLogInFieldsPasswordForgotten
                                       | PFLogInFieldsDismissButton
                                       | PFLogInFieldsFacebook
                                       | PFLogInFieldsTwitter
                                       );
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        signUpViewController.fields =  ( PFSignUpFieldsUsernameAndPassword
                                        | PFSignUpFieldsEmail
                                        | PFSignUpFieldsDismissButton
                                        | PFSignUpFieldsSignUpButton
                                        );
        
        signUpViewController.minPasswordLength = 6;
        
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:nil];
        
    }
    
    
}






@end
