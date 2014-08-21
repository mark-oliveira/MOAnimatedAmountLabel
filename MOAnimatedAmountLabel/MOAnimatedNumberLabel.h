//
//  MOAnimatedNumberLabel.h
//  MOAnimatedAmountLabel
//
//  Created by Mark Oliveira on 8/6/14.
//
//

#import <UIKit/UIKit.h>

@interface MOAnimatedNumberLabel : UILabel

//Set the duration of the animation.  Defaults to one second.
@property double animationDuration;
//The number of times to update the number during animationDuration.  Default is 60 (60fps with the default 1 second update time).
@property int numAnimations;
//The number formatter to use when displaying the number
@property NSNumberFormatter *numberFormatter;

//Pass in the number to animate the label to.  It will start from the label's current value and count up (or down) to the input number.
-(void)animateTextToNumber:(NSDecimalNumber *)number;

@end
