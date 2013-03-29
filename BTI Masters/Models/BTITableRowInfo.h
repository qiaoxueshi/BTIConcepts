//
//  BTITableRowInfo.h
//
//  Created by Brian Slick in Sept 2012
//  Copyright (c) 2012 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 The intention of this class is to reduce the amount of if/else, if/else statements that often go along with manually-driven table views.  Some if/else statements in cellForRow, more if/else statements in didSelectRow, maybe even more for setting a section header, etc.  Instead of spreading all of that information out across numerous methods, this class can be used to encapsulate a considerable amount of definition in one spot.  A single BTIRowInfo object can contain textLabel and detailTextLabel contents, as well as blocks for handling row selection or row accessory selection.  This can easily be expanded to include image paths and accessory definitions; basically all of the UITableViewCell properties that might be interesting.
 
 This class can be used standalone, but it draws inspiration from NSTreeNode and provides a representedObject property allowing it to be used with any other model objects.
 
 */

// Libraries
#import <Foundation/Foundation.h>

// Classes and Forward Declarations
#import "BTIObject.h"
@class BTITableSectionInfo;
typedef void(^BTIRowSelectionBlock)(void);

// Public Constants

// Protocols

@interface BTITableRowInfo : BTIObject
{
}

#pragma mark - Properties
@property (nonatomic, strong) id representedObject;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *UUIDString;
@property (nonatomic, weak) BTITableSectionInfo *parentSectionInfo;

#pragma mark - Table Cell Support
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *detailText;
@property (nonatomic, copy) BTIRowSelectionBlock rowSelectionBlock;
@property (nonatomic, copy) BTIRowSelectionBlock rowAccessorySelectionBlock;

#pragma mark - Misc Methods

/*
 Clears all properties
 */
- (void)reset;

@end
