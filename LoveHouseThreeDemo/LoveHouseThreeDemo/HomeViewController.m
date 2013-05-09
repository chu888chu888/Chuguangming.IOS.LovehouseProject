//
//  HomeViewController.m
//  LoveHouseThreeDemo
//
//  Created by chuguangming on 11-10-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"


@implementation HomeViewController
@synthesize lblDay,lblHour,lblMin,lblSec;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //定时执行得到时间
    timer=[NSTimer scheduledTimerWithTimeInterval:1 
                                           target:self 
                                         selector:@selector(getResults) 
                                         userInfo:nil 
                                          repeats:YES]; 
    //得到间隔时间
    //NSDate，类似java里面的Date对象，是对从1970-1-1毫秒数的封装，可记录时间；
    //NSDateFormatter，类似java中的DateFormat相关的api，
    //用于日期对象的格式化或者字符串解析为日期对象
    //首先，创建一个日期格式化对象：
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init]; 
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //然后，创建了两个日期对象：
    NSDate *date1=[dateFormatter dateFromString:@"2010-3-3 11:00"]; 
    NSDate *date2=[dateFormatter dateFromString:@"2010-12-4 12:00"];
    //创建日期对象，是通过字符串解析的。
    //然后取两个日期对象的时间间隔：
    // 这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    int days=((int)time)/(3600*24); 
    int hours=((int)time)%(3600*24)/3600; 
    //再然后，把间隔的秒数折算成天数和小时数：
    NSString *dateContent=[[NSString alloc] initWithFormat:@"%i 天 %i 小时",days,hours];
    
    lblDay.text=dateContent;
    
}
-(void)getResults{ 
    
    //[timer invalidate]; 
    //NSLog(@"tt");
    NSDate *now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *dd = [cal components:unitFlags fromDate:now]; 
    //    int y = [dd year];
    //    int m = [dd month];
    //    int d = [dd day];
    //    int week = [dd weekday];
    
    int hour = [dd hour];
    int minute = [dd minute];
    int second = [dd second];
    lblHour.text=[[NSString alloc] initWithFormat:@"%i",hour];
    lblMin.text=[[NSString alloc] initWithFormat:@"%i",minute];
    lblSec.text=[[NSString alloc] initWithFormat:@"%i",second];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
