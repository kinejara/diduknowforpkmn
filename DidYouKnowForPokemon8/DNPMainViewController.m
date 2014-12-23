//
//  ViewController.m
//  DidYouKnowForPokemon8
//
//  Created by Jorge Kinejara on 12/12/14.
//  Copyright (c) 2014 kine. All rights reserved.
//

#import "DNPMainViewController.h"
#import "Pharases.h"
#import "UIColor+DidYouKnowAdditions.h"
#import "PokeTableViewCell.h"

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
    
    self.view.backgroundColor = [UIColor pkmn_systemRedColor];

    NSArray *gens = @[@"first", @"all"];
    Pharases *pokeFacts = [Pharases new];
    self.pokeFacts = [pokeFacts createArrayOfPokePhrasesWithGenerations:gens];
    
    [self performSelector:@selector(loadPokeFacts) withObject:nil afterDelay:3.0];
    [self configureTableView];
    
    //self.tableView.estimatedRowHeight = 102.0;
    self.tableView.rowHeight = 220;

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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 160;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIImage *headerImg = [UIImage imageNamed:@"pokedex_header"];
    UIImageView *headerImgView = [[UIImageView alloc] initWithImage:headerImg];
    
    return headerImgView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIImage *footerImg = [UIImage imageNamed:@"pokedex_footer"];
    UIImageView *footerImgView = [[UIImageView alloc] initWithImage:footerImg];
    
    return footerImgView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokeFacts.count;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

     static NSString *simpleTableIdentifier = @"pokeCell";
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
     
     if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
     }
     
     cell.backgroundColor = [UIColor pkmn_systemBlueColor];
     cell.textLabel.textAlignment = NSTextAlignmentCenter;
     cell.textLabel.font = [UIFont fontWithName:@"pokemonGB" size:14.0];
     cell.textLabel.text = self.pokeFacts[indexPath.row];
     cell.textLabel.numberOfLines = 12;
     
     return cell;
}


@end
