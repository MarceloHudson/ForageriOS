//
//  RecipeController.m
//  ForageriOS
//
//  Created by Joseph Milsom on 22/07/13.
//  Copyright (c) 2013 Joseph Milsom. All rights reserved.
//

#import "RecipeController.h"

@interface RecipeController ()
@property (weak, nonatomic) IBOutlet UILabel *recipeLabel;
@end

@implementation RecipeController

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
	// Do any additional setup after loading the view.
    self.recipeLabel.text = [NSString stringWithFormat:@"Recipe is for: %@", self.recipeName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
