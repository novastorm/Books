//
//  MFDBookDetailViewController.h
//  Books
//
//  Created by Adland Lee on 6/3/14.
//  Copyright (c) 2014 Adland Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MFDBookDetailDelegate;

@class MFDBook;

@interface MFDBookDetailViewController : UIViewController

@property (nonatomic) MFDBook *book;
@property (nonatomic, weak) id <MFDBookDetailDelegate> delegate;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)setCreating;
- (void)setShowing;

@end


#pragma mark -

@protocol MFDBookDetailDelegate <NSObject>

- (void)returnFromBookDetailViewController:(MFDBookDetailViewController *)controller didFinishWithSave:(BOOL)save;

@end
