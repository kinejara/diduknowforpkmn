//
//  TodayViewController.m
//  DidYouKnowForPokemonWidget
//
//  Created by Jorge Villa on 1/2/15.
//  Copyright (c) 2015 kine. All rights reserved.
//

#import "TodayViewController.h"
#import "Pharases.h"
#import "NSMutableArray+Shuffling.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic, weak) IBOutlet UILabel *pokefactLabel;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)widgetAllowsEditing {
    // Return YES to indicate that the widget supports editing of content and
    // that the list view should be allowed to enter an edit mode.
    return YES;
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    self.pokefactLabel.text = [self getRandomFactForWidget];
    self.pokefactLabel.textAlignment = NSTextAlignmentCenter;
    self.pokefactLabel.font = [UIFont fontWithName:@"pokemonGB" size:14.0];
    self.pokefactLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapinTextView:)];
    [self.pokefactLabel addGestureRecognizer:singleFingerTap];
    completionHandler(NCUpdateResultNewData);
}

- (NSString *)getRandomFactForWidget {
    
    Pharases *pokeFact = [Pharases new];
    NSArray *storeGenerations = DNPStoreGenerations;
    NSArray *arrayOfFacts = [pokeFact createArrayOfPokePhrasesWithGenerations:storeGenerations];
    NSMutableArray *shuffleFacts = [NSMutableArray shuffleArray:arrayOfFacts];
    
    return shuffleFacts[0];
}

- (NSArray *)getStoreGenerationFromSettings {
    
    NSArray *storeGenerations = [NSArray array];
    
    if ([DNPStoreSettings arrayForKey:@"storeTeamsArray"]) {
        storeGenerations = [DNPStoreSettings arrayForKey:@"storeTeamsArray"];
    } else {
        storeGenerations = [[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:0], nil];
    }
    
    return storeGenerations;
}

- (void)handleSingleTapinTextView:(UITapGestureRecognizer *)recognizer {
    NSURL *url = [NSURL URLWithString:@"home://"];
    [self.extensionContext openURL:url completionHandler:nil];
}

@end
