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
    
    NSDictionary *factsInPlist = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[self getPlistNameForLanguage] ofType:@"plist"]];
    
    if ([generations containsObject:[NSNumber numberWithInteger:0]]) {
        [facts addObjectsFromArray:factsInPlist[@"anime"]];
        [facts addObjectsFromArray:factsInPlist[@"firstGen"]];
        [facts addObjectsFromArray:factsInPlist[@"secondGen"]];
        [facts addObjectsFromArray:factsInPlist[@"thirdGen"]];
        [facts addObjectsFromArray:factsInPlist[@"fourthGen"]];
        [facts addObjectsFromArray:factsInPlist[@"fiveGen"]];
        [facts addObjectsFromArray:factsInPlist[@"sixGen"]];

        return facts;
        
    } else if ([generations containsObject:[NSNumber numberWithInteger:1]]) {
        [facts addObjectsFromArray:factsInPlist[@"anime"]];
    } else if ([generations containsObject:[NSNumber numberWithInteger:2]]) {
        [facts addObjectsFromArray:factsInPlist[@"firstGen"]];
    } else if ([generations containsObject:[NSNumber numberWithInteger:3]]) {
        [facts addObjectsFromArray:factsInPlist[@"secondGen"]];
    } else if ([generations containsObject:[NSNumber numberWithInteger:4]]) {
        [facts addObjectsFromArray:factsInPlist[@"thirdGen"]];
    } else if ([generations containsObject:[NSNumber numberWithInteger:5]]) {
        [facts addObjectsFromArray:factsInPlist[@"fourthGen"]];
    } else if ([generations containsObject:[NSNumber numberWithInteger:6]]) {
        [facts addObjectsFromArray:factsInPlist[@"fiveGen"]];
    } else if ([generations containsObject:[NSNumber numberWithInteger:7]]) {
        [facts addObjectsFromArray:factsInPlist[@"sixGen"]];
    }
    
    return facts;
}

- (NSString *)getPlistNameForLanguage {
    
    NSString *plistName = @"facts";
    
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    if ([language isEqualToString:@"es"]) {
        plistName = @"hechos";
    } else {
        plistName = @"facts";
    }
    
    return plistName;
}


@end
