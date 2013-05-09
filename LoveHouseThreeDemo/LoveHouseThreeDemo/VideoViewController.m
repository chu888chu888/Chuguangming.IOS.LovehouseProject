//
//  VideoViewController.m
//  LoveHouseThreeDemo
//
//  Created by chuguangming on 11-10-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "VideoViewController.h"


@implementation VideoViewController
@synthesize segmentedControlforType,segmentedControlforMonth;
@synthesize DataTable,DataVideoArray,DataVideoDetailArray,DataVideoImageArray;
////自定义的方法

//初始化数据：从plist文件中读取数据
-(void)initData:(NSInteger) id{
    self.DataVideoArray=[[NSMutableArray alloc] init];
    self.DataVideoDetailArray=[[NSMutableArray alloc] init];
    self.DataVideoImageArray=[[NSMutableArray alloc] init];
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
        [DataVideoArray addObject:Title];
        [DataVideoDetailArray addObject:DetailTitle];
        [DataVideoImageArray addObject:Picture];
        NSLog(@"%@",Title);
    } 
    NSLog(@"%i",[DataVideoArray count]);
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
    [DataVideoArray release];
    [DataVideoDetailArray release];
    [DataVideoImageArray release];
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
	return [DataVideoArray count]+1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger row = indexPath.row;
	//static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	NSString *SimpleTableIdentifier = [NSString stringWithFormat: @"SimpleTableIdentifier%i%i",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {		
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier: SimpleTableIdentifier] autorelease];
	}
    if (row==[DataVideoArray count]) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: SimpleTableIdentifier] autorelease];
        cell.textLabel.text=[NSString stringWithFormat:@"共用%i条数据",row+1];
        cell.textLabel.textAlignment=UITextAlignmentCenter;
    }
    else
    {
        cell.textLabel.text = [DataVideoArray objectAtIndex:row];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.font = [UIFont systemFontOfSize:22];
        //cell.textLabel.font= [UIFont fontWithName:@"MSYH.TTF" size:25.0];
        cell.imageView.image = [UIImage imageNamed:[DataVideoImageArray objectAtIndex:row]];
        cell.detailTextLabel.text = [DataVideoDetailArray objectAtIndex:row];
        cell.detailTextLabel.lineBreakMode=UILineBreakModeWordWrap;
        //cell.detailTextLabel.font=[UIFont fontWithName:@"MSYH.TTF" size:5.0];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
	return cell;
}


//选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger row = indexPath.row;
	NSLog(@"%@",[DataVideoArray objectAtIndex:row]);
	//[tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
}

@end
