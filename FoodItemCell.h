//
//  FoodItemCell.h
//  ForageriOS
//
//  Created by Joseph Milsom on 21/07/13.
//  Copyright (c) 2013 Joseph Milsom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foodItemImage;
@property (weak, nonatomic) NSString *foodItem;
@property (weak, nonatomic) IBOutlet UIButton *RecipeButton;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

@end
