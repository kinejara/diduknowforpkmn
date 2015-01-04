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

typedef NS_ENUM(NSInteger, DNPSettingTableSections) {
    sectionForPush = 0,
    sectionForWidget,
    sectionForGeneration
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
    
    if([DNPStoreSettings objectForKey:@"storeTeamsArray"]) {
        NSArray *storeArray = [DNPStoreSettings objectForKey:@"storeTeamsArray"];
        self.selectedIndex = [[NSMutableArray alloc] initWithArray:storeArray];
    }
    else {
        self.selectedIndex = [[NSMutableArray alloc] init];
    }
}


- (void)customizingNavigationBar {
    self.navigationController.navigationBar.barTintColor = [UIColor pkmn_systemBlueColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"Settings";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(didTapCancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(didTapSave)];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.pokeFactsOptions objectAtIndex:indexPath.row]];
    cell.textLabel.font = [UIFont fontWithName:@"PokemonGB" size:14.0f];
    
    for(NSString * n in self.selectedIndex) {
        if([cell.textLabel.text isEqualToString:n]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(indexPath.row == 0) {
        
        for(int i = 0; i < self.pokeFactsOptions.count; i++) {
            NSIndexPath * indexOne = [NSIndexPath indexPathForItem:i inSection:2];
            UITableViewCell *cellOne = [tableView cellForRowAtIndexPath:indexOne];
            cellOne.accessoryType = UITableViewCellAccessoryNone;
        }
        
        [self.selectedIndex removeAllObjects];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectedIndex addObject:[self.pokeFactsOptions objectAtIndex:0]];
        
    } else {
            NSIndexPath * indexOne = [NSIndexPath indexPathForItem:0 inSection:2];
            UITableViewCell *cellOne = [tableView cellForRowAtIndexPath:indexOne];
            
            if(cellOne.accessoryType == UITableViewCellAccessoryCheckmark) {
                cellOne.accessoryType = UITableViewCellAccessoryNone;
                [self.selectedIndex removeObject:[self.pokeFactsOptions objectAtIndex:0]];
            }
            //index for all section
            if(cell.accessoryType == UITableViewCellAccessoryCheckmark) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self.selectedIndex removeObject:[self.pokeFactsOptions objectAtIndex:indexPath.row]];
            }
            else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [self.selectedIndex addObject:[self.pokeFactsOptions objectAtIndex:indexPath.row]];
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
