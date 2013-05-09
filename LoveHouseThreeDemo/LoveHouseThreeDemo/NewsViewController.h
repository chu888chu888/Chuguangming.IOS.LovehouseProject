//
//  NewsViewController.h
//  LoveHouseThreeDemo
//
//  Created by chuguangming on 11-10-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    //新闻标题
	NSMutableArray *DataArray;
    //新闻附标题
    NSMutableArray *DataDetailArray;
    //新闻图片
    NSMutableArray *DataImageArray;
    //导航条
    IBOutlet UINavigationItem *newItem;
    IBOutlet UINavigationBar *newBar;
    //导航条的文本
    IBOutlet UILabel *lblNews;
    
}
@property (nonatomic, retain) NSMutableArray *DataArray;
@property (nonatomic, retain) NSMutableArray *DataDetailArray;
@property (nonatomic, retain) NSMutableArray *DataImageArray;
@property (nonatomic, retain) UINavigationItem *newItem;
@property (nonatomic, retain) UINavigationBar *newBar;
@property (nonatomic, retain) UILabel *lblNews;
-(void)initData;
@end
