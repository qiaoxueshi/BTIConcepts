//
//  BTITableViewCell.m
//
//  Created by Brian Slick in Feb 2013.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//
// reuseIdentifier concept from http://iphonedevelopment.blogspot.com/2010/04/table-view-cells-redux.html

#import "BTITableViewCell.h"

// Models and other global
#import "BTIImport.h"

// Private Constants

@interface BTITableViewCell ()

// Private Properties

// UI Response Methods

// Misc Methods

@end

@implementation BTITableViewCell

#pragma mark - Dealloc and Memory Management


#pragma mark - Custom Getters and Setters


#pragma mark - Initialization and UI Creation Methods

- (id)initWithStyle:(UITableViewCellStyle)style
	reuseIdentifier:(NSString *)reuseIdentifier
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	self = [super initWithStyle:style
				reuseIdentifier:[[self class] reuseIdentifier]];
    if (self)
	{
        // Initialization code
    }
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

#pragma mark - UITableViewCell Overrides

- (NSString *)reuseIdentifier
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [[self class] reuseIdentifier];
}

#pragma mark - Misc Methods

+ (NSString *)reuseIdentifier
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return NSStringFromClass([self class]);
}

@end
