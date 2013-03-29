//
//  NSMutableArray+BTIAdditions.h
//
//  Created by Brian Slick in Feb 2013.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (BTIAdditions)

/*
 Removes the first object in the array.
 */
- (void)removeFirstObjectBTI;

/*
 Moves an object in the array from/to the specified indexes
 */
- (void)moveObjectAtIndexBTI:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
