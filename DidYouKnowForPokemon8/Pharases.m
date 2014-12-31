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
    
    NSArray *pokeFactsOptions = [[NSArray alloc] initWithObjects:
                             NSLocalizedString(@"all", @""),
                             NSLocalizedString(@"anime", @""),
                             NSLocalizedString(@"firstGen", @""),
                             NSLocalizedString(@"secondGen", @""),
                             NSLocalizedString(@"thirdGen", @""),
                             NSLocalizedString(@"fourthGen", @""),
                             NSLocalizedString(@"fiveGen", @""),
                             NSLocalizedString(@"sixGen", @""),
                             nil];
   
    if ([generations containsObject:pokeFactsOptions[0]]) {
        [facts addObjectsFromArray:factsInPlist[@"anime"]];
        [facts addObjectsFromArray:factsInPlist[@"firstGen"]];
        [facts addObjectsFromArray:factsInPlist[@"secondGen"]];
        [facts addObjectsFromArray:factsInPlist[@"thirdGen"]];
        [facts addObjectsFromArray:factsInPlist[@"fourthGen"]];
        [facts addObjectsFromArray:factsInPlist[@"fiveGen"]];
        [facts addObjectsFromArray:factsInPlist[@"sixGen"]];
        
        return facts;
        
    } else if ([generations containsObject:pokeFactsOptions[1]]) {
        [facts addObjectsFromArray:factsInPlist[@"anime"]];
    } else if ([generations containsObject:pokeFactsOptions[2]]) {
        [facts addObjectsFromArray:factsInPlist[@"firstGen"]];
    } else if ([generations containsObject:pokeFactsOptions[3]]) {
        [facts addObjectsFromArray:factsInPlist[@"secondGen"]];
    } else if ([generations containsObject:pokeFactsOptions[4]]) {
        [facts addObjectsFromArray:factsInPlist[@"thirdGen"]];
    } else if ([generations containsObject:pokeFactsOptions[5]]) {
        [facts addObjectsFromArray:factsInPlist[@"fourthGen"]];
    } else if ([generations containsObject:pokeFactsOptions[6]]) {
        [facts addObjectsFromArray:factsInPlist[@"fiveGen"]];
    } else if ([generations containsObject:pokeFactsOptions[7]]) {
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
