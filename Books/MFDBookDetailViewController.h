//
//  MFDBookDetailViewController.h
//  Books
//
//  Created by Adland Lee on 6/3/14.
//  Copyright (c) 2014 Adland Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFDBook.h"

@interface MFDBookDetailViewController : UIViewController

@property (strong, nonatomic) MFDBook *book;

- (void)setCreating;
- (void)setShowing;

@end
