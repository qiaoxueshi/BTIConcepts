//
//  BTICoreDataViewController.m
//
//  Created by Brian Slick in Feb 2013.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//
// FRC update scheme from
// http://www.fruitstandsoftware.com/blog/2013/02/uitableview-and-nsfetchedresultscontroller-updates-done-right/


#import "BTICoreDataTableViewController.h"

// Models and other global
#import "BTIImport.h"

// Sub-controllers

// Views

// Private Constants

@interface BTICoreDataTableViewController ()

// Private Properties
@property (nonatomic, strong) BTITableContentsManager *searchContentsManager;
@property (nonatomic, strong) NSMutableIndexSet *mainDeletedSectionIndexes;
@property (nonatomic, strong) NSMutableIndexSet *mainInsertedSectionIndexes;
@property (nonatomic, strong) NSMutableArray *mainDeletedRowIndexPaths;
@property (nonatomic, strong) NSMutableArray *mainInsertedRowIndexPaths;
@property (nonatomic, strong) NSMutableArray *mainUpdatedRowIndexPaths;
@property (nonatomic, strong) NSMutableIndexSet *searchDeletedSectionIndexes;
@property (nonatomic, strong) NSMutableIndexSet *searchInsertedSectionIndexes;
@property (nonatomic, strong) NSMutableArray *searchDeletedRowIndexPaths;
@property (nonatomic, strong) NSMutableArray *searchInsertedRowIndexPaths;
@property (nonatomic, strong) NSMutableArray *searchUpdatedRowIndexPaths;


// Notification Handlers

// UI Response Methods

// Misc Methods

@end

@implementation BTICoreDataTableViewController

#pragma mark - Synthesized Properties

// These are needed for instance variables since both getter and setter are manually overriden
@synthesize mainFetchedResultsController = _mainFetchedResultsController;
@synthesize searchFetchedResultsController = _searchFetchedResultsController;

#pragma mark - Dealloc and Memory Methods

- (void)dealloc
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	// Clear delegates and other global references
	[_mainFetchedResultsController setDelegate:nil];
	[_searchFetchedResultsController setDelegate:nil];
	
	// Public Properties
	
	// Private Properties
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Initialization and UI Creation Methods


#pragma mark - Custom Getters and Setters

- (NSFetchedResultsController *)mainFetchedResultsController
{
	if (_mainFetchedResultsController == nil)
	{
		[self loadMainFetchedResultsController];
	}
	
	return _mainFetchedResultsController;
}

- (void)setMainFetchedResultsController:(NSFetchedResultsController *)mainFetchedResultsController
{
	[_mainFetchedResultsController setDelegate:nil];
	
	_mainFetchedResultsController = mainFetchedResultsController;
}

- (NSFetchedResultsController *)searchFetchedResultsController
{
	if (_searchFetchedResultsController == nil)
	{
		[self loadSearchFetchedResultsController];
	}
	
	return _searchFetchedResultsController;
}

- (void)setSearchFetchedResultsController:(NSFetchedResultsController *)searchFetchedResultsController
{
	[_searchFetchedResultsController setDelegate:nil];
	
	_searchFetchedResultsController = searchFetchedResultsController;
}

- (BTITableContentsManager *)searchContentsManager
{
	if (_searchContentsManager == nil)
	{
		_searchContentsManager = [[BTITableContentsManager alloc] init];
	}
	
	return _searchContentsManager;
}

- (NSMutableIndexSet *)mainDeletedSectionIndexes
{
	if (_mainDeletedSectionIndexes == nil)
	{
		_mainDeletedSectionIndexes = [[NSMutableIndexSet alloc] init];
	}
	
	return _mainDeletedSectionIndexes;
}

- (NSMutableIndexSet *)mainInsertedSectionIndexes
{
	if (_mainInsertedSectionIndexes == nil)
	{
		_mainInsertedSectionIndexes = [[NSMutableIndexSet alloc] init];
	}
	
	return _mainInsertedSectionIndexes;
}

- (NSMutableArray *)mainDeletedRowIndexPaths
{
	if (_mainDeletedRowIndexPaths == nil)
	{
		_mainDeletedRowIndexPaths = [[NSMutableArray alloc] init];
	}
	
	return _mainDeletedRowIndexPaths;
}

- (NSMutableArray *)mainInsertedRowIndexPaths
{
	if (_mainInsertedRowIndexPaths == nil)
	{
		_mainInsertedRowIndexPaths = [[NSMutableArray alloc] init];
	}
	
	return _mainInsertedRowIndexPaths;
}

- (NSMutableArray *)mainUpdatedRowIndexPaths
{
	if (_mainUpdatedRowIndexPaths == nil)
	{
		_mainUpdatedRowIndexPaths = [[NSMutableArray alloc] init];
	}
	
	return _mainUpdatedRowIndexPaths;
}

- (NSMutableIndexSet *)searchDeletedSectionIndexes
{
	if (_searchDeletedSectionIndexes == nil)
	{
		_searchDeletedSectionIndexes = [[NSMutableIndexSet alloc] init];
	}
	
	return _searchDeletedSectionIndexes;
}

- (NSMutableIndexSet *)searchInsertedSectionIndexes
{
	if (_searchInsertedSectionIndexes == nil)
	{
		_searchInsertedSectionIndexes = [[NSMutableIndexSet alloc] init];
	}
	
	return _searchInsertedSectionIndexes;
}

- (NSMutableArray *)searchDeletedRowIndexPaths
{
	if (_searchDeletedRowIndexPaths == nil)
	{
		_searchDeletedRowIndexPaths = [[NSMutableArray alloc] init];
	}
	
	return _searchDeletedRowIndexPaths;
}

- (NSMutableArray *)searchInsertedRowIndexPaths
{
	if (_searchInsertedRowIndexPaths == nil)
	{
		_searchInsertedRowIndexPaths = [[NSMutableArray alloc] init];
	}
	
	return _searchInsertedRowIndexPaths;
}

- (NSMutableArray *)searchUpdatedRowIndexPaths
{
	if (_searchUpdatedRowIndexPaths == nil)
	{
		_searchUpdatedRowIndexPaths = [[NSMutableArray alloc] init];
	}
	
	return _searchUpdatedRowIndexPaths;
}

#pragma mark - UIViewController Overrides

- (void)viewWillDisappear:(BOOL)animated
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[super viewWillDisappear:animated];
	
	// Instance variable used deliberately to prevent lazy-loading.
	[_mainFetchedResultsController setDelegate:nil];
	[_searchFetchedResultsController setDelegate:nil];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)viewDidDisappear:(BOOL)animated
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[super viewDidDisappear:animated];
	
	[self setMainFetchedResultsController:nil];
	[self setSearchFetchedResultsController:nil];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

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
		object = [[self mainFetchedResultsController] objectAtIndexPath:indexPath];
	}
	else if (tableView == [[self searchDisplayController] searchResultsTableView])
	{
		// Search contents
		if ([self isSearchResultsViaFetch])
		{
			object = [[self searchFetchedResultsController] objectAtIndexPath:indexPath];
		}
		else
		{
			object = [[self searchContentsManager] representedObjectAtIndexPath:indexPath];
		}
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return object;
}

#pragma mark - Notification Handlers


#pragma mark - UI Response Methods


#pragma mark - Misc Methods

- (void)loadMainFetchedResultsController
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	// Subclasses should override, do not need to call super
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)loadSearchFetchedResultsController
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	// Subclasses should override, do not need to call super
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSInteger sections = 0;
	
	if (tableView == [self tableView])
	{
		// Main contents
		sections = [[[self mainFetchedResultsController] sections] count];
	}
	else if (tableView == [[self searchDisplayController] searchResultsTableView])
	{
		// Search contents
		if ([self isSearchResultsViaFetch])
		{
			sections = [[[self searchFetchedResultsController] sections] count];
		}
		else
		{
			sections = [[self searchContentsManager] numberOfSections];
		}
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return sections;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	id <NSFetchedResultsSectionInfo> sectionInfo = nil;
	
	if (tableView == [self tableView])
	{
		sectionInfo = [[[self mainFetchedResultsController] sections] objectAtIndex:section];
	}
	else
	{
		// Search contents
		if ([self isSearchResultsViaFetch])
		{
			sectionInfo = [[[self searchFetchedResultsController] sections] objectAtIndex:section];
		}
		else
		{
			sectionInfo = [[self searchContentsManager] sectionInfoAtIndex:section];
		}
	}
	
	NSInteger rows = [sectionInfo numberOfObjects];

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


#pragma mark - NSFetchedResultsControllerDelegate Methods

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	NSInteger section = [indexPath section];
	NSInteger newSection = [newIndexPath section];
	
	if (controller == [self mainFetchedResultsController])
	{
		if (type == NSFetchedResultsChangeInsert)
		{			
			if ([[self mainInsertedSectionIndexes] containsIndex:newSection])
			{
				// If we've already been told that we're adding a section for this inserted row we skip it since it will handled by the section insertion.
				return;
			}
			
			[[self mainInsertedRowIndexPaths] addObject:newIndexPath];
		}
		else if (type == NSFetchedResultsChangeDelete)
		{
			if ([[self mainDeletedSectionIndexes] containsIndex:section])
			{
				// If we've already been told that we're deleting a section for this deleted row we skip it since it will handled by the section deletion.
				return;
			}
			
			[[self mainDeletedRowIndexPaths] addObject:indexPath];
		}
		else if (type == NSFetchedResultsChangeMove)
		{
			if ([[self mainInsertedSectionIndexes] containsIndex:newSection] == NO)
			{
				[[self mainInsertedRowIndexPaths] addObject:newIndexPath];
			}

			if ([[self mainDeletedSectionIndexes] containsIndex:indexPath.section] == NO)
			{
				[[self mainDeletedRowIndexPaths] addObject:indexPath];
			}
		}
		else if (type == NSFetchedResultsChangeUpdate)
		{
			[[self mainUpdatedRowIndexPaths] addObject:indexPath];
		}
	}
	else
	{
		if (type == NSFetchedResultsChangeInsert)
		{
			if ([[self searchInsertedSectionIndexes] containsIndex:newSection])
			{
				// If we've already been told that we're adding a section for this inserted row we skip it since it will handled by the section insertion.
				return;
			}
			
			[[self searchInsertedRowIndexPaths] addObject:newIndexPath];
		}
		else if (type == NSFetchedResultsChangeDelete)
		{
			if ([[self searchDeletedSectionIndexes] containsIndex:section])
			{
				// If we've already been told that we're deleting a section for this deleted row we skip it since it will handled by the section deletion.
				return;
			}
			
			[[self searchDeletedRowIndexPaths] addObject:indexPath];
		}
		else if (type == NSFetchedResultsChangeMove)
		{
			if ([[self searchInsertedSectionIndexes] containsIndex:newSection] == NO)
			{
				[[self searchInsertedRowIndexPaths] addObject:newIndexPath];
			}
			
			if ([[self searchDeletedSectionIndexes] containsIndex:indexPath.section] == NO)
			{
				[[self searchDeletedRowIndexPaths] addObject:indexPath];
			}
		}
		else if (type == NSFetchedResultsChangeUpdate)
		{
			[[self searchUpdatedRowIndexPaths] addObject:indexPath];
		}
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id )sectionInfo
		   atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	if (controller == [self mainFetchedResultsController])
	{
		if (type == NSFetchedResultsChangeInsert)
		{
			[[self mainInsertedSectionIndexes] addIndex:sectionIndex];
		}
		else if (type == NSFetchedResultsChangeDelete)
		{
			[[self mainDeletedSectionIndexes] addIndex:sectionIndex];
		}
	}
	else
	{
		if (type == NSFetchedResultsChangeInsert)
		{
			[[self searchInsertedSectionIndexes] addIndex:sectionIndex];
		}
		else if (type == NSFetchedResultsChangeDelete)
		{
			[[self searchDeletedSectionIndexes] addIndex:sectionIndex];
		}
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	if (controller == [self mainFetchedResultsController])
	{
		UITableView *tableView = [self tableView];

		NSInteger totalChanges = [[self mainDeletedSectionIndexes] count] + [[self mainInsertedSectionIndexes] count] + [[self mainDeletedRowIndexPaths] count] + [[self mainInsertedRowIndexPaths] count] + [[self mainUpdatedRowIndexPaths] count];
		
		if (totalChanges > 50)
		{
			[self setMainInsertedSectionIndexes:nil];
			[self setMainDeletedSectionIndexes:nil];
			[self setMainDeletedRowIndexPaths:nil];
			[self setMainInsertedRowIndexPaths:nil];
			[self setMainUpdatedRowIndexPaths:nil];
			
			[tableView reloadData];
			
			//BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Bulk changes", self, __PRETTY_FUNCTION__);
			return;
		}
		
		[tableView beginUpdates];
		
		[tableView deleteSections:[self mainDeletedSectionIndexes] withRowAnimation:UITableViewRowAnimationAutomatic];
		[tableView insertSections:[self mainInsertedSectionIndexes] withRowAnimation:UITableViewRowAnimationAutomatic];
		
		[tableView deleteRowsAtIndexPaths:[self mainDeletedRowIndexPaths] withRowAnimation:UITableViewRowAnimationLeft];
		[tableView insertRowsAtIndexPaths:[self mainInsertedRowIndexPaths] withRowAnimation:UITableViewRowAnimationRight];
		[tableView reloadRowsAtIndexPaths:[self mainUpdatedRowIndexPaths] withRowAnimation:UITableViewRowAnimationAutomatic];
		
		[tableView endUpdates];

		[self setMainInsertedSectionIndexes:nil];
		[self setMainDeletedSectionIndexes:nil];
		[self setMainDeletedRowIndexPaths:nil];
		[self setMainInsertedRowIndexPaths:nil];
		[self setMainUpdatedRowIndexPaths:nil];
	}
	else
	{
		UITableView *tableView = [[self searchDisplayController] searchResultsTableView];
		
		NSInteger totalChanges = [[self searchDeletedSectionIndexes] count] + [[self searchInsertedSectionIndexes] count] + [[self searchDeletedRowIndexPaths] count] + [[self searchInsertedRowIndexPaths] count] + [[self searchUpdatedRowIndexPaths] count];
		
		if (totalChanges > 50)
		{
			[self setSearchInsertedSectionIndexes:nil];
			[self setSearchDeletedSectionIndexes:nil];
			[self setSearchDeletedRowIndexPaths:nil];
			[self setSearchInsertedRowIndexPaths:nil];
			[self setSearchUpdatedRowIndexPaths:nil];
			
			[tableView reloadData];
			
			//BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Bulk changes", self, __PRETTY_FUNCTION__);
			return;
		}
		
		[tableView beginUpdates];
		
		[tableView deleteSections:[self searchDeletedSectionIndexes] withRowAnimation:UITableViewRowAnimationAutomatic];
		[tableView insertSections:[self searchInsertedSectionIndexes] withRowAnimation:UITableViewRowAnimationAutomatic];
		
		[tableView deleteRowsAtIndexPaths:[self searchDeletedRowIndexPaths] withRowAnimation:UITableViewRowAnimationLeft];
		[tableView insertRowsAtIndexPaths:[self searchInsertedRowIndexPaths] withRowAnimation:UITableViewRowAnimationRight];
		[tableView reloadRowsAtIndexPaths:[self searchUpdatedRowIndexPaths] withRowAnimation:UITableViewRowAnimationAutomatic];
		
		[tableView endUpdates];
		
		[self setSearchInsertedSectionIndexes:nil];
		[self setSearchDeletedSectionIndexes:nil];
		[self setSearchDeletedRowIndexPaths:nil];
		[self setSearchInsertedRowIndexPaths:nil];
		[self setSearchUpdatedRowIndexPaths:nil];
	}

	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}


@end
