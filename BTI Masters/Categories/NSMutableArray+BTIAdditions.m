//
//  NSMutableArray+BTIAdditions.m
//
//  Created by Brian Slick in Feb 2013.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "NSMutableArray+BTIAdditions.h"

#import "BTIImport.h"

@implementation NSMutableArray (BTIAdditions)

- (void)removeFirstObjectBTI
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
		
	if ([self count] > 0)
	{
		[self removeObjectAtIndex:0];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)moveObjectAtIndexBTI:(NSUInteger)fromIndex
					 toIndex:(NSUInteger)toIndex
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	id movingObject = [self objectAtIndex:fromIndex];
	
	[self removeObjectAtIndex:fromIndex];
	[self insertObject:movingObject atIndex:toIndex];

	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
