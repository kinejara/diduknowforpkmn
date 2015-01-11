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
@property (nonatomic, strong) NSString *sharingText;
@property (nonatomic, strong) UIButton *menuButton;

@end

@implementation DNPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor pkmn_systemRedColor];
    [self configureTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadPokeFacts];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self countRunTimes];
}

- (void)configureTableView {
    UIColor *clearColor = [UIColor clearColor];
    self.tableView.backgroundColor = clearColor;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = NO;
}

- (void)loadPokeFacts {
    
    NSArray *gens = DNPStoreGenerations;
    
    if (self.pokeFacts.count > 0) {
        [self.pokeFacts removeAllObjects];
    }
    
    Pharases *pokeFacts = [Pharases new];
    NSArray *pokeFactsArray = [pokeFacts createArrayOfPokePhrasesWithGenerations:gens];
    
    self.pokeFacts = [NSMutableArray shuffleArray:pokeFactsArray];
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
    [self.tableView reloadData];
}

- (NSArray *)getStoreSettings {
    
    NSArray *settings;
    
    if(![DNPStoreSettings objectForKey:@"storeTeamsArray"]) {
        
        settings = [[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:0], nil];
        [DNPStoreSettings setObject:settings forKey:@"storeTeamsArray"];
        [DNPStoreSettings synchronize];
    } else {
        settings = [DNPStoreSettings arrayForKey:@"storeTeamsArray"];
    }
    
    return settings;
}

- (void)countRunTimes {
    NSInteger runTimeCounter = [DNPStoreSettings integerForKey:@"runTimeCounter"];
    
    if (runTimeCounter <= 3) {
        runTimeCounter = runTimeCounter + 1;
    } else {
        runTimeCounter = 0;
        [self askForRateThisApp];
    }
    
    [DNPStoreSettings setInteger:runTimeCounter forKey:@"runTimeCounter"];
    [DNPStoreSettings synchronize];
}

- (void)askForRateThisApp {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"★★★★★" message:NSLocalizedString(@"rate", @"") preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"cancel", @"")
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action)
                             {
                                 [alertController dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self didTapRate];
                         }];
    
    [alertController addAction:ok];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didTapMenu:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"options", @"")
                                                                             message:@""
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction
                         actionWithTitle:NSLocalizedString(@"cancel", @"")
                         style:UIAlertActionStyleCancel
                         handler:^(UIAlertAction * action)
                         {
                             [alertController dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    UIAlertAction *refresh = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"refresh", @"")
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self loadPokeFacts];
                             }];
    
    UIAlertAction *visitFB = [UIAlertAction
                           actionWithTitle:NSLocalizedString(@"fb", @"")
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               NSURL *url = [NSURL URLWithString:@"fb://profile/133666066840052"];
                               [[UIApplication sharedApplication] openURL:url];
                           }];
    
    UIAlertAction *rate = [UIAlertAction
                           actionWithTitle:NSLocalizedString(@"rateApp", @"")
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               [self didTapRate];
                           }];
    
    UIAlertAction *settings = [UIAlertAction
                           actionWithTitle:NSLocalizedString(@"settings", @"")
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               [self goToSettings];
                           }];
    
    [alertController addAction:refresh];
    [alertController addAction:visitFB];
    [alertController addAction:rate];
    [alertController addAction:settings];
    [alertController addAction:cancel];
    
    if (IS_IPAD) {
        
        UIPopoverPresentationController *popPresenter = [alertController
                                                         popoverPresentationController];
        popPresenter.sourceView = self.menuButton;
        popPresenter.sourceRect = self.menuButton.bounds;
    }
   
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)goToSettings {
    [self performSegueWithIdentifier:@"goSettings" sender:self];
}

- (void)didTapRate {
    NSString * urlString = [NSString stringWithFormat:@"https://itunes.apple.com/es/app/did-you-know-for-pokemon/id608028683?mt=8"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark share methods

- (void)didTapShare {
    
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_queue_create("openActivityIndicatorQueue", NULL);
    
    dispatch_async(queue, ^{
    
        UIActivityViewController *shareViewController = [[UIActivityViewController alloc]initWithActivityItems:@[weakSelf, [UIImage imageNamed:@"icon_76"]] applicationActivities:nil];
        
        [shareViewController setCompletionWithItemsHandler:^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
            if(activityError) {
                [weakSelf showErrorAlert];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (IS_IPAD) {
                
                UIPopoverPresentationController *popPresenter = [shareViewController
                                                                 popoverPresentationController];
                popPresenter.sourceView = weakSelf.menuButton;
                popPresenter.sourceRect = weakSelf.menuButton.bounds;
            }
            
            [weakSelf presentViewController:shareViewController animated:YES completion:nil];
        });
        
    });
}

- (void)showErrorAlert {
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

- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    return @"";
}

- (id)activityViewController:(UIActivityViewController *)activityViewController
         itemForActivityType:(NSString *)activityType
{
    NSString *message = nil;
    if ([activityType isEqualToString:UIActivityTypeMail]) {
        
        message = [NSString stringWithFormat:@"<html><body>%@</br></br></br> via <a href='https://itunes.apple.com/us/app/did-you-know-for-pokemon/id608028683?ls=1&mt=8'>Did you know Pokemon</a> </body></html>",self.sharingText];
        
    } else if ([activityType isEqualToString:UIActivityTypeMessage]) {
        message = self.sharingText;
    } else if ([activityType isEqualToString:UIActivityTypePostToFacebook]) {
        
        message = [NSString stringWithFormat:@"%@ via %@",self.sharingText,[NSURL URLWithString:@"https://itunes.apple.com/us/app/did-you-know-for-pokemon/id608028683?ls=1&mt=8"]];
        
    } else if ([activityType isEqualToString:UIActivityTypePostToTwitter]) {
        message = self.sharingText;
    } else {
        message = self.sharingText;
    }
    return message;
}


- (NSString *)activityViewController:(UIActivityViewController *)activityViewController
subjectForActivityType:(NSString *)activityType
{
    return @"";
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
    
    CGFloat tableViewWidht = self.tableView.frame.size.width;
    
    UIImage *footerImage = [UIImage imageNamed:@"pokedex_footer"];
    UIImageView *footerImgView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableViewWidht, 160)];
    footerImgView.image = footerImage;
   
    UIView *footerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableViewWidht, 160)];
    footerView.backgroundColor = [UIColor redColor];
    [footerView addSubview:footerImgView];
    
    UIButton *optionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    optionButton.frame = CGRectMake(0 , 10, 36, 32);
    optionButton.center = footerView.center;
    
    CGRect optionButtonFrame = optionButton.frame;
    optionButtonFrame.origin.y = 8;
    optionButton.frame = optionButtonFrame;
    
    [optionButton setBackgroundImage:[UIImage imageNamed:@"action2"] forState:UIControlStateNormal];
    [optionButton setBackgroundImage:[UIImage imageNamed:@"action_icon"] forState:UIControlStateHighlighted];
    
    [optionButton addTarget:self action:@selector(didTapMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:optionButton];
    
    self.menuButton = optionButton;
    
    return footerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * cellText = [self.pokeFacts objectAtIndex:indexPath.row];
    CGSize constrain = CGSizeMake(100, 2000);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14.0] forKey:NSFontAttributeName];
    
    CGRect textSize = [cellText boundingRectWithSize:constrain
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributes
                                      context:nil];
    
    float textHeight = textSize.size.height +20;
    textHeight = (textHeight < 50.0) ? 50.0:textHeight;
    
    return textHeight;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.sharingText = cell.textLabel.text;
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self didTapShare];
}

@end
