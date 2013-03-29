//
//  BTIViewController.m
//
//  Created by Brian Slick in Sept 2012
//  Copyright (c) 2012 BriTer Ideas LLC. All rights reserved.
//

#import "BTIViewController.h"

// Models and other global
#import "BTIImport.h"

// Sub-controllers

// Views

// Private Constants

@interface BTIViewController ()

// Private Properties
@property (nonatomic, strong) NSMutableSet *notificationHelpers;

// Notification Handlers

// UI Response Methods

// Misc Methods

@end

@implementation BTIViewController

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods

- (void)dealloc
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	// Clear delegates and other global references
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	// Public Properties
	
	// Private Properties
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)didReceiveMemoryWarning
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSLog(@"***** View Controller Received Memory Warning *****");
    
	[super didReceiveMemoryWarning];
	
	if ([self isViewLoaded])
	{
		if ([[self view] window] == nil)
		{
			[self setView:nil];
		}
	}
		
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Initialization and UI Creation Methods

- (id)init
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	self = [self initWithNibName:nil
						  bundle:nil];
	if (self)
	{
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
			   bundle:(NSBundle *)nibBundleOrNil
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	self = [super initWithNibName:nibNameOrNil
						   bundle:nibBundleOrNil];
	if (self)
	{
		[self populateNotificationHelpers];
		[self registerNotificationsWithLifeSpan:BTINotificationRegistrationLifetime];
	}

	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return self;
}

- (void)awakeFromNib
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	[super awakeFromNib];

	[self populateNotificationHelpers];
	[self registerNotificationsWithLifeSpan:BTINotificationRegistrationLifetime];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Custom Getters and Setters

- (NSMutableSet *)notificationHelpers
{
	if (_notificationHelpers == nil)
	{
		_notificationHelpers = [[NSMutableSet alloc] init];
	}
	return _notificationHelpers;
}

#pragma mark - UIViewController Overrides

- (void)viewWillAppear:(BOOL)animated
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[super viewWillAppear:animated];
	
	[self registerNotificationsWithLifeSpan:BTINotificationRegistrationVisible];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)viewWillDisappear:(BOOL)animated
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[super viewWillDisappear:animated];
	
	[self unregisterNotificationsWithLifeSpan:BTINotificationRegistrationVisible];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Notification Handlers


#pragma mark - UI Response Methods

- (void)populateContents;
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	// Deliberately empty.  Subclasses should override and call super
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Misc Methods

- (void)populateNotificationHelpers
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	// Subclasses should override and call super first
	
	for (BTINotificationHelper *helper in [self notificationHelpers])
	{
		[helper unregister];
	}
	
	[[self notificationHelpers] removeAllObjects];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)addNotificationHelper:(BTINotificationHelper *)helper
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	if (helper != nil)
	{
		[[self notificationHelpers] addObject:helper];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)registerNotificationsWithLifeSpan:(BTINotificationRegistrationLifeSpan)lifeSpan
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	for (BTINotificationHelper *notificationHelper in [self notificationHelpers])
	{
		if ([notificationHelper lifeSpan] == lifeSpan)
		{
			[notificationHelper register];
		}
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)unregisterNotificationsWithLifeSpan:(BTINotificationRegistrationLifeSpan)lifeSpan
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	for (BTINotificationHelper *notificationHelper in [self notificationHelpers])
	{
		if ([notificationHelper lifeSpan] == lifeSpan)
		{
			[notificationHelper unregister];
		}
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
