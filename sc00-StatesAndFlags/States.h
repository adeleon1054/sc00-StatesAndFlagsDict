//
//  States.h
//  sc00-StatesAndFlags
//
//  Created by Entec Department on 11/2/16.
//  Copyright © 2016 COP2654. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface States : NSObject
@property (nonatomic, strong) NSString* name;    // state name
@property (nonatomic, strong) NSString* capital; // capital city
@property (nonatomic, strong) NSString* motto;   // latin motto
@property (nonatomic, strong) UIImage* flag;     // state's flag image
@end
