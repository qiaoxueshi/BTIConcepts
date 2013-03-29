//
//  BTINotificationHelper.m
//
//  Created by Brian Slick in Sept 2012.
//  Copyright (c) 2012 BriTer Ideas LLC. All rights reserved.
//

#import "BTINotificationHelper.h"

#import "BTIImport.h"

@interface BTINotificationHelper ()

// Private Properties
@property (nonatomic, weak) id observer;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, weak) id object;
@property (nonatomic, assign) BTINotificationRegistrationLifeSpan lifeSpan;

@end

@implementation BTINotificationHelper

#pragma mark - Synthesized Properties



#pragma mark - Misc Methods

+ (instancetype)notificationHelperWithObserver:(id)observer
									  selector:(SEL)selector
										  name:(NSString *)name
										object:(id)object
									  lifeSpan:(BTINotificationRegistrationLifeSpan)lifeSpan;
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	if (observer == nil)
	{
		//BTITrackingLog(@"<<< Leaving %s >>> BTINotificationHelper NOT created: No observer", __PRETTY_FUNCTION__);
		return nil;
	}
	
	if (name == nil)
	{
		//BTITrackingLog(@"<<< Leaving %s >>> BTINotificationHelper NOT created: No name", __PRETTY_FUNCTION__);
		return nil;
	}
	
	BTINotificationHelper *helper = [[BTINotificationHelper alloc] init];
	
	[helper setObserver:observer];
	[helper setSelector:selector];
	[helper setName:name];
	[helper setObject:object];
	[helper setLifeSpan:lifeSpan];

	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return helper;
}

- (void)register
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[[NSNotificationCenter defaultCenter] addObserver:[self observer]
											 selector:[self selector]
												 name:[self name]
											   object:[self object]];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)unregister
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[[NSNotificationCenter defaultCenter] removeObserver:[self observer]
													name:[self name]
												  object:[self object]];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
