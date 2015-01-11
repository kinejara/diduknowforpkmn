//
//  DNPSettingsTableTableViewController.m
//  DidYouKnowForPokemon8
//
//  Created by Jorge Villa on 12/30/14.
//  Copyright (c) 2014 kine. All rights reserved.
//

#import "DNPSettingsTableTableViewController.h"
#import "UIColor+DidYouKnowAdditions.h"
#import "AppDelegate.h"

@interface DNPSettingsTableTableViewController ()

@property (nonatomic, strong) NSArray *pokeFactsOptions;
@property (nonatomic, strong) NSMutableArray *selectedIndex;
@property (nonatomic, weak) IBOutlet UISwitch *notificationSwitch;

typedef NS_ENUM(NSInteger, DNPPokeGenerations) {
    allOptions = 0,
    animeOption,
    firstGen,
    secondGen,
    thirdGen,
    fourthGen,
    fiveGen,
    sixGen
};

@end

@implementation DNPSettingsTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizingNavigationBar];
    
    self.pokeFactsOptions = [[NSArray alloc] initWithObjects:
                             NSLocalizedString(@"all", @""),
                             NSLocalizedString(@"anime", @""),
                             NSLocalizedString(@"firstGen", @""),
                             NSLocalizedString(@"secondGen", @""),
                             NSLocalizedString(@"thirdGen", @""),
                             NSLocalizedString(@"fourthGen", @""),
                             NSLocalizedString(@"fiveGen", @""),
                             NSLocalizedString(@"sixGen", @""),
                             nil];
    
    self.selectedIndex = [NSMutableArray arrayWithArray:DNPStoreGenerations];
}


- (void)customizingNavigationBar {
    self.navigationController.navigationBar.barTintColor = [UIColor pkmn_systemBlueColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = NSLocalizedString(@"settings", @"");
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"cancel", @"") style:UIBarButtonItemStylePlain target:self action:@selector(didTapCancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"save", @"") style:UIBarButtonItemStylePlain target:self action:@selector(didTapSave)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTapCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapSave {
    
    if (self.selectedIndex.count <= 0) {
        [self showErrorAlert];
    } else {
        [DNPStoreSettings setObject:self.selectedIndex forKey:@"storeTeamsArray"];
        [DNPStoreSettings synchronize];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showErrorAlert {
    //TODO: set up correct message alert
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Error"
                                message:NSLocalizedString(@"errorPosting", @"")
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString(@"titleHeader", @"");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.pokeFactsOptions objectAtIndex:indexPath.row]];
    cell.textLabel.font = [UIFont fontWithName:@"PokemonGB" size:14.0f];
    
    for (NSNumber *storeIndex in self.selectedIndex) {
        if (indexPath.row == storeIndex.intValue) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(indexPath.row == 0) {
        
        for(int i = 0; i < self.pokeFactsOptions.count; i++) {
            NSIndexPath * indexOne = [NSIndexPath indexPathForItem:i inSection:0];
            UITableViewCell *cellOne = [tableView cellForRowAtIndexPath:indexOne];
            cellOne.accessoryType = UITableViewCellAccessoryNone;
        }
        
        [self.selectedIndex removeAllObjects];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectedIndex addObject:[NSNumber numberWithInteger:indexPath.row]];
        
    } else {
        
            NSIndexPath * indexOne = [NSIndexPath indexPathForItem:0 inSection:0];
            UITableViewCell *cellOne = [tableView cellForRowAtIndexPath:indexOne];
            
            if(cellOne.accessoryType == UITableViewCellAccessoryCheckmark) {
                cellOne.accessoryType = UITableViewCellAccessoryNone;
                [self.selectedIndex removeObject:[NSNumber numberWithInteger:0]];
            }
            //index for all section
            if(cell.accessoryType == UITableViewCellAccessoryCheckmark) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self.selectedIndex removeObject:[NSNumber numberWithInteger:indexPath.row]];
            }
            else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [self.selectedIndex addObject:[NSNumber numberWithInteger:indexPath.row]];
            }
        
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* uncheckCell = [tableView
                                    cellForRowAtIndexPath:indexPath];
    uncheckCell.accessoryType = UITableViewCellAccessoryNone;
}

@end
