This project provides an iOS widget that animates a numeric counter up or down to a new value.  The widget supports user-configurable number formatting - allowing the display of currencies, decimal numbers, or whatever other format you'd like.  Calculations used to perform the animation use the NSDecimalNumber class and are safe for currencies.

This meat of this project is the MOAnimatedNumberLabel class which animates itself up or down from the current number displayed to the target number sent to its -(void)animateTextToNumber:(NSDecimalNumber *)number method.  Numbers are formatted by the NSNumberFormatter assigned to the MOAnimatedNumberLabel's numberFormatter property.

A comprehensive example of the label's usage is included in this repo (see MOViewController) along with a runnable demo app that let's you experiment with different animation speed and refresh settings.  Documentation of label properties is provided in MOAnimatedNumberLabel.h.

A simple example:

    //initialize the label
    self.labelToAnimate.text = @"$0.00";
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    formatter.minimumFractionDigits = 2;
    formatter.maximumFractionDigits = 2;
    
    self.labelToAnimate.numberFormatter = formatter;
    
    //and animate...
    [self.labelToAnimate animateTextToNumber:someNSDecimalNumber];
