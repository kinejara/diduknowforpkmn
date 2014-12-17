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

    NSMutableArray *arrayOfFacts = [NSMutableArray new];
    
    for(NSString *gen in generations) {
        NSInteger numberOfFacts = [self pickNumberOfPhraseswithGeneration:gen];
 
        for (int i = 0; i <=numberOfFacts; i ++) {
            NSString *PokeFact = [NSString stringWithFormat:@"%i",i];
            [arrayOfFacts addObject:NSLocalizedString(PokeFact, @"")];
        }
    }
    
    return arrayOfFacts;
}

- (NSInteger)pickNumberOfPhraseswithGeneration:(NSString *)generation {
    
    if ([generation isEqualToString:NSLocalizedString(@"all", @"")]) {
        return 453;
    } else if ([generation isEqualToString:NSLocalizedString(@"anime", @"")]) {
    
    } else if ([generation isEqualToString:NSLocalizedString(@"firstGen", @"")]) {
        
    } else if ([generation isEqualToString:NSLocalizedString(@"secondGen", @"")]) {
        
    } else if ([generation isEqualToString:NSLocalizedString(@"thirdGen", @"")]) {
        
    } else if ([generation isEqualToString:NSLocalizedString(@"fourthGen", @"")]) {
        
    } else if ([generation isEqualToString:NSLocalizedString(@"fiveGen", @"")]) {
        
    } else if ([generation isEqualToString:NSLocalizedString(@"sixGen", @"")]) {
        
    }
    
    return 453;
}


-(NSArray*)createArray:(NSArray *)factmodes
{
    
    NSMutableArray * arrayOfPhrases = [NSMutableArray new];
    //NSLog(@"selection2 %@",[factmodes description]);
    
    for(NSString * s in factmodes) {
        
        if([s isEqualToString:NSLocalizedString(@"all", @"")]) {
            for(int i =0; i <=453; i ++) {
                NSString * s = [NSString stringWithFormat:@"%i",i];
                [arrayOfPhrases addObject:NSLocalizedString(s, @"")];
            }
        }
        if([s isEqualToString:NSLocalizedString(@"anime", @"")])
        {
            for(int i =0; i <=100; i ++)
            {
                NSString * s = [NSString stringWithFormat:@"%i",i];
                [arrayOfPhrases addObject:NSLocalizedString(s, @"")];
            }
            
        }
        
        if([s isEqualToString:NSLocalizedString(@"firstGen", @"")])
        {
            for(int i =101; i <=200; i ++)
            {
                NSString * s = [NSString stringWithFormat:@"%i",i];
                [arrayOfPhrases addObject:NSLocalizedString(s, @"")];
            }
        }
        
        if([s isEqualToString:NSLocalizedString(@"secondGen", @"")])
        {
            for(int i =201; i <=250; i ++)
            {
                NSString * s = [NSString stringWithFormat:@"%i",i];
                [arrayOfPhrases addObject:NSLocalizedString(s, @"")];
            }
        }
        
        if([s isEqualToString:NSLocalizedString(@"thirdGen", @"")])
        {
            for(int i =251; i <=300; i ++)
            {
                NSString * s = [NSString stringWithFormat:@"%i",i];
                [arrayOfPhrases addObject:NSLocalizedString(s, @"")];
            }
        }
        
        if([s isEqualToString:NSLocalizedString(@"fourthGen", @"")])
        {
            for(int i =301; i <=350; i ++)
            {
                NSString * s = [NSString stringWithFormat:@"%i",i];
                [arrayOfPhrases addObject:NSLocalizedString(s, @"")];
            }
        }
        
        if([s isEqualToString:NSLocalizedString(@"fiveGen", @"")])
        {
            for(int i =351; i <=400; i ++)
            {
                NSString * s = [NSString stringWithFormat:@"%i",i];
                [arrayOfPhrases addObject:NSLocalizedString(s, @"")];
            }
        }
        
        if([s isEqualToString:NSLocalizedString(@"sixGen", @"")])
        {
            for(int i =401; i <=451; i ++)
            {
                NSString * s = [NSString stringWithFormat:@"%i",i];
                [arrayOfPhrases addObject:NSLocalizedString(s, @"")];
            }
        }
        /*
         NSLocalizedString(@"all", @""),
         NSLocalizedString(@"firstGen", @""),
         NSLocalizedString(@"secondGen", @""),
         NSLocalizedString(@"thirdGen", @""),
         NSLocalizedString(@"fourthGen", @""),
         NSLocalizedString(@"fiveGen", @""),
         NSLocalizedString(@"sixGen", @""),
         */

        
        /*
        if([s isEqualToString:NSLocalizedString(@"firstGen", @"")] || [s isEqualToString:NSLocalizedString(@"all", @"")])
        {
            [arrayOfPhrases addObject:NSLocalizedString(@"genOne1", @"")];
            [arrayOfPhrases addObject:NSLocalizedString(@"genOne2", @"")];
            [arrayOfPhrases addObject:NSLocalizedString(@"genOne3", @"")];
        }
        */
    }
    return arrayOfPhrases;
    
}

@end
