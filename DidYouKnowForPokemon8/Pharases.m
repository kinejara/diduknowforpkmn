//
//  Pharases.m
//  Did You Know For Pokemon
//
//  Created by Jorge Kinejara on 2/20/14.
//  Copyright (c) 2014 Jorge Kinejara. All rights reserved.
//

#import "Pharases.h"

@implementation Pharases

-(NSArray *)createArrayOfPokePhrasesWithGenerations:(NSArray *)generations {
    
    NSMutableArray *facts = [NSMutableArray new];
    
    NSDictionary *factsInPlist = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"facts" ofType:@"plist"]];
   
    if ([generations containsObject:@"all"]) {
        [facts addObjectsFromArray:factsInPlist[@"anime"]];
        [facts addObjectsFromArray:factsInPlist[@"firstGen"]];
        [facts addObjectsFromArray:factsInPlist[@"secondGen"]];
        [facts addObjectsFromArray:factsInPlist[@"thirdGen"]];
        [facts addObjectsFromArray:factsInPlist[@"fourthGen"]];
        [facts addObjectsFromArray:factsInPlist[@"fiveGen"]];
        [facts addObjectsFromArray:factsInPlist[@"sixGen"]];
        
        return facts;
        
    } else if ([generations containsObject:@"anime"]) {
        [facts addObjectsFromArray:factsInPlist[@"anime"]];
    } else if ([generations containsObject:@"first"]) {
        [facts addObjectsFromArray:factsInPlist[@"firstGen"]];
    } else if ([generations containsObject:@"second"]) {
        [facts addObjectsFromArray:factsInPlist[@"secondGen"]];
    } else if ([generations containsObject:@"third"]) {
        [facts addObjectsFromArray:factsInPlist[@"thirdGen"]];
    } else if ([generations containsObject:@"fourth"]) {
        [facts addObjectsFromArray:factsInPlist[@"fourthGen"]];
    } else if ([generations containsObject:@"fiveGen"]) {
        [facts addObjectsFromArray:factsInPlist[@"fiveGen"]];
    } else if ([generations containsObject:@"six"]) {
        [facts addObjectsFromArray:factsInPlist[@"sixGen"]];
    }
    
    return facts;
}


@end
