//
//  StateDetailViewController.m
//  sc00-StatesAndFlags
//
//  Created by Entec Department on 11/2/16.
//  Copyright © 2016 COP2654. All rights reserved.
//

#import "StateDetailViewController.h"
#import "SearchResultTableViewController.h"

@interface StateDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailFlagImage;
@property (weak, nonatomic) IBOutlet UILabel *detailStateName;
@property (weak, nonatomic) IBOutlet UILabel *detailStateMotto;
@property (weak, nonatomic) IBOutlet UILabel *detailStateCapital;
@property (weak, nonatomic) IBOutlet UILabel *statePopulation;
@property (weak, nonatomic) IBOutlet UILabel *area;

@end

@implementation StateDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.detailFlagImage.image = _myState.flag;
    self.detailStateName.text = _myState.name;
    self.detailStateMotto.text = _myState.motto;
    self.detailStateCapital.text = _myState.capital;
    
    // add a title to the Details View
    self.navigationItem.title = _myState.name;
    
    
    // add additional information
    if ([_myState.name isEqualToString:@"Alabama"]){
        self.area.text = @"Area: 52,419";
        self.statePopulation.text = @"Population: 4.8 million";
    } else if ([_myState.name isEqualToString:@"Georgia"]){
        self.area.text = @"Area: 59,425";
        self.statePopulation.text = @"Population: 10.1 million";
    }else if ([_myState.name isEqualToString:@"Florida"]){
        self.area.text = @"Area: 65,750";
        self.statePopulation.text = @"Population: 19 million";
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
