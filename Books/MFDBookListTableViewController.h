//
//  MFDBookListTableViewController.h
//  Books
//
//  Created by Adland Lee on 6/2/14.
//  Copyright (c) 2014 Adland Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFDBookDetailViewController.h"

@interface MFDBookListTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, MFDBookDetailDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)cancelReturnToList:(UIStoryboardSegue *)segue;
- (IBAction)storeReturnToList:(UIStoryboardSegue *)segue;

@end
