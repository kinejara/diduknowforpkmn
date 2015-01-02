//
//  NSMutableArray+Shuffling.m
//  DidYouKnowForPokemon8
//
//  Created by Jorge Villa on 12/30/14.
//  Copyright (c) 2014 kine. All rights reserved.
//

#import "NSMutableArray+Shuffling.h"

@implementation NSMutableArray (Shuffling)

+ (NSMutableArray *)shuffleArray:(NSArray *)array
{
    NSMutableArray *shuffledArray = [[NSMutableArray alloc ] initWithArray:array];
    NSUInteger count = [shuffledArray count];
   
    for (uint i = 0; i < count; ++i)
    {
        unsigned long nElements = count - i;
        unsigned long n = arc4random_uniform(nElements) + i;
        [shuffledArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    return shuffledArray;
}

@end
