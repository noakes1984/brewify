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


@interface BeerListController : UIViewController < UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *beerList;
    NSMutableArray *style;
    NSMutableArray *beerABV;
    

}
@property (strong, nonatomic) IBOutlet UITableView *tblContentListThree;



@end
