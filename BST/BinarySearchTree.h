//
//  BinarySearchTree.h
//  BST
//
//  Created by John Watson on 5/18/14.
//  Copyright (c) 2014 John Watson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinarySearchTree : NSObject

@property(nonatomic,readwrite) NSInteger size;

- (id)objectForKey:(id)aKey;
- (void)setObject:(id)anObject forKey:(id)aKey;
- (id)min;
- (id)max;
- (id)floor:(id)aKey;
- (id)ceiling:(id)aKey;
- (id)select:(NSInteger)k;
- (NSInteger)rank:(id)key;
- (void)deleteMin;
- (void)deleteMax;
- (void)delete:(id)key;
- (NSArray*)allKeys;
- (id)objectForKeyedSubscript:(id<NSCopying>)key;
- (void)setObject:(id)anObject forKeyedSubscript:(id<NSCopying>)key;

@end
