//
//  MOAnimatedNumberLabel.m
//  MOAnimatedAmountLabel
//
//  Created by Mark Oliveira on 8/6/14.
//
//

#import "MOAnimatedNumberLabel.h"

@interface MOAnimatedNumberLabel ()

@property (strong) NSDecimalNumber *initialAmount;
@property (strong) NSDecimalNumber *currentAmount;
@property (strong) NSDecimalNumber *finalAmount;
@property (strong) NSDecimalNumber *increment;
@property (strong) NSTimer *animationTimer;
@property NSTimeInterval interval;

@end

@implementation MOAnimatedNumberLabel


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)animateTextToNumber:(NSDecimalNumber *)number
{
    if(self.animationTimer.isValid) {
        NSLog(@"Animation already running! Stopping and restarting animation.");
        [self.animationTimer invalidate];
    }
    
    [self startAnimation:number];
    
}

- (void)startAnimation:(NSDecimalNumber *)number
{
    [self initializeAnimationVariables:number];
    [self startAnimationTimer];
}

- (void)initializeAnimationVariables:(NSDecimalNumber *)number
{
    if(self.numAnimations == 0) {
        self.numAnimations = 60;
    }
    if(self.animationDuration == 0) {
        self.animationDuration = 1;
    }
    
    if(self.text != nil) {
        //TODO: what happens when the label's text is not an amount
        self.initialAmount = [NSDecimalNumber decimalNumberWithDecimal:[[self amountFromString:self.text] decimalValue]];
    }
    else {
        self.initialAmount = [[NSDecimalNumber alloc] initWithInt:0];
    }
    
    self.currentAmount = self.initialAmount;
    
    self.finalAmount = number;
    
    NSDecimalNumber *amountDelta = [number decimalNumberBySubtracting:self.initialAmount];
    self.increment = [amountDelta decimalNumberByDividingBy:[[NSDecimalNumber alloc] initWithInt:self.numAnimations]];
    
    //if amountDelta is negative we should increment upward, otherwise down
    self.interval = [[[[NSDecimalNumber alloc] initWithInt:self.animationDuration] decimalNumberByDividingBy:[[NSDecimalNumber alloc] initWithInt:self.numAnimations]] doubleValue];
}

//starts the animation timer.  WARNING - calling this when the animationTimer is already active will cause the original timer to never stop.
- (void)startAnimationTimer
{
    if(self.animationTimer.isValid) {
     NSLog(@"Calling startAnimationTimer while an animation is already running is not supported!  Returning without starting animation.");
        return; //if we don't return, self.animationTimer would be set to the new timer and the original timer would never be invalidated.
    }
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(increment:) userInfo:nil repeats:YES];
}

- (void)increment:(NSTimer *)timer {
    self.currentAmount = [self.currentAmount decimalNumberByAdding:self.increment];
    self.text = [self formatAmountOnly:self.currentAmount];
    
    
    if([self.currentAmount isEqualToNumber:self.finalAmount]){
        NSLog(@"stopping animation");
        [timer invalidate];//stops calling this method
    }
}

- (NSString *)formatAmountOnly:(NSNumber *)number
{
    return [self.numberFormatter stringFromNumber:number];
}

- (NSNumber *)amountFromString:(NSString *)numberString
{
    return [self.numberFormatter numberFromString:numberString];
}


@end
