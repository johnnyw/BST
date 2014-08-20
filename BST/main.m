//
//  main.m
//  BST
//
//  Created by John Watson on 5/18/14.
//  Copyright (c) 2014 John Watson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinarySearchTree.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        BinarySearchTree *bst = [[BinarySearchTree alloc] init];
        NSArray *numbers = @[@8, @7, @20, @31, @2, @38];
        NSArray *words = @[@"eight", @"seven", @"twenty", @"thirty one", @"two", @"thirty eight"];
        
        for(int i = 0; i < [numbers count]; ++i) {
            bst[numbers[i]] = words[i];
        }
        
        for(int i = 0; i < [numbers count]; ++i) {
            NSCAssert([bst[numbers[i]] isEqual:words[i]], @"Encountered unexpected key/value pair (Key: %@, Value: %@)", bst[numbers[i]], words[i]);
        }
        
        NSArray *keys = [bst allKeys];
        
        for(int i = 1; i < [keys count]; ++i) {
            NSNumber *current = keys[i];
            NSNumber *last = keys[i - 1];
            NSCAssert([last compare:current] == NSOrderedAscending, @"Keys should be returned in ascending order. (%@, %@)", last, current);
        }
        
        NSCAssert([[bst min] isEqual:@2], @"Expected min to be 2");
        NSCAssert([[bst max] isEqual:@38], @"Expected max to be 38");
        
        [bst deleteMin];
        NSCAssert([[bst min] isEqual:@7], @"Expected min to be 7");
        
        [bst deleteMax];
        NSCAssert([[bst max] isEqual:@31], @"Expected max to be 31");
        
        keys = [bst allKeys];
        
        NSCAssert([[bst floor:@10] isEqual:@8], @"Expected floor:@10 to be 8");
        NSCAssert([[bst ceiling:@35] isEqual:@31], @"Expected ceiling:@35 to be 31");
        
        NSCAssert([bst rank:@20] == 2, @"Expected rank of @20 to be 2");
        NSCAssert([[bst select:2] isEqual:@20], @"Expected selecting item of rank 2 to return @20");
        
        for(NSString *key in keys) {
            NSInteger rank = [bst rank:key];
            NSCAssert([[bst select:rank] isEqual:key], @"Selecting queried rank should yield corresponding key (rank: %li, key: %@)", rank, key);
        }
        
        NSInteger size = [keys count];
        NSNumber *deleteKey = keys[0];
        [bst delete:deleteKey];
        
        keys = [bst allKeys];
        NSInteger newSize = [keys count];
        NSCAssert(newSize == size - 1, @"Size should be one less than %li (is actually %li)", size, newSize);
        
        NSCAssert(![keys containsObject:deleteKey], @"Deleted key should no longer be in key set");
        NSCAssert(![bst objectForKey:deleteKey], @"Deleted key should not return a value");
    }
    return 0;
}

