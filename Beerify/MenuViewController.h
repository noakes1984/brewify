//
//  ViewController.h
//  Beerify
//
//  Created by Matthew Noakes on 10/9/16.
//  Copyright © 2016 Matthew Noakes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOSAlertView.h"
#import <Parse/Parse.h>
#import "ParseUI.h"
#import "AMPActivityIndicator.h"
//#import "ParseFacebookUtils.h"


@interface MenuViewController : UIViewController < UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *menu;
    NSMutableArray *cost;

}

@property (strong, nonatomic) IBOutlet UITableView *tblContentListTwo;


@end
