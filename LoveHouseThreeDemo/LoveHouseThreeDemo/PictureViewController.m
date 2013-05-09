//
//  PictureViewController.m
//  LoveHouseThreeDemo
//
//  Created by chuguangming on 11-10-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PictureViewController.h"
#import "PictureCellView.h"

@implementation PictureViewController
@synthesize segmentedControlforType,segmentedControlforMonth;
@synthesize DataTable,DataPicArray,DataPicDetailArray,DataPicImageArray;

//初始化数据：从plist文件中读取数据
-(void)initData:(NSInteger) id{
    self.DataPicArray=[[NSMutableArray alloc] init];
    self.DataPicDetailArray=[[NSMutableArray alloc] init];
    self.DataPicImageArray=[[NSMutableArray alloc] init];
    NSString *fileName;
    switch(id)
    {
        case 1:
            NSLog(@"1");
            fileName = [[NSBundle mainBundle]pathForResource:@"videoData1full"
                                                      ofType:@"plist"];
            break;
        case 2:
            fileName = [[NSBundle mainBundle]pathForResource:@"videoData1part"
                                                      ofType:@"plist"];
            break;
        case 3:
            fileName = [[NSBundle mainBundle]pathForResource:@"videoData2full"
                                                      ofType:@"plist"];
            break;
        case 4:
            fileName = [[NSBundle mainBundle]pathForResource:@"videoData2part"
                                                      ofType:@"plist"];
            break;
        case 5:
            fileName = [[NSBundle mainBundle]pathForResource:@"videoData3full"
                                                      ofType:@"plist"];
            break;
        case 6:
            fileName = [[NSBundle mainBundle]pathForResource:@"videoData3part"
                                                      ofType:@"plist"];
            break;
            
    }
    
    NSDictionary *dic = [[[NSDictionary alloc]initWithContentsOfFile:fileName]autorelease];
    NSArray *bookListDataSource = [dic objectForKey:@"NewsList"];
    for (int i=0; i<[bookListDataSource count]; i++) {
        NSDictionary *bookListItem = [bookListDataSource objectAtIndex:i];
        
        NSString *Title = [bookListItem objectForKey:@"Title"];
        NSString *DetailTitle = [bookListItem objectForKey:@"DetailTitle"];
        NSString *Picture = [bookListItem objectForKey:@"Picture"];
        [DataPicArray addObject:Title];
        [DataPicDetailArray addObject:DetailTitle];
        [DataPicImageArray addObject:Picture];
        NSLog(@"%@",Title);
    } 
    NSLog(@"%i",[DataPicArray count]);
}

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
    [segmentedControlforType release];
    [segmentedControlforMonth release];
    [DataTable release];
    [DataPicArray release];
    [DataPicDetailArray release];
    [DataPicImageArray release];
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
    
    
    [self initData:1];
    DataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, 480-44-49-2) style:UITableViewStylePlain];
	[DataTable setDelegate:self];
	[DataTable setDataSource:self];
	[self.view addSubview:DataTable];
	[DataTable release];
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
//Segment change
-(IBAction) segmentedControlMonthIndexChanged
{
    switch (self.segmentedControlforMonth.selectedSegmentIndex) {
        case 0:
            if (self.segmentedControlforType.selectedSegmentIndex==0) {
                [self initData:1];
                NSLog(@"第一季完全版");
            }
            else
            {
                [self initData:2];
                NSLog(@"第一季片段版");
            }
            break;
        case 1:
            if (self.segmentedControlforType.selectedSegmentIndex==0) {
                [self initData:3];
                NSLog(@"第2季完全版");
            }
            else
            {
                [self initData:4];
                NSLog(@"第2季片段版");
            }
            break;
        case 2:
            if (self.segmentedControlforType.selectedSegmentIndex==0) {
                [self initData:5];
                NSLog(@"第3季完全版");
            }
            else
            {
                [self initData:6];
                NSLog(@"第3季片段版");
            }
            break;
    }
    NSLog(@"OK");
    
	[DataTable endUpdates];
	[DataTable reloadData];
    
}
-(IBAction) segmentedControlTypeIndexChanged
{
    //    switch (self.segmentedControlforType.selectedSegmentIndex) {
    //        case 0:
    //            break;
    //        case 1:
    //            break;
    //        default:
    //            break;
    //    }
    //    NSLog(@"OK2");
}
//表格
//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [DataPicArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *SimpleTableIdentifier = [NSString stringWithFormat: @"SimpleTableIdentifier%i%i",indexPath.section,indexPath.row];
    
    
    //NSString *id = @"HomeCellIdentifier";
    
    PictureCellView *cell = (PictureCellView *)([tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier]);
    if (cell == nil) {
        //        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
        //                                       reuseIdentifier:id];
        
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"PictureCellView"
                                                     owner:self
                                                   options:nil];
        cell = [nibs objectAtIndex:0];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

//选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger row = indexPath.row;
	NSLog(@"%@",[DataPicArray objectAtIndex:row]);
	//[tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
}

@end
