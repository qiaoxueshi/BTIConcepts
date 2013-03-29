//
//  BTITableContentsManager.m
//
//  Created by Brian Slick in Nov 2012
//  Copyright (c) 2012 BriTer Ideas LLC. All rights reserved.
//

#import "BTITableContentsManager.h"

#import "BTIImport.h"

// Models and other global
#import "BTITableSectionInfo.h"
#import "BTITableRowInfo.h"

// Private Constants

@interface BTITableContentsManager ()

// Private Properties
@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, strong) NSMutableSet *sectionInfoCache;
@property (nonatomic, strong) NSMutableSet *rowInfoCache;

// Notification Handlers
- (void)didReceiveMemoryWarning:(NSNotification *)notification;

// Misc Methods
- (void)enqueueSectionInfo:(BTITableSectionInfo *)sectionInfo;
- (void)enqueueRowInfo:(BTITableRowInfo *)rowInfo;

@end

@implementation BTITableContentsManager

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods

- (void)dealloc
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	// Clear delegates and other global references
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Initialization

- (id)init
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	self = [super init];
	if (self)
	{
		NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		
		[notificationCenter addObserver:self
							   selector:@selector(didReceiveMemoryWarning:)
								   name:UIApplicationDidReceiveMemoryWarningNotification
								 object:nil];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return self;
}

#pragma mark - Custom Getters and Setters

- (NSMutableArray *)sections
{
	if (_sections == nil)
	{
		_sections = [[NSMutableArray alloc] init];
	}
	return _sections;
}

- (NSMutableSet *)sectionInfoCache
{
	if (_sectionInfoCache == nil)
	{
		_sectionInfoCache = [[NSMutableSet alloc] init];
	}
	return _sectionInfoCache;
}

- (NSMutableSet *)rowInfoCache;
{
	if (_rowInfoCache == nil)
	{
		_rowInfoCache = [[NSMutableSet alloc] init];
	}
	return _rowInfoCache;
}

#pragma mark - Notification Handlers

- (void)didReceiveMemoryWarning:(NSNotification *)notification
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[[self sectionInfoCache] removeAllObjects];
	[[self rowInfoCache] removeAllObjects];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Primary Control Methods

- (void)reset
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSArray *sectionInfos = [NSArray arrayWithArray:[self sections]];
	
	for (BTITableSectionInfo *sectionInfo in sectionInfos)
	{
		[self enqueueSectionInfo:sectionInfo];
	}
	
	[[self sections] removeAllObjects];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTITableSectionInfo Methods

- (BTITableSectionInfo *)dequeueReusableSectionInfo
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSMutableSet *cache = [self sectionInfoCache];
	
	BTITableSectionInfo *sectionInfo = [cache anyObject];
	if (sectionInfo == nil)
	{
		//NSLog(@"New");
		sectionInfo = [[BTITableSectionInfo alloc] init];
	}
	else
	{
		//NSLog(@"Reused");
		[cache removeObject:sectionInfo];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return sectionInfo;
}

- (BTITableSectionInfo *)dequeueReusableSectionInfoAndAddToContents
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	BTITableSectionInfo *sectionInfo = [self dequeueReusableSectionInfo];
	
	[self addSectionInfo:sectionInfo];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return sectionInfo;
}

- (void)addSectionInfo:(BTITableSectionInfo *)sectionInfo
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	if (sectionInfo == nil)
	{
		//BTITrackingLog(@"<<< Leaving %s >>> EARLY - No Section provided", __PRETTY_FUNCTION__);
		return;
	}
	
	[[self sections] addObject:sectionInfo];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)enqueueSectionInfo:(BTITableSectionInfo *)sectionInfo
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	if (sectionInfo == nil)
	{
		//BTITrackingLog(@"<<< Leaving %s >>> EARLY - No Section provided", __PRETTY_FUNCTION__);
		return;
	}
	
	if (![sectionInfo isKindOfClass:[BTITableSectionInfo class]])
	{
		//BTITrackingLog(@"<<< Leaving %s >>> EARLY - Not a BTITableSectionInfo object", __PRETTY_FUNCTION__);
		return;
	}
	
	// Add to cache
	[[self sectionInfoCache] addObject:sectionInfo];
	
	// Capture the contents.  RowInfos need to be cached
	NSArray *rowInfos = [NSArray arrayWithArray:[sectionInfo objects]];
	
	// Reset the sectionInfo
	[sectionInfo reset];
	
	id anObject = [rowInfos firstObjectBTI];
	if (![anObject isKindOfClass:[BTITableRowInfo class]])
	{
		//BTITrackingLog(@"<<< Leaving %s >>> EARLY - Section contents are not row infos", __PRETTY_FUNCTION__);
		return;
	}
	
	// Cache RowInfo
	for (BTITableRowInfo *rowInfo in rowInfos)
	{
		[self enqueueRowInfo:rowInfo];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTITableRowInfoMethods

- (BTITableRowInfo *)dequeReusableRowInfo
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSMutableSet *cache = [self rowInfoCache];
	
	BTITableRowInfo *rowInfo = [cache anyObject];
	if (rowInfo == nil)
	{
		//NSLog(@"New");
		rowInfo = [[BTITableRowInfo alloc] init];
	}
	else
	{
		//NSLog(@"Reused");
		[cache removeObject:rowInfo];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return rowInfo;
}

- (void)addRowInfo:(BTITableRowInfo *)rowInfo
	makeNewSection:(BOOL)isNewSection
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	if (isNewSection)
	{
		BTITableSectionInfo *sectionInfo = [self dequeueReusableSectionInfoAndAddToContents];
		
		[sectionInfo addObjectToContents:rowInfo];
	}
	else
	{
		BTITableSectionInfo *sectionInfo = [[self sections] lastObject];
		if (sectionInfo == nil)
		{
			sectionInfo = [self dequeueReusableSectionInfoAndAddToContents];
		}
		
		[sectionInfo addObjectToContents:rowInfo];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)enqueueRowInfo:(BTITableRowInfo *)rowInfo
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	if (rowInfo == nil)
	{
		//BTITrackingLog(@"<<< Leaving %s >>> EARLY - No Row provided", __PRETTY_FUNCTION__);
		return;
	}
	
	[[self rowInfoCache] addObject:rowInfo];
	
	[rowInfo reset];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - UITableView Support Methods

- (NSInteger)numberOfSections
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [[self sections] count];
}

- (NSString *)headerTitleInSection:(NSInteger)section
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	BTITableSectionInfo *sectionInfo = [self sectionInfoAtIndex:section];
	
	NSString *header = [sectionInfo headerTitle];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return header;
}

- (NSString *)footerTitleInSection:(NSInteger)section
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	BTITableSectionInfo *sectionInfo = [self sectionInfoAtIndex:section];
	
	NSString *footer = [sectionInfo footerTitle];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return footer;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	BTITableSectionInfo *sectionInfo = [self sectionInfoAtIndex:section];
	
	NSInteger rows = [sectionInfo countOfContents];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return rows;
}

#pragma mark - Content Retrieval Methods

- (BTITableSectionInfo *)sectionInfoAtIndex:(NSInteger)index
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [[self sections] objectAtIndex:index];
}

- (id)representedObjectAtSectionIndex:(NSInteger)index
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	BTITableSectionInfo *sectionInfo = [self sectionInfoAtIndex:index];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [sectionInfo representedObject];
}

- (BTITableRowInfo *)rowInfoAtIndexPath:(NSIndexPath *)indexPath
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	BTITableSectionInfo *sectionInfo = [self sectionInfoAtIndex:[indexPath section]];
	BTITableRowInfo *rowInfo = [sectionInfo objectInContentsAtIndex:[indexPath row]];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return rowInfo;
}

- (id)representedObjectAtIndexPath:(NSIndexPath *)indexPath
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	BTITableRowInfo *rowInfo = [self rowInfoAtIndexPath:indexPath];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [rowInfo representedObject];
}

#pragma mark - Interrogation Methods

- (NSInteger)indexOfSectionInfo:(BTITableSectionInfo *)sectionInfo
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [[self sections] indexOfObject:sectionInfo];
}

- (NSInteger)indexOfRepresentedSectionObject:(id)representedObject
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSInteger returnIndex = NSNotFound;
	
	NSInteger index = -1;
	
	for (BTITableSectionInfo *sectionInfo in [self sections])
	{
		index++;
		if ([representedObject isEqual:[sectionInfo representedObject]])
		{
			returnIndex = index;
			break;
		}
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return returnIndex;
}

- (NSInteger)indexOfSectionIdentifier:(NSString *)identifier
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSInteger returnIndex = NSNotFound;
	
	NSInteger index = -1;
	
	for (BTITableSectionInfo *sectionInfo in [self sections])
	{
		index++;
		if ([identifier isEqual:[sectionInfo identifier]])
		{
			returnIndex = index;
			break;
		}
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return returnIndex;
}

- (NSIndexPath *)indexPathOfRowInfo:(BTITableRowInfo *)rowInfo
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	__block NSIndexPath *indexPath = nil;
	
	[[self sections] enumerateObjectsUsingBlock:^(BTITableSectionInfo *sectionInfo, NSUInteger section, BOOL *sectionStop) {
		
		[[sectionInfo objects] enumerateObjectsUsingBlock:^(BTITableRowInfo *aRowInfo, NSUInteger row, BOOL *rowStop) {
			
			if ([rowInfo isEqual:aRowInfo])
			{
				indexPath = [NSIndexPath indexPathForRow:row inSection:section];
				*rowStop = YES;
				*sectionStop = YES;
			}
			
		}];
		
	}];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return indexPath;
}

- (NSIndexPath *)indexPathOfRepresentedRowObject:(id)representedObject
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	__block NSIndexPath *indexPath = nil;
	
	[[self sections] enumerateObjectsUsingBlock:^(BTITableSectionInfo *sectionInfo, NSUInteger section, BOOL *sectionStop) {
		
		[[sectionInfo objects] enumerateObjectsUsingBlock:^(BTITableRowInfo *aRowInfo, NSUInteger row, BOOL *rowStop) {
			
			if ([representedObject isEqual:[aRowInfo representedObject]])
			{
				indexPath = [NSIndexPath indexPathForRow:row inSection:section];
				*rowStop = YES;
				*sectionStop = YES;
			}
			
		}];
		
	}];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return indexPath;
}

- (NSIndexPath *)indexPathOfRowIdentifier:(NSString *)identifier
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	__block NSIndexPath *indexPath = nil;
	
	[[self sections] enumerateObjectsUsingBlock:^(BTITableSectionInfo *sectionInfo, NSUInteger section, BOOL *sectionStop) {
		
		[[sectionInfo objects] enumerateObjectsUsingBlock:^(BTITableRowInfo *aRowInfo, NSUInteger row, BOOL *rowStop) {
			
			if ([identifier isEqualToString:[aRowInfo identifier]])
			{
				indexPath = [NSIndexPath indexPathForRow:row inSection:section];
				*rowStop = YES;
				*sectionStop = YES;
			}
			
		}];
		
	}];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return indexPath;
}

- (NSIndexSet *)allSectionIndexes
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [[self sections] count])];
}

- (NSArray *)allIndexPaths
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	__block NSMutableArray *indexPaths = [NSMutableArray array];
	
	[[self sections] enumerateObjectsUsingBlock:^(BTITableSectionInfo *sectionInfo, NSUInteger section, BOOL *sectionStop) {
		
		[[sectionInfo objects] enumerateObjectsUsingBlock:^(BTITableRowInfo *aRowInfo, NSUInteger row, BOOL *rowStop) {
			
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
			[indexPaths addObject:indexPath];
			
		}];
		
	}];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [NSArray arrayWithArray:indexPaths];
}

#pragma mark - NSFastEnumeration Methods

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)enumerationState
								  objects:(id __unsafe_unretained [])buffer
									count:(NSUInteger)len
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [[self sections] countByEnumeratingWithState:enumerationState
												objects:buffer
												  count:len];
}


@end
