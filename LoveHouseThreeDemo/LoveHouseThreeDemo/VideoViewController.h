//
//  VideoViewController.h
//  LoveHouseThreeDemo
//
//  Created by chuguangming on 11-10-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VideoViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    UITableView *DataTable;
    UISegmentedControl *segmentedControlforMonth;
    UISegmentedControl *segmentedControlforType;
    
    //新闻标题
	NSMutableArray *DataVideoArray;
    //新闻附标题
    NSMutableArray *DataVideoDetailArray;
    //新闻图片
    NSMutableArray *DataVideoImageArray;
}
@property (nonatomic,retain) IBOutlet UISegmentedControl *segmentedControlforMonth;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segmentedControlforType;

@property (nonatomic, retain) UITableView *DataTable;

@property (nonatomic, retain) NSMutableArray *DataVideoArray;
@property (nonatomic, retain) NSMutableArray *DataVideoDetailArray;
@property (nonatomic, retain) NSMutableArray *DataVideoImageArray;

-(IBAction) segmentedControlMonthIndexChanged;
-(IBAction) segmentedControlTypeIndexChanged;
-(void)initData:(NSInteger) index;



@end
