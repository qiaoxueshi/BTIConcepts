//
//  BTITableContentsManager.h
//
//  Created by Brian Slick in Nov 2012
//  Copyright (c) 2012 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 The spirit of this class is to be a non-Core Data equivalent of a NSFetchedResultsController.  Currently the primary benefit of this class is to simplify UITableViewDataSource and UITableViewDelegate methods, in a similar way that NSFRC does, providing objectAtIndePath: style methods.
 
 This class utilizes the companion classes BTITableSectionInfo and BTITableRowInfo.  BTITableSectionInfo is analogous to NSFetchedResultsSectionInfo, and BTITableRowInfo is analogous to NSTreeNode (OS X).  The intention is to populate the 'sections' array with section info objects, which are in turn populated with row info objects.  Once populated, this class provides utility methods for retrieving information for handy use with table views.
 
 This class has not yet reached the goal of emulating NSFRC.  There is currently no means of providing a pool of objects or a sort descriptor that then automatically sorts the pool of objects.  And there is no delegate, so changes to the table view still have to be handled manually.  These are wishlist capabilities for future development.
 
 */

// Libraries
#import <Foundation/Foundation.h>

// Classes and Forward Declarations
#import "BTIObject.h"
@class BTITableSectionInfo;
@class BTITableRowInfo;

// Public Constants

// Protocols

@interface BTITableContentsManager : BTIObject <NSFastEnumeration>
{
}

#pragma mark - Properties

@property (nonatomic, strong, readonly) NSMutableArray *sections;

#pragma mark - Primary Management Methods

/*
 Empties the sections array.  BTITableSectionInfo and BTITableRowInfo objects are moved to a cache.
 */
- (void)reset;

#pragma mark - BTITableSectionInfo Methods

/*
 Requests a BTITableSectionInfo object from the local cache, creating one if necessary.  This object is NOT added to the sections array.
 */
- (BTITableSectionInfo *)dequeueReusableSectionInfo;

/*
 Requests a BTITableSectionInfo object from the local cache, creating one if necessary.  This object is added to the sections array.
 */
- (BTITableSectionInfo *)dequeueReusableSectionInfoAndAddToContents;

/*
 Adds a BTITableSectionInfo to the sections array.
 */
- (void)addSectionInfo:(BTITableSectionInfo *)sectionInfo;

#pragma mark - BTITableRowInfoMethods

/*
 Requests a BTITableRowInfo object from the local cache, creating one if necessary.  This object is NOT added to any sections.
 */
- (BTITableRowInfo *)dequeReusableRowInfo;

/*
 Adds a BTITableRowInfo object to a BTITableSectionInfo object.  If makeNewSelection is NO, the row info will be added to the last section info in the array.  If no section infos are already in the array, a new one will be added, and this row info will be added to it.  If makeNewSelection is YES, a new section info object will be added to the array, and this row info will be added to it.
 */
- (void)addRowInfo:(BTITableRowInfo *)rowInfo makeNewSection:(BOOL)isNewSection;		// If NO, add to last section.  If YES, make new section.

#pragma mark - UITableView Support Methods

/*
 Returns the number of sections.
 */
- (NSInteger)numberOfSections;

/*
 Returns the 'headerTitle' value of the BTITableSectionInfo object at the specified index
 */
- (NSString *)headerTitleInSection:(NSInteger)section;

/*
 Returns the 'footerTitle' value of the BTITableSectionInfo object at the specified index
 */
- (NSString *)footerTitleInSection:(NSInteger)section;

/*
 Returns the number of rows in the section at the specified index
 */
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

#pragma mark - Content Retrieval Methods

/*
 Returns the BTITableSectionInfo object at the specified index
 */
- (BTITableSectionInfo *)sectionInfoAtIndex:(NSInteger)index;

/*
 Returns the BTITableSectionInfo's represented object at the specified index
 */
- (id)representedObjectAtSectionIndex:(NSInteger)index;

/*
 Returns the BTITableRowInfo object at the specified index
 */
- (BTITableRowInfo *)rowInfoAtIndexPath:(NSIndexPath *)indexPath;

/*
 Returns the BTITableRowInfo's represented object at the specified index
 */
- (id)representedObjectAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Interrogation Methods

/*
 Returns the index of the section info object
 */
- (NSInteger)indexOfSectionInfo:(BTITableSectionInfo *)sectionInfo;

/*
 Returns the index of the section info object's represented object
 */
- (NSInteger)indexOfRepresentedSectionObject:(id)representedObject;

/*
 Returns the index of the section info object's identifier
 */
- (NSInteger)indexOfSectionIdentifier:(NSString *)identifier;

/*
 Returns the index path of the row info object
 */
- (NSIndexPath *)indexPathOfRowInfo:(BTITableRowInfo *)rowInfo;

/*
 Returns the index path of the row info object's represented object
 */
- (NSIndexPath *)indexPathOfRepresentedRowObject:(id)representedObject;

/*
 Returns the index path of the row info object's identifier
 */
- (NSIndexPath *)indexPathOfRowIdentifier:(NSString *)identifier;

/*
 Returns an index set describing all section indexes.  This can be used before and after any content changes to help determine what changed.
 */
- (NSIndexSet *)allSectionIndexes;

/*
 Returns an array containing all row index paths.  This can be used before and after any content changes to help determine what changed.
 */
- (NSArray *)allIndexPaths;

@end
