//
//  SettingsViewController.h
//  Beerify
//
//  Created by Matthew Noakes on 12/15/16.
//  Copyright © 2016 Matthew Noakes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOSAlertView.h"
#import <Parse/Parse.h>
#import "ParseUI.h"
#import "AMPActivityIndicator.h"


@interface SettingsViewController : UIViewController < UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *memberLabel;



@end
