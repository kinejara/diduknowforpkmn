//
//  ViewController.m
//  DidYouKnowForPokemon8
//
//  Created by Jorge Kinejara on 12/12/14.
//  Copyright (c) 2014 kine. All rights reserved.
//
#import "Pharases.h"
#import "UIColor+DidYouKnowAdditions.h"
#import "NSMutableArray+Shuffling.h"
#import "DNPMainViewController.h"
#import "PokeTableViewCell.h"

@interface DNPMainViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSMutableArray *pokeFacts;

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

    [self loadPokeFacts];
    
    [self configureTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)configureTableView {
    UIColor *clearColor = [UIColor clearColor];
    self.tableView.backgroundColor = clearColor;
    self.tableView.rowHeight = 220;
}

- (void)loadPokeFacts {
    
    NSArray *gens = @[@"first", @"all"];
    
    if (self.pokeFacts.count > 0) {
        [self.pokeFacts removeAllObjects];
    }
    
    Pharases *pokeFacts = [Pharases new];
    NSArray *pokeFactsArray = [pokeFacts createArrayOfPokePhrasesWithGenerations:gens];
    
    self.pokeFacts = [NSMutableArray shuffleArray:pokeFactsArray];
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
    [self.tableView reloadData];
}

- (void)didTapMenu:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Options"
                                          message:@""
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction
                         actionWithTitle:@"Cancel"
                         style:UIAlertActionStyleCancel
                         handler:^(UIAlertAction * action)
                         {
                             [alertController dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    UIAlertAction *refresh = [UIAlertAction
                             actionWithTitle:@"Refresh Trivia"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self loadPokeFacts];
                             }];
    
    UIAlertAction *visitFB = [UIAlertAction
                           actionWithTitle:@"Go to FB page"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               NSURL *url = [NSURL URLWithString:@"fb://profile/133666066840052"];
                               [[UIApplication sharedApplication] openURL:url];
                           }];
    
    UIAlertAction *rate = [UIAlertAction
                           actionWithTitle:@"Rate"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               NSString * urlString = [NSString stringWithFormat:@"https://itunes.apple.com/es/app/did-you-know-for-pokemon/id608028683?mt=8"];
                               
                               NSURL *url = [NSURL URLWithString:urlString];
                               [[UIApplication sharedApplication] openURL:url];
                           }];
    
    UIAlertAction *settings = [UIAlertAction
                           actionWithTitle:@"Settings"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               [alertController dismissViewControllerAnimated:YES completion:nil];
                           }];
    
    [alertController addAction:refresh];
    [alertController addAction:visitFB];
    [alertController addAction:rate];
    [alertController addAction:settings];
    [alertController addAction:cancel];
   
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)goToSettings {
    //TODO:go to settings
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
    
    UIImage *image = [[UIImage imageNamed:@"pokedex_footer"]
                      stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    
    UIView *footerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    
    footerView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UIButton *optionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    optionButton.frame = CGRectMake(94, 10, 160.0, 40.0);
    
    [optionButton setImage:[UIImage imageNamed:@"action_icon@2x.png"] forState:UIControlStateNormal];
    [optionButton addTarget:self action:@selector(didTapMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:optionButton];
  
    return footerView;
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
