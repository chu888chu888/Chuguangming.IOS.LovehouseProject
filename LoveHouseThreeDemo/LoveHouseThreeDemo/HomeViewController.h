//
//  HomeViewController.h
//  LoveHouseThreeDemo
//
//  Created by chuguangming on 11-10-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeViewController : UIViewController {
    NSTimer *timer;
    IBOutlet UILabel *lblDay;
    IBOutlet UILabel *lblHour;
    IBOutlet UILabel *lblMin;
    IBOutlet UILabel *lblSec;
}
@property(nonatomic,retain) UILabel *lblDay;
@property(nonatomic,retain) UILabel *lblHour;
@property(nonatomic,retain) UILabel *lblMin;
@property(nonatomic,retain) UILabel *lblSec;
@end
