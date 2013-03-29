//
//  BTITableViewController.h
//
//  Created by Brian Slick in Feb 2013.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 This is a view controller class intended to provide common elements needed to support a table view.  It does not, however, provide a primary data storage mechanism, leaving that to subclasses to define.  It can be viewed as an alternative to UITableViewController, though it does not deliberately attempt to replicate any functionality of that class.
 
 This class is intended to be used with a XIB file containing a UITableView, however if the IBOutlet has not been populated by the time viewWillAppear is called, a full-screen, plain table view will be created.
 
 This class implements the minimum setup necessary to support a UISearchDisplayController.  Subclasses must override the handleSearchForTerm: method in order to implement the actual search logic that this class does not provide.
 
 The selectionSet is provided to handle cases where multiple selections (ex: checkmarks) would be useful, and the selectedObject is for single selection.  This class does not implement any logic utilizing these properties, merely makes them available.
 
 To unify table view datasource/delegate methods, the itemInTableView:atIndexPath: method is provided.  This class does not implement any particular logic.  Subclasses should override this method to select an appropriate object depending on which table view is asking.
 
 */

// Libraries

// Forward Declarations and Classes
#import "BTIViewController.h"

// Public Constants

// Protocols

@interface BTITableViewController : BTIViewController <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate>
{
}

#pragma mark - IBOutlet Properties
@property (nonatomic, strong) IBOutlet UITableView *tableView;


#pragma mark - Other Public Properties
@property (nonatomic, strong, readonly) NSMutableSet *selectionSet;
@property (nonatomic, strong) id selectedObject;
@property (nonatomic, copy) NSString *savedSearchTerm;

#pragma mark - IBActions


#pragma mark - Other Public Methods

/*
 This method is automatically called by searchDisplayController:shouldReloadTableForSearchString:.  Subclasses should override this method to provide the actual search logic, and call super.
 */
- (void)handleSearchForTerm:(NSString *)searchTerm;

/*
 This is a generic method to provide an object within table view datasource/delegate methods.  The standard implementation does nothing, as there is no data structure here.  Subclasses should override this method and return an appropriate object.  No need to call super.
 */
- (id)itemInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;	

@end
