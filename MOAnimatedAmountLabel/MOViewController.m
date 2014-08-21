//
//  MOViewController.m
//  MOAnimatedAmountLabel
//
//  Created by Mark Oliveira on 8/6/14.
//
//

#import "MOViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import "MOAnimatedNumberLabel.h"

@interface MOViewController ()
@property (weak, nonatomic) IBOutlet MOAnimatedNumberLabel *labelToAnimate;
@property (weak, nonatomic) IBOutlet UITextField *amountField;
@property (weak, nonatomic) IBOutlet UITextField *numUpdatesField;
@property (weak, nonatomic) IBOutlet UITextField *animationDurationField;

//@property (strong) NSNumber currentAmount;
- (IBAction)animateLabel:(id)sender;
- (IBAction)zeroAmount:(id)sender;

@end

@implementation MOViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.labelToAnimate.text = @"$0.00";
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    formatter.minimumFractionDigits = 2;
    formatter.maximumFractionDigits = 2;
    
    self.labelToAnimate.numberFormatter = formatter;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animateLabel:(id)sender {
    NSDecimalNumber *end = [[NSDecimalNumber alloc] initWithString:self.amountField.text];
    self.labelToAnimate.numAnimations = [self.numUpdatesField.text intValue];
    self.labelToAnimate.animationDuration = [self.animationDurationField.text doubleValue];
    
    [self.labelToAnimate animateTextToNumber:end];
}

- (IBAction)zeroAmount:(id)sender {
    self.labelToAnimate.text = @"$0.00";
    self.amountField.text = @"0.00";
}

@end



