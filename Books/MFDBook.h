//
//  MFDBook.h
//  Books
//
//  Created by Adland Lee on 6/2/14.
//  Copyright (c) 2014 Adland Lee. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface MFDBook : NSManagedObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *author;
@property (nonatomic) NSDate *copyright;

@end
