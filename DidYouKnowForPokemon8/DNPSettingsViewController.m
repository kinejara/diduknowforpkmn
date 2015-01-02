//
//  DNPSettingsViewController.m
//  DidYouKnowForPokemon8
//
//  Created by Jorge Villa on 12/30/14.
//  Copyright (c) 2014 kine. All rights reserved.
//

#import "DNPSettingsViewController.h"

@interface DNPSettingsViewController ()

@end

@implementation DNPSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
