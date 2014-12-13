//
//  ViewController.m
//  DidYouKnowForPokemon8
//
//  Created by Jorge Kinejara on 12/12/14.
//  Copyright (c) 2014 kine. All rights reserved.
//

#import "DNPMainViewController.h"

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
    self.pokeFacts = @[@"1",@"2",@"3"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
     
     cell.textLabel.text = self.pokeFacts[indexPath.row];
 
     return cell;
}


@end
