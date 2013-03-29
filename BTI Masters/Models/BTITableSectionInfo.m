//
//  BTITableSectionInfo.h
//
//  Created by Brian Slick in Sept 2012
//  Copyright (c) 2012 BriTer Ideas LLC. All rights reserved.
//

#import "BTITableSectionInfo.h"

#import "BTIImport.h"

// Models and other global

// Private Constants

@interface BTITableSectionInfo ()

// Private Properties
@property (nonatomic, strong) NSMutableArray *contents;

// Notification Handlers

// Misc Methods

@end


@implementation BTITableSectionInfo

#pragma mark - Synthesized Properties

// Needed because readonly properties don't auto-create ivars.
@synthesize UUIDString = _UUIDString;

#pragma mark - Dealloc and Memory Management


#pragma mark - Custom Getters and Setters

- (NSString *)name
{
	return [self headerTitle];
}

- (NSString *)indexTitle
{
	return [self sectionIndexTitle];
}

- (NSUInteger)numberOfObjects
{
	return [[self contents] count];
}

- (NSArray *)objects
{
	return [NSArray arrayWithArray:[self contents]];
}

- (NSMutableArray *)contents
{
	if (_contents == nil)
	{
		_contents = [[NSMutableArray alloc] init];
	}
	return _contents;
}

- (NSString *)UUIDString
{
	if (_UUIDString == nil)
	{
		_UUIDString = [[NSUUID UUID] UUIDString];
	}
	return _UUIDString;
}

#pragma mark - Initialization

- (id)init
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	self = [super init];
	if (self)
	{
		[self UUIDString];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return self;
}

#pragma mark - NSObject Methods

- (NSUInteger)hash
{
	return [[self UUIDString] hash];
}

- (BOOL)isEqual:(id)anObject
{
	BOOL isEqual = NO;
	
	if ([anObject isKindOfClass:[self class]])
	{
		isEqual = ([[(BTITableSectionInfo *)anObject UUIDString] isEqualToString:[self UUIDString]]);
	}
	
	return isEqual;
}

#pragma mark - Misc Methods

- (void)reset
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[self setIdentifier:nil];
	[self setHeaderTitle:nil];
	[self setFooterTitle:nil];
	[self setSectionIndexTitle:nil];
	[self setRepresentedObject:nil];
	[self removeAllObjectsInContents];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Content Methods

- (void)addObjectToContents:(id)newObject
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	if (newObject == nil)
	{
		//BTITrackingLog(@"<<< Leaving %s >>> EARLY - No Object", __PRETTY_FUNCTION__);
		return;
	}
	
	[[self contents] addObject:newObject];
	
	if ([newObject isKindOfClass:[BTITableRowInfo class]])
	{
		[(BTITableRowInfo *)newObject setParentSectionInfo:self];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)addObjectsToContents:(NSSet *)newObjects
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	for (id object in newObjects)
	{
		[self addObjectToContents:object];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)insertObjectInContents:(id)newObject
					   atIndex:(NSUInteger)index;
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[[self contents] insertObject:newObject atIndex:index];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)removeObjectFromContents:(id)oldObject
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[[self contents] removeObject:oldObject];
	
	if ([oldObject isKindOfClass:[BTITableRowInfo class]])
	{
		[(BTITableRowInfo *)oldObject setParentSectionInfo:nil];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)moveObjectInContentsFromIndex:(NSUInteger)fromIndex
							  toIndex:(NSUInteger)toIndex
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[[self contents] moveObjectAtIndexBTI:fromIndex toIndex:toIndex];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)removeAllObjectsInContents
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	NSSet *contentsToRemove = [NSSet setWithArray:[self contents]];
	
	for (id object in contentsToRemove)
	{
		[self removeObjectFromContents:object];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (NSUInteger)countOfContents
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [[self contents] count];
}

- (NSUInteger)indexOfObjectInContents:(id)object
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [[self contents] indexOfObject:object];
}

- (NSEnumerator *)contentsEnumerator
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [[self contents] objectEnumerator];
}

- (id)objectInContentsAtIndex:(NSUInteger)index
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [[self contents] objectAtIndex:index];
}

- (BOOL)contentsContainsObject:(id)anObject
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return ([[self contents] containsObject:anObject]);
}

- (void)sortContentsUsingDescriptors:(NSArray *)descriptors
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	[[self contents] sortUsingDescriptors:descriptors];
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Misc Methods


#pragma mark - NSFastEnumeration Methods

- (NSUInteger) countByEnumeratingWithState:(NSFastEnumerationState *)enumerationState
                                   objects:(id __unsafe_unretained [])buffer
                                     count:(NSUInteger)len
{
    return [[self contents] countByEnumeratingWithState:enumerationState
												objects:buffer
												  count:len];
}

@end
