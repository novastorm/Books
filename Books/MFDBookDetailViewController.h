//
//  MFDBookDetailViewController.h
//  Books
//
//  Created by Adland Lee on 6/3/14.
//  Copyright (c) 2014 Adland Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFDBook.h"

@protocol MFDBookDetailDelegate;

@interface MFDBookDetailViewController : UIViewController

@property (strong, nonatomic) MFDBook *book;
@property (nonatomic, unsafe_unretained) id <MFDBookDetailDelegate> delegate;

- (void)setCreating;
- (void)setShowing;

@end


#pragma mark -

@protocol MFDBookDetailDelegate <NSObject>

// recipe == nil on cancel
- (void)unwindBookDetailViewController:(MFDBookDetailViewController *)bookDetailViewController;

@end
