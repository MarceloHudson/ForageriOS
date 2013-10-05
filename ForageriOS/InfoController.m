//
//  InfoController.m
//  ForageriOS
//
//  Created by Joseph Milsom on 22/07/13.
//  Copyright (c) 2013 Joseph Milsom. All rights reserved.
//

#import "InfoController.h"

@interface InfoController ()
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation InfoController

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
	self.infoLabel.text = [NSString stringWithFormat:@"Info is for: %@", self.infoName];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
