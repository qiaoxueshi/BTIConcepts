//
//  SampleAdvancedTableViewController.m
//  DemoProject
//
//  Created by Brian Slick on 3/28/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "SampleAdvancedTableViewController.h"

// Models and other global

// Sub-controllers

// Views

// Private Constants

@interface SampleAdvancedTableViewController ()

// Private Properties

// Notification Handlers
- (void)doSomethingForVisibleNotification:(NSNotification *)notification;
- (void)doSomethingForLifetimeNotification:(NSNotification *)notification;

// UI Response Methods

// Misc Methods

@end

@implementation SampleAdvancedTableViewController

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
		[self setTitle:@"Advanced Table"];
		[[self tabBarItem] setImage:[UIImage imageNamed:@"first"]];
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
	
	// It looks busy, but at least everything is right here.  Otherwise this content would be spread over several methods.  The concept avoids a whole mess of if/else statements in cellForRow, and titleForHeader, and titleForFooter, and didSelectRow, and...
	// This is a contrived example, but the intention is that each block could do something considerably different.  Some could push on a navigation controller, some could present modally, etc.
	
	BTITableContentsManager *manager = [self mainContentsManager];
	[manager reset];
	
	BTITableSectionInfo *sectionInfo = nil;
	BTITableRowInfo *rowInfo = nil;
	
	{{
		sectionInfo = [manager dequeueReusableSectionInfoAndAddToContents];
		[sectionInfo setHeaderTitle:@"GO!"];
		[sectionInfo setFooterTitle:@"They've gone to plaid!"];
		
		rowInfo = [manager dequeReusableRowInfo];
		[manager addRowInfo:rowInfo makeNewSection:NO];
		
		[rowInfo setText:@"Light"];
		[rowInfo setDetailText:@"1, 2, 3, 4, 5"];
		[rowInfo setRowSelectionBlock:^{
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
															message:@"I've got the same combination on my luggage!"
														   delegate:nil
												  cancelButtonTitle:@"That's amazing!"
												  otherButtonTitles:nil];
			[alert show];
			
		}];
		
		rowInfo = [manager dequeReusableRowInfo];
		[manager addRowInfo:rowInfo makeNewSection:NO];
		
		[rowInfo setText:@"Ridiculous"];
		[rowInfo setDetailText:@"That's just what we needed: a Druish princess"];
		[rowInfo setRowSelectionBlock:^{
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
															message:@"Funny. She doesn't look Druish."
														   delegate:nil
												  cancelButtonTitle:@"Try to save the car..."
												  otherButtonTitles:nil];
			[alert show];
			
		}];
		
		rowInfo = [manager dequeReusableRowInfo];
		[manager addRowInfo:rowInfo makeNewSection:NO];
		
		[rowInfo setText:@"Ludicrous"];
		[rowInfo setDetailText:@"Ah, buckle this"];
		[rowInfo setRowSelectionBlock:^{
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
															message:@"My brains are going into my feet!"
														   delegate:nil
												  cancelButtonTitle:@"What have I done?!"
												  otherButtonTitles:nil];
			[alert show];
			
		}];

	}}
	
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

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [[self mainContentsManager] headerTitleInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView
titleForFooterInSection:(NSInteger)section
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [[self mainContentsManager] footerTitleInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	// Build Cell
	
	static NSString *blankCellIdentifier = @"blankCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:blankCellIdentifier];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:blankCellIdentifier];
	}
	
	// Acquire Data
	
	BTITableRowInfo *rowInfo = [[self mainContentsManager] rowInfoAtIndexPath:indexPath];
	
	// Populate Cell
	
	[[cell textLabel] setText:[rowInfo text]];
	[[cell detailTextLabel] setText:[rowInfo detailText]];
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	BTITableRowInfo *rowInfo = [[self mainContentsManager] rowInfoAtIndexPath:indexPath];

	if ([rowInfo rowSelectionBlock] != nil)
	{
		[rowInfo rowSelectionBlock]();
	}
	
	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
