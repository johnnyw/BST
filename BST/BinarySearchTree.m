//
//  BinarySearchTree.m
//  BST
//
//  Created by John Watson on 5/18/14.
//  Copyright (c) 2014 John Watson. All rights reserved.
//

#import "BinarySearchTree.h"

@interface BSTNode : NSObject

@property id key;
@property id value;
@property BSTNode *left;
@property BSTNode *right;
@property NSInteger N;

@end

@implementation BSTNode

- (id)initWithKey:(id)aKey value:(id)aValue nodeCount:(NSInteger)n
{
    self = [super init];
    if(self) {
        _key = aKey;
        _value = aValue;
        _N = n;
    }
    return self;
}

@end

@interface BinarySearchTree ()
{
    BSTNode *_root;
}
@end

@implementation BinarySearchTree

- (id)objectForKey:(id)aKey
{
    return [self objectForKey:aKey forNode:_root];
}

- (id)objectForKey:(id)aKey forNode:(BSTNode*)node
{
    if(node) {
        NSComparisonResult cmp = [aKey compare:node.key];
        if(cmp == NSOrderedAscending) return [self objectForKey:aKey forNode:node.left];
        if(cmp == NSOrderedDescending) return [self objectForKey:aKey forNode:node.right];
        return node.value;
    } else {
        return nil;
    }
}

- (void)setObject:(id)anObject forKey:(id)aKey
{
    _root = [self setObject:anObject forKey:aKey forNode:_root];
}

- (BSTNode*)setObject:(id)anObject forKey:(id)aKey forNode:(BSTNode*)node
{
    // Change the key's value to anObject if key in subtree rooted at node
    // Otherwise, add new node to subtree associating key with anObject
    if(!node) {
        return [[BSTNode alloc] initWithKey:aKey value:anObject nodeCount:1];
    }
    
    NSComparisonResult cmp = [aKey compare:node.key];
    if(cmp == NSOrderedAscending) node.left = [self setObject:anObject forKey:aKey forNode:node.left];
    else if(cmp == NSOrderedDescending) node.right = [self setObject:anObject forKey:aKey forNode:node.right];
    else node.value = anObject;
    node.N = [self size:node.left] + [self size:node.right] + 1;
    return node;
}

- (NSInteger)size
{
    return [self size:_root];
}

- (NSInteger)size:(BSTNode*)node
{
    if(node) {
        return node.N;
    } else {
        return 0;
    }
}

- (id)min
{
    return [self min:_root].key;
}

- (BSTNode*)min:(BSTNode*)x
{
    if(x.left == nil) return x;
    return [self min:x.left];
}

- (id)max
{
    return [self max:_root].key;
}

- (BSTNode*)max:(BSTNode*)x
{
    if(x.right == nil) return x;
    return [self max:x.right];
}

- (id)floor:(id)aKey
{
    BSTNode *x = [self floor:aKey node:_root];
    if(x == nil) return nil;
    return x.key;
}

- (BSTNode*)floor:(id)aKey node:(BSTNode*)x
{
    if(x == nil) return nil;
    int cmp = [aKey compare:x.key];
    if(cmp == NSOrderedSame) return x;
    if(cmp == NSOrderedAscending) return [self floor:aKey node:x.left];
    
    BSTNode *t = [self floor:aKey node:x.right];
    if(t) {
        return t;
    } else {
        return x;
    }
}

- (id)ceiling:(id)aKey
{
    BSTNode *x = [self ceiling:aKey node:_root];
    if(x == nil) return nil;
    return x.key;
}

- (BSTNode*)ceiling:(id)aKey node:(BSTNode*)x
{
    if(x == nil) return nil;
    int cmp = [aKey compare:x.key];
    if(cmp == NSOrderedSame) return x;
    if(cmp == NSOrderedDescending) return [self floor:aKey node:x.right];
    
    BSTNode *t = [self floor:aKey node:x.left];
    if(t) {
        return t;
    } else {
        return x;
    }
}

- (id)select:(NSInteger)k
{
    return [self select:k node:_root].key;
}

- (BSTNode*)select:(NSInteger)k node:(BSTNode*)x
{
    if(!x) return nil;
    NSInteger t = [self size:x.left];
    if(t > k) return [self select:k node:x.left];
    else if(t < k) return [self select:k-t-1 node:x.right];
    else return x;
}

- (NSInteger)rank:(id)key
{
    return [self rank:key node:_root];
}

- (NSInteger)rank:(id)key node:(BSTNode*)x
{
    if(!x) return 0;
    int cmp = [key compare:x.key];
    if(cmp == NSOrderedAscending) return [self rank:key node:x.left];
    else if(cmp == NSOrderedDescending) return 1 + [self size:x.left] + [self rank:key node:x.right];
    else return [self size:x.left];
}

- (void)deleteMin
{
    _root = [self deleteMin:_root];
}

- (void)deleteMax
{
    _root = [self deleteMax:_root];
}

- (BSTNode*)deleteMin:(BSTNode*)x
{
    if(!x.left) return x.right;
    x.left = [self deleteMin:x.left];
    x.N = [self size:x.left] + [self size:x.right] + 1;
    return x;
}

- (BSTNode*)deleteMax:(BSTNode*)x
{
    if(!x.right) return x.left;
    x.right = [self deleteMax:x.right];
    x.N = [self size:x.right] + [self size:x.left] + 1;
    return x;
}

- (void)delete:(id)key
{
    _root = [self delete:key node:_root];
}

- (BSTNode*)delete:(id)key node:(BSTNode*)x
{
    if(!x) return nil;
    int cmp = [key compare:x.key];
    if(cmp == NSOrderedAscending) x.left = [self delete:key node:x.left];
    else if(cmp == NSOrderedDescending) x.right = [self delete:key node:x.right];
    else {
        if(!x.right) return x.left;
        if(!x.left) return x.right;
        BSTNode *t = x;
        x = [self min:t.right];
        x.right = [self deleteMin:t.right];
        x.left = t.left;
    }
    
    x.N = [self size:x.left] + [self size:x.right] + 1;
    return x;
}

- (void)keys:(BSTNode*)x array:(NSMutableArray*)array low:(id)lo high:(id)hi
{
    if(!x) return;
    int cmplo = [lo compare:x.key];
    int cmphi = [hi compare:x.key];
    
    if(cmplo == NSOrderedAscending) [self keys:x.left array:array low:lo high:hi];
    if(cmplo <= 0 && cmphi >= 0) [array addObject:x.key];
    if(cmphi == NSOrderedDescending) [self keys:x.right array:array low:lo high:hi];
}

- (NSMutableArray*)keysLow:(id)lo high:(id)hi
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self keys:_root array:array low:lo high:hi];
    return array;
}

- (NSArray*)allKeys
{
    return [[self keysLow:[self min] high:[self max]] copy];
}

- (id)objectForKeyedSubscript:(id<NSCopying>)key
{
    return [self objectForKey:key];
}

- (void)setObject:(id)anObject forKeyedSubscript:(id<NSCopying>)key
{
    [self setObject:anObject forKey:key];
}

@end
