//
//  AqPrimeViewController.m
//  iRingDiag
//
//  Created by Stanley Benoit on 2/8/15.
//
//

#import "AqPrimeViewController_iPhone.h"

@interface AqPrimeViewController_iPhone ()

@end

@implementation AqPrimeViewController_iPhone

- (id)init{
    // Call the superclass's designated initializer
    if (!(self = [super initWithNibName:nil
                                 bundle:nil])) return nil;
    
    // Get the tab bar item
    UITabBarItem *tbi = [self tabBarItem];
    
    // Give it a label
    [tbi setTitle:@"Prime"];
    
    // slider
    // radiusSlider thumbImageForState:<#(UIControlState)#>
    
    return self;
}


- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    if ((self = [super initWithNibName:nibName bundle:bundle])) {
        // Custom initialization
        // Disregard parameters - nib name is an implementation detail
        NSLog(@"Nib info: %@", [self description]);
        return [self init];
    }
    NSLog(@"Nib info: %@", [self description]);
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"View did load");
    // Set Background color of the view so we can see it
    //[[self view] setBackgroundColor:[UIColor orangeColor]];
    
    //	UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ringdiag_background.png"]];
    //
    //	self.view.backgroundColor = background;
    //	NSLog(@"view info: %@", [background description]);
    
}

//
// Dismiss Keyboard
-(IBAction)textFieldDoneEditing:(UITextField *)sender
{
    NSString *textValue = [_radiusValueField text];
    float value = [textValue floatValue];
    _radiusSlider.value = value;
    [sender resignFirstResponder];
    [self findBadBoard:value];
}

//
// Radius value changed either via slider or textfield
- (IBAction)sliderValueChange:(UISlider *)sender{
    float x;
    x = [sender value];
    _radiusValueField.text = [NSString stringWithFormat:@"%.1f", [sender value]];
    [self findBadBoard:x];
}

//
// 

// 23 Oct 2011 added 5 channel yellow text message
//             alerts user when they are within 5 channel
//             transistion point
- (void)findBadBoard:(float)radius_measured{
    
    float ringMeasure;
    float low;
    float high;
    float x;
    
    [_labelOneChannelHigh setTextColor:[UIColor blackColor]];
    NSLog(@"label One info: %@", [labelOneChannelHigh description]);
    [_labelTwoChannelHigh setTextColor:[UIColor blackColor]];
    [_labelThreeChannelLow setTextColor:[UIColor blackColor]];
    [_labelFourChannelLow setTextColor:[UIColor blackColor]];
    
    
    ringMeasure = radius_measured;
    
    //calculate low Channel
    x = ringMeasure / 600; //divide radius by SID
    //NSLog(@"x = %f", x);
    x = asin(x);			//arc sine value
    //NSLog(@"x = %f", x);
    x = x * 18.25;			//total channels(896) / beam fan(49.25)
    //NSLog(@"x = %f", x);
    x = x * 57.32;			//convert to degree
    //NSLog(@"x = %f", x);
    x = 448.25 - x;			//sub center channel out(448.25)
    //NSLog(@"x = %f", x);
    
    
    //if x < 1 that is no good because, anything less than one is
    //your risk a sprain to your wrist or ankle
    if( x < 1)
        x = 1;
    low = (int)x;			//cast to int to allow for comparison
    //NSLog(@"Low Channel Aq16: %d", (int)low);
    NSString *newTextLow = [[NSString alloc] initWithFormat:@"%d",(int)low];
    _labelThreeChannelLow.text = newTextLow;
    
    // High Channel
    x = ringMeasure / 600;  //divide radius by SID
    x = asin(x);			//arc sine value
    x = x * 18.25;			//total channels(896) / beam fan(49.25)
    x = x * 57.32;			//convert to degree
    x = 448.25 + x;			//add center channel out
    if( x < 1)
        x = 1;
    if(x > 896)
        x = 896;
    
    high = (int)x;			//cast to int to allow for comparison
    NSLog(@"High Channel Aq16: %d", (int)high);
    NSString *newTextHigh = [[NSString alloc] initWithFormat:@"%d",(int)high];
    _labelOneChannelHigh.text = newTextHigh;
    
    //
    // Low side of the detector
    //find converter 16 for low side
    if(low >= 1 & low <= 32){
        if(low == 32)
            [_labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >=28 && low <= 31) {
            [_labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }
        _labelFourChannelLow.text = @"1";
    }
    
    if(low >= 33 & low <= 80){
        if(low == 80)
            [_labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >=75 && low <=79) {
            [_labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }
        _labelFourChannelLow.text = @"2";
    }
    
    if(low >= 81 & low <= 128){
        if(low == 128)
            [_labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 123 && low <= 127) {
            [_labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }
        _labelFourChannelLow.text = @"3";
    }
    
    if(low >= 129 & low <= 176){
        if(low == 176)
            [_labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 171 && low <= 175) {
            [_labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }
        
        _labelFourChannelLow.text = @"4";
    }
    
    if(low >= 177 & low <= 224){
        if(low == 224)
            [_labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 199 && low <= 223) {
            [_labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }
        
        _labelFourChannelLow.text = @"5";
    }
    
    if(low >= 225 & low <= 272){
        if(low == 271)
            [_labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 267 && low <= 271) {
            [_labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }
        
        _labelFourChannelLow.text = @"6";
    }
    
    if(low >= 273 & low <= 320){
        if(low == 319)
            [_labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 315 && low <= 319 ) {
            [_labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }
        
        _labelFourChannelLow.text = @"7";
    }
    
    if(low >= 321 & low <= 368){
        if(low == 367)
            [_labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 363 && low <= 367) {
            [_labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }
        
        _labelFourChannelLow.text = @"8";
    }
    
    if(low >= 369 & low <= 392){
        if(low == 391)
            [_labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 327 && low <= 391) {
            [_labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }
        
        _labelFourChannelLow.text = @"9";
    }
    
    if(low >= 417 & low <= 464){
        if(low == 463)
            [_labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 459 && low <= 463) {
            [_labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }
        
        _labelFourChannelLow.text = @"10";
    }
    
    // Now the high side of the detector
    //
    //High Side
    //
    if(high >= 417& high <= 464){
        if(high == 463)
            [ _labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 459 && high <= 463) {
            [ _labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
        
        labelTwoChannelHigh.text = @"10";
    }
    
    if(high >= 465 & high <= 512){
        if(high == 511)
            [_labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 493 && high <= 511) {
            [ _labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
        _labelTwoChannelHigh.text = @"11";
    }
    
    if(high >= 513 & high <= 560){
        if(high == 559)
            [_labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 554 && high <= 559) {
            [ _labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
        
        _labelTwoChannelHigh.text = @"12";
    }
    
    if(high >= 561 & high <= 608){
        if(high == 609)
            [_labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 603 && high <= 609) {
            [ _labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
        _labelTwoChannelHigh.text = @"13";
    }
    
    if(high >= 609 & high <= 656){
        if(high == 655)
            [_labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 650 && high <= 655) {
            [ _labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
        _labelTwoChannelHigh.text = @"14";
    }
    
    if(high >= 657 & high <= 704){
        if(high == 703)
            [_labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 698 && high <= 703) {
            [ _labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
        _labelTwoChannelHigh.text = @"15";
    }
    
    if(high >= 705  & high <= 752){
        if(high == 751)
            [_labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 746 && high <= 751) {
            [_labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
        _labelTwoChannelHigh.text = @"16";
    }
    
    if(high >= 753 & high <= 800){
        if(high == 799)
            [_labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 794 && high <= 799) {
            [ _labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
        _labelTwoChannelHigh.text = @"17";
    }
    
    if(high >= 801 & high <= 848){
        if(high == 847)
            [_labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 842 && high <= 847) {
            [ _labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
        _labelTwoChannelHigh.text = @"18";
    }
    
    if(high >= 849 & high <= 896){
        if(high == 895)
            [_labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 890 && high <= 895) {
            [ _labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
        _labelTwoChannelHigh.text = @"19";
    }
    
   
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return NO;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
