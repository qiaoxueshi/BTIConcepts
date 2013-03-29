//
//  SampleBasicTableViewController.m
//  DemoProject
//
//  Created by Brian Slick on 3/28/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "SampleBasicTableViewController.h"

// Models and other global

// Sub-controllers

// Views

// Private Constants

@interface SampleBasicTableViewController ()

// Private Properties

// Notification Handlers
- (void)doSomethingForVisibleNotification:(NSNotification *)notification;
- (void)doSomethingForLifetimeNotification:(NSNotification *)notification;

// UI Response Methods

// Misc Methods

@end

@implementation SampleBasicTableViewController

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods


#pragma mark - Initialization and UI Creation Methods

- (id)initWithNibName:(NSString *)nibNameOrNil
			   bundle:(NSBundle *)nibBundleOrNil
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
    self = [super initWithNibName:nibNameOrNil
						   bundle:nibBundleOrNil];
    if (self)
	{
		[self setTitle:@"Simple Table"];
		[[self tabBarItem] setImage:[UIImage imageNamed:@"second"]];
    }
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

#pragma mark - Custom Getters and Setters


#pragma mark - UIViewController Overrides

- (void)viewWillAppear:(BOOL)animated
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[super viewWillAppear:animated];
	
	[self populateContents];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTIViewController Overrides

- (void)populateContents
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	NSMutableArray *contents = [self mainContents];
	
	[contents removeAllObjects];
	
	[contents addObject:@"Red"];
	[contents addObject:@"Orange"];
	[contents addObject:@"Yellow"];
	[contents addObject:@"Green"];
	[contents addObject:@"Blue"];
	[contents addObject:@"Indigo"];
	[contents addObject:@"Violet"];

	[[self tableView] reloadData];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)populateNotificationHelpers
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	BTINotificationHelper *helper = nil;
	
	// Lifetime Notifications
	
	helper = [BTINotificationHelper notificationHelperWithObserver:self
														  selector:@selector(doSomethingForLifetimeNotification:)
															  name:kLifetimeNotification
															object:nil
														  lifeSpan:BTINotificationRegistrationLifetime];
	[self addNotificationHelper:helper];
	
	// Visible Notifications
	
	helper = [BTINotificationHelper notificationHelperWithObserver:self
														  selector:@selector(doSomethingForVisibleNotification:)
															  name:kVisibleNotification
															object:nil
														  lifeSpan:BTINotificationRegistrationVisible];
	[self addNotificationHelper:helper];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Notification Handlers

- (void)doSomethingForVisibleNotification:(NSNotification *)notification
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSArray *viewControllers = [[self tabBarController] viewControllers];
	NSInteger index = [viewControllers indexOfObject:self];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Tab at index %d\n", index]
													message:@"Received *visible* notification"
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)doSomethingForLifetimeNotification:(NSNotification *)notification
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSArray *viewControllers = [[self tabBarController] viewControllers];
	NSInteger index = [viewControllers indexOfObject:self];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Tab at index %d\n", index]
													message:@"Received *lifetime* notification"
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - UI Response Methods

- (IBAction)visibleButtonPressed:(UIButton *)button
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	// It would be on the main thread anyway, but I need a reason to use this...
	[[NSNotificationCenter defaultCenter] postNotificationNameOnMainThreadBTI:kVisibleNotification];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (IBAction)lifetimeButtonPressed:(UIButton *)button
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	// It would be on the main thread anyway, but I need a reason to use this...
	[[NSNotificationCenter defaultCenter] postNotificationNameOnMainThreadBTI:kLifetimeNotification];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Misc Methods


#pragma mark - UITableViewDataSource Methods

// Superclass handles basic cases.  Override normal methods for customization.

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
