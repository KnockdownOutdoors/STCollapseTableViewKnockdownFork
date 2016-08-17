//
//  ViewController.m
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import "ViewController.h"

#import "STCollapseTableViewKnockdownFork.h"

@interface ViewController () <UITableViewDataSource, STCollapseTableViewKnockdownForkDelegate>

@property (weak, nonatomic) IBOutlet STCollapseTableView *tableView;

@property (nonatomic, strong) NSMutableArray* data;
@property (nonatomic, strong) NSMutableArray* headers;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self setupViewController];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupViewController];
    }
    return self;
}

- (void)setupViewController
{
    NSArray* colors = @[[UIColor clearColor],
                        [UIColor clearColor],
                        [UIColor clearColor],
                        [UIColor clearColor],
                        [UIColor clearColor],
                        [UIColor clearColor]];
    
    self.data = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [colors count] ; i++)
    {
        NSMutableArray* section = [[NSMutableArray alloc] init];
        for (int j = 0 ; j < 24 ; j++)
        {
            [section addObject:[NSString stringWithFormat:@"Cell n°%i", j]];
        }
        [self.data addObject:section];
    }
    
    self.headers = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [colors count] ; i++)
    {
        UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [header setBackgroundColor:[colors objectAtIndex:i]];
        [self.headers addObject:header];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView reloadData];
    _tableView.cellShouldDisappear = YES;
    [self.tableView openSection:0 animated:NO];
}

- (IBAction)handleExclusiveButtonTap:(UIButton*)button
{
    [self.tableView setExclusiveSections:!self.tableView.exclusiveSections];
    
    [button setTitle:self.tableView.exclusiveSections?@"exclusive":@"!exclusive" forState:UIControlStateNormal];
}

-(void)scrollViewScrolled:(UIScrollView *)scrollView {
    NSLog(@"scrolled");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [self.data count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* cellIdentifier = @"cell";
	
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (!cell)
    {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	}
	
	NSString* text = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	cell.textLabel.text = text;
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[self.data objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [self.headers objectAtIndex:section];
    
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.text = [NSString stringWithFormat:@"Section: %ld", (long)section];
    label.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:label];
    
    return view;
}

@end
