//
//  BTIManagerTableViewController.m
//
//  Created by Brian Slick in Feb 2013.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "BTIManagerTableViewController.h"

// Models and other global
#import "BTIImport.h"

// Sub-controllers

// Views

// Private Constants

@interface BTIManagerTableViewController ()

// Private Properties
@property (nonatomic, strong) BTITableContentsManager *mainContentsManager;
@property (nonatomic, strong) BTITableContentsManager *searchContentsManager;

// Notification Handlers

// UI Response Methods

// Misc Methods

@end

@implementation BTIManagerTableViewController

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods


#pragma mark - Initialization and UI Creation Methods


#pragma mark - Custom Getters and Setters

- (BTITableContentsManager *)mainContentsManager
{
	if (_mainContentsManager == nil)
	{
		_mainContentsManager = [[BTITableContentsManager alloc] init];
	}
	
	return _mainContentsManager;
}

- (BTITableContentsManager *)searchContentsManager
{
	if (_searchContentsManager == nil)
	{
		_searchContentsManager = [[BTITableContentsManager alloc] init];
	}
	
	return _searchContentsManager;
}

#pragma mark - UIViewController Overrides


#pragma mark - BTIViewController Overrides


#pragma mark - BTITableViewController Overrides

- (id)itemInTableView:(UITableView *)tableView
		  atIndexPath:(NSIndexPath *)indexPath
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
		
	id object = nil;
	
	if (tableView == [self tableView])
	{
		// Main contents
		object = [[self mainContentsManager] representedObjectAtIndexPath:indexPath];
	}
	else if (tableView == [[self searchDisplayController] searchResultsTableView])
	{
		// Search contents
		object = [[self searchContentsManager] representedObjectAtIndexPath:indexPath];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return object;
}

#pragma mark - Notification Handlers


#pragma mark - UI Response Methods


#pragma mark - Misc Methods


#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSInteger sections = 0;
	
	if (tableView == [self tableView])
	{
		// Main contents
		sections = [[self mainContentsManager] numberOfSections];
	}
	else if (tableView == [[self searchDisplayController] searchResultsTableView])
	{
		// Search contents
		sections = [[self searchContentsManager] numberOfSections];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return sections;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSInteger rows = 0;
	
	if (tableView == [self tableView])
	{
		rows = [[self mainContentsManager] numberOfRowsInSection:section];
	}
	else
	{
		rows = [[self searchContentsManager] numberOfRowsInSection:section];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	// Build Cell
	
	static NSString *blankCellIdentifier = @"blankCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:blankCellIdentifier];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:blankCellIdentifier];
	}
	
	// Acquire Data
	
	id rowObject = [self itemInTableView:tableView atIndexPath:indexPath];
	
	// Populate Cell
	
	[[cell textLabel] setText:[rowObject description]];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return cell;
}

#pragma mark - UITableViewDelegate Methods



#pragma mark - UISearchDisplayDelegate Methods

@end
