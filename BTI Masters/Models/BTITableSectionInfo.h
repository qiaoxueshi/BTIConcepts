//
//  BTITableSectionInfo.h
//
//  Created by Brian Slick in Sept 2012
//  Copyright (c) 2012 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 The intention of this class is to make multi-section manually-driven table views easier.  It is modeled after NSFetchedResultsSectionInfo, and conforms to that protocol so that it can be used manually in conjunction with a NSFetchedResultsController in limited cases.
 
 The goal is to encapsulate all useful information about a section - ex: header, footer - here in a single object, rather than having multiple if/else statements spread out across multiple delegate methods.  This information can instead be defined in one place, and referenced later as needed.
 
 */

// Libraries

// Classes and Forward Declarations
#import "BTIObject.h"

// Public Constants

// Protocols

@interface BTITableSectionInfo : BTIObject <NSFetchedResultsSectionInfo, NSFastEnumeration>
{
}

#pragma mark - NSFetchedResultsSectionInfo Protocol Properties

@property (weak, nonatomic, readonly) NSString *name;
@property (weak, nonatomic, readonly) NSString *indexTitle;
@property (nonatomic, readonly) NSUInteger numberOfObjects;
@property (weak, nonatomic, readonly) NSArray *objects;

#pragma mark - Custom Properties

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *UUIDString;
@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;
@property (nonatomic, copy) NSString *sectionIndexTitle;
@property (nonatomic, strong) id representedObject;

#pragma mark - Misc Methods

/*
 Clears all properties
 */
- (void)reset;

#pragma mark - Content Methods

- (void)addObjectToContents:(id)newObject;
- (void)addObjectsToContents:(NSSet *)newObjects;
- (void)insertObjectInContents:(id)newObject
					   atIndex:(NSUInteger)index;
- (void)removeObjectFromContents:(id)oldObject;
- (void)moveObjectInContentsFromIndex:(NSUInteger)fromIndex
							  toIndex:(NSUInteger)toIndex;
- (void)removeAllObjectsInContents;
- (NSUInteger)countOfContents;
- (NSUInteger)indexOfObjectInContents:(id)object;
- (NSEnumerator *)contentsEnumerator;
- (id)objectInContentsAtIndex:(NSUInteger)index;
- (BOOL)contentsContainsObject:(id)anObject;
- (void)sortContentsUsingDescriptors:(NSArray *)descriptors;

@end
