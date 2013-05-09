//
//  PictureViewController.h
//  LoveHouseThreeDemo
//
//  Created by chuguangming on 11-10-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PictureViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    UITableView *DataTable;
    UISegmentedControl *segmentedControlforMonth;
    UISegmentedControl *segmentedControlforType;
    
    //标题
	NSMutableArray *DataPicArray;
    //附标题
    NSMutableArray *DataPicDetailArray;
    //图片
    NSMutableArray *DataPicImageArray;
}
@property (nonatomic,retain) IBOutlet UISegmentedControl *segmentedControlforMonth;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segmentedControlforType;

@property (nonatomic, retain) UITableView *DataTable;

@property (nonatomic, retain) NSMutableArray *DataPicArray;
@property (nonatomic, retain) NSMutableArray *DataPicDetailArray;
@property (nonatomic, retain) NSMutableArray *DataPicImageArray;

-(IBAction) segmentedControlMonthIndexChanged;
-(IBAction) segmentedControlTypeIndexChanged;
-(void)initData:(NSInteger) index;

@end
