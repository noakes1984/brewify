//
//  ViewController.m
//  Beerify
//
//  Created by Matthew Noakes on 10/9/16.
//  Copyright © 2016 Matthew Noakes. All rights reserved.
//

#import "MenuViewController.h"
#import "AFNetworking.h"
#import <pop/POP.h>

@import CoreLocation;

@interface MenuViewController () <PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate, CLLocationManagerDelegate, CustomIOSAlertViewDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;

- (IBAction)logOut:(id)sender;




@end

@implementation MenuViewController

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
    PFQuery *queryWithClassName = [PFQuery queryWithClassName:@"Menu"];
    //[queryWithClassName whereKey:@"" equalTo:NO];
    queryWithClassName.cachePolicy =kPFCachePolicyCacheThenNetwork;
    [queryWithClassName findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        menu = [objects valueForKey:@"name"];
        NSLog(@"%@", [objects valueForKey:@"name"]);
        [_tblContentListTwo reloadData];
        //[self.view endEditing:YES];
        
        
        
    }];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:224.0f/255.0f green:227.0f/255.0f blue:229.0f/255.0f alpha:100];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    PFQuery *queryWithClassName = [PFQuery queryWithClassName:@"Menu"];
    //[queryWithClassName whereKey:@"" equalTo:NO];
    queryWithClassName.cachePolicy =kPFCachePolicyCacheThenNetwork;
    [queryWithClassName findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        menu = [objects valueForKey:@"name"];
        if([[objects valueForKey:@"cost"] count]==1){
            //cost = [NSMutableArray arrayWithObjects:@"0%@", [objects valueForKey:@"cost"], nil];
        }
        //cost = [objects valueForKey:@"cost"];
        
        NSLog(@"%@", cost);
        [_tblContentListTwo reloadData];
        //[self.view endEditing:YES];
        
        
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [menu count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //alternate colors of cells
    if( [indexPath row] % 2)
        [cell setBackgroundColor:[UIColor colorWithRed:224.0f/255.0f green:227.0f/255.0f blue:229.0f/255.0f alpha:100]];
    else
        [cell setBackgroundColor:[UIColor colorWithRed:231.0f/255.0f green:234.0f/255.0f blue:235.0f/255.0f alpha:100]];
    
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[menu objectAtIndex:indexPath.row]];
    
    return cell;
    
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
}

//parseUI dismith methods
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    sprintAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(4, 4)];
    sprintAnimation.springBounciness = 20.f;
    //[cell pop_addAnimation:sprintAnimation forKey:@"size"];
    [cell.textLabel pop_addAnimation:sprintAnimation forKey:@"size"];
    
   
}
/*
 //For customer alert view if needed
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    
    if ((int)buttonIndex==0){
        NSLog(@"this should run");
    } else {
        
      
    }
    [alertView close];
}


- (UIView *)createDemoView
{
   
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
 
    NSData *imageData = [NSData dataWithContentsOfURL:_imageURL];
    //NSLog(@"imge %@",imageData);
    UIImage *image = [UIImage imageWithData:imageData];
    //NSLog(@"imge %@",image);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 180)];
    [imageView setImage:image];
    [demoView addSubview:imageView];
 
    return demoView;
    
}

*/




@end


