//
//  NewsViewController.m
//  LoveHouseThreeDemo
//
//  Created by chuguangming on 11-10-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"

@implementation NewsViewController
@synthesize DataDetailArray,DataImageArray, DataArray;
@synthesize newItem,newBar,lblNews;

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
    
	[DataArray release];
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
    //定自义导航条的文本与字体
    //    lblNews.font=[UIFont fontWithName:@"MSYH.TTF" size:38.0];
    //    lblNews.text=@"新闻";
    
    self.DataArray=[[NSMutableArray alloc] init];
    self.DataDetailArray=[[NSMutableArray alloc] init];
    self.DataImageArray=[[NSMutableArray alloc] init];
    [super viewDidLoad];
    //初始化数据
    [self initData];
    
}
//初始化数据：从plist文件中读取数据
-(void)initData{
    
    NSString *fileName = [[NSBundle mainBundle]pathForResource:@"NewsData"
                                                        ofType:@"plist"];
    NSDictionary *dic = [[[NSDictionary alloc]initWithContentsOfFile:fileName]autorelease];
    NSArray *bookListDataSource = [dic objectForKey:@"NewsList"];
    for (int i=0; i<[bookListDataSource count]; i++) {
        NSDictionary *bookListItem = [bookListDataSource objectAtIndex:i];
        
        NSString *Title = [bookListItem objectForKey:@"Title"];
        NSString *DetailTitle = [bookListItem objectForKey:@"DetailTitle"];
        NSString *Picture = [bookListItem objectForKey:@"Picture"];
        [DataArray addObject:Title];
        [DataDetailArray addObject:DetailTitle];
        [DataImageArray addObject:Picture];
    } 
    NSLog(@"%i",DataArray.count);
    
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
//表格实现方法
//返回为1，说明为段为1
//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
	return [DataArray count]+1;
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
    if (row==[DataArray count]) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: SimpleTableIdentifier] autorelease];
        cell.textLabel.text=[NSString stringWithFormat:@"共用%i条数据",row+1];
        cell.textLabel.textAlignment=UITextAlignmentCenter;
    }
    else
    {
        cell.textLabel.text = [DataArray objectAtIndex:row];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.font = [UIFont systemFontOfSize:22];
        //cell.textLabel.font= [UIFont fontWithName:@"MSYH.TTF" size:25.0];
        cell.imageView.image = [UIImage imageNamed:[DataImageArray objectAtIndex:row]];
        cell.detailTextLabel.text = [DataDetailArray objectAtIndex:row];
        cell.detailTextLabel.lineBreakMode=UILineBreakModeWordWrap;
        //cell.detailTextLabel.font=[UIFont fontWithName:@"MSYH.TTF" size:5.0];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
	return cell;
}


//选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger row = indexPath.row;
	NSLog(@"%@",[DataArray objectAtIndex:row]);
	//[tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
}
@end
