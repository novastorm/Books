//
//  MFDBookListTableViewController.h
//  Books
//
//  Created by Adland Lee on 6/2/14.
//  Copyright (c) 2014 Adland Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFDBookListTableViewController : UITableViewController

-(IBAction)cancelCreateReturnToList:(UIStoryboardSegue *)segue;
-(IBAction)storeCreateReturnToList:(UIStoryboardSegue *)segue;

@end
