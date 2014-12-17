//
//  ViewController.m
//  DidYouKnowForPokemon8
//
//  Created by Jorge Kinejara on 12/12/14.
//  Copyright (c) 2014 kine. All rights reserved.
//

#import "DNPMainViewController.h"
#import "Pharases.h"

@interface DNPMainViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *pokeFacts;

@end

@implementation DNPMainViewController

- (instancetype)init {
    self = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DNPMainViewController"];
    
    if (self) {
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *gens = @[@"all"];
    Pharases *pokeFacts = [Pharases new];
    self.pokeFacts = [pokeFacts createArrayOfPokePhrasesWithGenerations:gens];
    
    [self performSelector:@selector(loadPokeFacts) withObject:nil afterDelay:3.0];
    self.view.backgroundColor = [UIColor redColor];
    [self configureTableView];
    
    //NSLog(@"print front localize %@",NSLocalizedString(@"0", @""));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)configureTableView {
    UIColor *clearColor = [UIColor clearColor];
    self.tableView.backgroundColor = clearColor;
}

- (void)loadPokeFacts {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokeFacts.count;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokeCell" forIndexPath:indexPath];
     
     cell.contentView.backgroundColor = [UIColor clearColor];
     
     cell.textLabel.text = self.pokeFacts[indexPath.row];
 
     return cell;
}


@end
