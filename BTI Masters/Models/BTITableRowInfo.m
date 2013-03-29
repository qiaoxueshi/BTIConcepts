//
//  BTITableRowInfo.m
//
//  Created by Brian Slick in Sept 2012
//  Copyright (c) 2012 BriTer Ideas LLC. All rights reserved.
//

#import "BTITableRowInfo.h"

#import "BTIImport.h"

// Models and other global

// Private Constants

@interface BTITableRowInfo ()

// Private Properties

// Notification Handlers

// Misc Methods

@end

@implementation BTITableRowInfo

#pragma mark - Synthesized Properties

// Needed because readonly properties don't auto-create ivars.
@synthesize UUIDString = _UUIDString;

#pragma mark - Dealloc and Memory Management


#pragma mark - Custom Getters and Setters

- (NSString *)UUIDString
{
	if (_UUIDString == nil)
	{
		_UUIDString = [[NSUUID UUID] UUIDString];
	}
	return _UUIDString;
}

#pragma mark - Initialization

- (id)init
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	self = [super init];
	if (self)
	{
		[self UUIDString];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return self;
}

#pragma mark - NSObject Methods

- (NSUInteger)hash
{
	return [[self UUIDString] hash];
}

- (BOOL)isEqual:(id)anObject
{
	BOOL isEqual = NO;
	
	if ([anObject isKindOfClass:[self class]])
	{
		isEqual = ([[(BTITableRowInfo *)anObject UUIDString] isEqualToString:[self UUIDString]]);
	}
	
	return isEqual;
}

#pragma mark - Misc Methods

- (void)reset
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	[self setRepresentedObject:nil];
	[self setIdentifier:nil];
	[self setParentSectionInfo:nil];
	[self setText:nil];
	[self setDetailText:nil];
	[self setRowSelectionBlock:nil];

	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
