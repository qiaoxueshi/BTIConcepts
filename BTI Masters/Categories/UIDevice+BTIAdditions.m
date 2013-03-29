//
//  UIDevice+BTIAdditions.m
//  DemoProject
//
//  Created by Brian Slick on 3/29/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "UIDevice+BTIAdditions.h"

@implementation UIDevice (BTIAdditions)

+ (BOOL)isIpadBTI
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
		
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
}

+ (BOOL)isIphoneBTI
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
}

@end
