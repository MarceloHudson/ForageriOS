//
//  RecipeItemCell.m
//  ForageriOS
//
//  Created by Joseph Milsom on 31/07/13.
//  Copyright (c) 2013 Joseph Milsom. All rights reserved.
//

#import "RecipeItemCell.h"

@implementation RecipeItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
