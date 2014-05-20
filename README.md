BST
===
This is an Objective-C implementation of an ordered key value symbol table. It's based on the description of a binary search tree from Robert Sedgewick's Algorithms. It implements the selectors objectForKeyedSubscript: and setObject:forKeyedSubscript:, allowing for dictionary-style subscripting (for example, collection[key] = value). I wrote this because a) there is no standard "ordered dictionary" in Objective-C, and b) I felt out of practice with solving tree problems, and wanted to write something using trees.

Included is a driver program (main.m) which includes asserts for the various APIs exposed in BinarySearchTree.h.
