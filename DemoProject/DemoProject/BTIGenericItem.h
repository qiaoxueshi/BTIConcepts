//
//  BTIGenericItem.h
//  DemoProject
//
//  Created by Brian Slick on 3/28/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BTIGenericItem : NSManagedObject

@property (nonatomic, retain) NSString * primary;
@property (nonatomic, retain) NSString * secondary;

@end
