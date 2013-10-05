//
//  FoodListController.m
//  ForageriOS
//
//  Created by Joseph Milsom on 20/07/13.
//  Copyright (c) 2013 Joseph Milsom. All rights reserved.
//

#import "FoodListController.h"
#import "FoodItemCell.h"
#import "RecipeController.h"
#import "MapController.h"
#import "InfoController.h"

@interface FoodListController () 
@property (nonatomic, retain) NSArray *images;
- (IBAction)changeRecipeView:(id)sender;
- (IBAction)showInfo:(id)sender;
- (IBAction)displayLocations:(id)sender;
 //dynamic array for storing which cells have been selected and expanded
@property (nonatomic, retain) NSMutableArray *expandedPaths;
@property (nonatomic, retain) NSString *foodName;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)splitViewTrigger:(id *)sender;
@property (weak, nonatomic) IBOutlet UIView *splitView;
@property (weak, nonatomic) IBOutlet UIView *navBar;
@property (weak, nonatomic) IBOutlet UIView *tableCellBlocker;
@property (nonatomic) BOOL *isSplitViewOpen;
@end

@implementation FoodListController




- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView setShowsVerticalScrollIndicator:NO]; // may want to keep this??
   // self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.expandedPaths = [[NSMutableArray alloc]init];
    self.images = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"imagelocations" ofType:@"plist"]];
    self.isSplitViewOpen = NO;
    UIPanGestureRecognizer *drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragTableCellBlocker:)];
    drag.minimumNumberOfTouches = 1;
    drag.delegate = self;
    [self.tableCellBlocker addGestureRecognizer:drag];
    UIPanGestureRecognizer *dragTable = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragTable:)];
    dragTable.minimumNumberOfTouches = 1;
    dragTable.delegate = self;
    [self.tableView addGestureRecognizer:dragTable];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // NSLog(@"%d",  self.images.count);
    return self.images.count;
}


//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{    

    if ([self.expandedPaths containsObject:indexPath]) {
        return 178.0;
    } else {
        return 134.0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    FoodItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FoodItemCell" owner:self options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (FoodItemCell *)currentObject;
                break;
            }
        }
    }
    
	NSString *imageLocation = [self.images objectAtIndex:indexPath.row];
	cell.foodItemImage.image = [UIImage imageNamed:imageLocation];
    cell.foodItem = imageLocation;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   
    //Adding or removing to the list of items that pop up windows are open or closed 
    if ([self.expandedPaths containsObject:indexPath]) {
        [self.expandedPaths removeObject:indexPath];
    }
    else {
        [self.expandedPaths addObject:indexPath];
    }

    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    //can change animation to UITableViewRowAnimationFade for visual cue
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"RecipeSegue"]){
        RecipeController *controller = (RecipeController *)segue.destinationViewController;
        controller.recipeName = self.foodName;
    }
    if([segue.identifier isEqualToString:@"MapSegue"]){
        MapController *controller = (MapController *)segue.destinationViewController;
        controller.mapName = self.foodName;
    }
    if([segue.identifier isEqualToString:@"InfoSegue"]){
        InfoController *controller = (InfoController *)segue.destinationViewController;
        controller.infoName = self.foodName;
    }
}

- (IBAction)changeRecipeView:(id)sender {
    UIButton *button = (UIButton*)sender;
    UIView *view = button.superview; 
    FoodItemCell *cell = (FoodItemCell *)view.superview;
   // NSLog(@"Recipe :%@", cell.foodItem);
    self.foodName = cell.foodItem;
    [self performSegueWithIdentifier: @"RecipeSegue" sender: self];
}

- (IBAction)showInfo:(id)sender {
    UIButton *button = (UIButton*)sender;
    UIView *view = button.superview;
    FoodItemCell *cell = (FoodItemCell *)view.superview;
   // NSLog(@"Show Info for:%@", cell.foodItem);
    self.foodName = cell.foodItem;
    [self performSegueWithIdentifier: @"InfoSegue" sender: self];
}

- (IBAction)displayLocations:(id)sender {
    UIButton *button = (UIButton*)sender;
    UIView *view = button.superview;
    FoodItemCell *cell = (FoodItemCell *)view.superview;
    //NSLog(@"Location for :%@", cell.foodItem);
    self.foodName = cell.foodItem;
    [self performSegueWithIdentifier: @"MapSegue" sender: self];
}
- (IBAction)splitViewTrigger:(id *)sender {
    CGRect frame= self.tableView.frame;
    CGRect navBarFrame = self.navBar.frame;
    CGRect tableBlocker = self.tableCellBlocker.frame;
    if(self.isSplitViewOpen == NO){
    self.isSplitViewOpen = YES;
         tableBlocker.origin.x = 200;
        self.tableCellBlocker.frame = tableBlocker;
        [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    frame.origin.x = 200;
    navBarFrame.origin.x = 200;
    self.tableView.frame = frame;
    self.navBar.frame = navBarFrame;
    [UIView commitAnimations];
    }
    else{
         self.isSplitViewOpen = NO;
        tableBlocker.origin.x = 320;
        self.tableCellBlocker.frame = tableBlocker;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        frame.origin.x = 0;
        navBarFrame.origin.x = 0;
        self.tableView.frame = frame;
        self.navBar.frame = navBarFrame;
        [UIView commitAnimations];
    }
}


- (void) dragTableCellBlocker:
(UIPanGestureRecognizer*)dragGesture{
    CGRect frame= self.tableView.frame;
    CGRect navBarFrame = self.navBar.frame;
    CGRect tableBlocker = self.tableCellBlocker.frame;
    //self.isSplitViewOpen = NO;
    self.tableCellBlocker.frame = tableBlocker;
    CGPoint pos = [dragGesture translationInView:self.tableCellBlocker];
    float xPos = pos.x+200;
    if(dragGesture.state != UIGestureRecognizerStateEnded){

    if(xPos > 200){
        xPos = 200;
    }
    if(xPos < 0){
        xPos = 0;
    }
    frame.origin.x = xPos;
    navBarFrame.origin.x = xPos;
    self.tableView.frame = frame;
    self.navBar.frame = navBarFrame;
    }
    else if(dragGesture.state == UIGestureRecognizerStateEnded){
        if(xPos > 100){
            tableBlocker.origin.x = 200;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.2];
            frame.origin.x = 200;
            navBarFrame.origin.x = 200;
            self.tableView.frame = frame;
            self.navBar.frame = navBarFrame;
            [UIView commitAnimations];
        }
        else{
        tableBlocker.origin.x = 320;
        [self splitViewTrigger:nil];
        }
    }
}

- (void) dragTable:
(UIPanGestureRecognizer*)dragGesture{
    CGRect frame= self.tableView.frame;
    CGRect navBarFrame = self.navBar.frame;
    CGRect tableBlocker = self.tableCellBlocker.frame;
    self.tableCellBlocker.frame = tableBlocker;
    CGPoint pos = [dragGesture translationInView:self.tableView];
    float xPos = pos.x;
    if(dragGesture.state != UIGestureRecognizerStateEnded){        
        if(xPos > 200){
            xPos = 200;
        }
        if(xPos < 0){
            xPos = 0;
        }
        frame.origin.x = xPos;
        navBarFrame.origin.x = xPos;
        self.tableView.frame = frame;
        self.navBar.frame = navBarFrame;
    }
    else if(dragGesture.state == UIGestureRecognizerStateEnded){
        if(xPos < 100){
            tableBlocker.origin.x = 320;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.2];
            frame.origin.x = 0;
            navBarFrame.origin.x = 0;
            self.tableView.frame = frame;
            self.navBar.frame = navBarFrame;
            [UIView commitAnimations];
        }
        else{
            tableBlocker.origin.x = 200;
            [self splitViewTrigger:nil];
        }
    }
}


@end
