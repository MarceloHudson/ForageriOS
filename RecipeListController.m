//
//  RecipeListController.m
//  ForageriOS
//
//  Created by Joseph Milsom on 26/07/13.
//  Copyright (c) 2013 Joseph Milsom. All rights reserved.
//

#import "RecipeListController.h"
#import "RecipeItemCell.h"
#import "RecipeController.h"

@interface RecipeListController ()
@property (weak, nonatomic) IBOutlet UITableView *recipeTableView;
- (IBAction)splitViewTrigger:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *splitView;
@property (weak, nonatomic) IBOutlet UIView *navBar;
@property (nonatomic) BOOL *isSplitViewOpen;
@property (nonatomic, retain) NSArray *recipes; //list of recipes for the table
@property (nonatomic, retain) NSString *recipeName;//variable to pass to the recipe item controller.
@end

@implementation RecipeListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //remove this later when own line (image) has been created
	self.recipeTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.recipes = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"imagelocations" ofType:@"plist"]];//need to change imagelocations
    self.isSplitViewOpen = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.recipes.count;
}

//height of each cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 134.0;
}

//figure out how this works...
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    RecipeItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RecipeItemCell" owner:self options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[RecipeItemCell class]]) {
                cell = (RecipeItemCell *)currentObject;
                break;
            }
        }
    }
    
	NSString *imageLocation = [self.recipes objectAtIndex:indexPath.row];//temporary....
    cell.labelText.text = imageLocation;//temporary, change to recipe list
    [cell.labelText setFont:[UIFont fontWithName:@"Bebas" size:cell.labelText.font.pointSize]];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//this method is called just before the segue call, I use it to send data to the
//recipe controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"RecipeListToRecipe"]){
        RecipeController *controller = (RecipeController *)segue.destinationViewController;
        controller.recipeName = self.recipeName;
    }

}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecipeItemCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.recipeName = cell.labelText.text;//assign recipename to send to next view
    [self performSegueWithIdentifier: @"RecipeListToRecipe" sender: self];
    
}


//method for the spil view pane
- (IBAction)splitViewTrigger:(UIButton *)sender {
    CGRect splitViewFrame = self.splitView.frame;
    CGRect navBarFrame = self.navBar.frame;
    CGRect tableFrame = self.recipeTableView.frame;
    if(self.isSplitViewOpen == NO){
        self.isSplitViewOpen = YES;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        splitViewFrame.origin.x = 0;//comment this out
        navBarFrame.origin.x = 200;
        tableFrame.origin.x = 200;
        self.splitView.frame = splitViewFrame;
        self.navBar.frame = navBarFrame;
        self.recipeTableView.frame = tableFrame;
        [UIView commitAnimations];
    }
    else{
        self.isSplitViewOpen = NO;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        splitViewFrame.origin.x = 0;
        navBarFrame.origin.x = 0;
        tableFrame.origin.x = 0;
        self.splitView.frame = splitViewFrame;
        self.navBar.frame = navBarFrame;
        self.recipeTableView.frame = tableFrame;
        [UIView commitAnimations];
    }
}
@end
