//
//  StateTableViewCell.h
//  sc00-StatesAndFlags
//
//  Created by Entec Department on 11/2/16.
//  Copyright © 2016 COP2654. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@property (weak, nonatomic) IBOutlet UILabel *stateName;
@property (weak, nonatomic) IBOutlet UILabel *stateMotto;

@end
