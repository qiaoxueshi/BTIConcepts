//
//  BTICoreDataViewController.h
//
//  Created by Brian Slick in Feb 2013.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 This is a specific implementation of BTITableViewController that utilizes a NSFetchedResultsController.  itemInTableView:atIndexPath: has been overridden accordingly.
 
 This class offers two options for search results, either a FRC or a BTITableContentsManager.  Subclasses should define which to use by setting a value for the searchResultsViaFetch boolean.  YES will use the FRC.
 
 Subclasses should define the FRC(s) in the appropriate load(*)FetchedResultsController method, and set the corresponding property.  These methods will be called anytime that the property is accessed but is nil.
 
 The managedObjectContext is provided for convenience, and should be populated by subclasses.  It is not automatically populated.
 
 */

// Libraries
#import <CoreData/CoreData.h>

// Forward Declarations and Classes
#import "BTITableViewController.h"
@class BTITableContentsManager;

// Public Constants

// Protocols

@interface BTICoreDataTableViewController : BTITableViewController <NSFetchedResultsControllerDelegate>
{
}

#pragma mark - IBOutlet Properties


#pragma mark - Other Public Properties
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *mainFetchedResultsController;
@property (nonatomic, strong) NSFetchedResultsController *searchFetchedResultsController;
@property (nonatomic, strong, readonly) BTITableContentsManager *searchContentsManager;
@property (nonatomic, assign, getter = isSearchResultsViaFetch) BOOL searchResultsViaFetch;		// Default is NO. Subclasses should define

#pragma mark - IBActions


#pragma mark - Other Public Methods

/*
 This method is used to define the FRC for the main table view.  The default implementation does nothing.  Subclasses should override this method, create a FRC, and supply it to the mainFetchedResultsController property.  There is no need to call super.
 */
- (void)loadMainFetchedResultsController;

/*
 This method is used to define the FRC for the search table view.  The default implementation does nothing.  Subclasses should override this method, create a FRC, and supply it to the searchFetchedResultsController property.  There is no need to call super.
 */
- (void)loadSearchFetchedResultsController;

@end
