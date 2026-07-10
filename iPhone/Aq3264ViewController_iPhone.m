//
//  Aq3264ViewController_iPhone.m
//  RingDiag
//
//  Created by Stan Benoit on 6/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Aq3264ViewController_iPhone.h"



@implementation Aq3264ViewController_iPhone

@synthesize radiusSlider;
@synthesize labelOneChannelHigh;
@synthesize labelTwoChannelHigh;
@synthesize labelThreeChannelLow;
@synthesize labelFourChannelLow;
@synthesize labelFiveChannelHigh;
@synthesize labelSixChannelLow;

@synthesize radiusValueField;

- (id)init{
    // Call the superclass's designated initializer
    if (!(self = [super initWithNibName:nil
                                 bundle:nil])) return nil;
    
    // Get the Tab Bar Item
    UITabBarItem *tbi = [self tabBarItem];
    
    // Give it a label
    [tbi setTitle:@"AQ 32/64"];
    
    return self;
    
}
- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    if ((self = [super initWithNibName:nibName bundle:bundle])) {
        // Disregard parameters - nib name is an implementaiton detail
        return [self init];
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the background color of the view so we can see it
    //[[self view] setBackgroundColor:[UIColor greenColor]];
    // Set Background color of the view so we can see it
    //[[self view] setBackgroundColor:[UIColor orangeColor]];
    
    //UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ringdiag_background.png"]];
    
    //self.view.backgroundColor = background;
    
}

//
// Dismiss Keyboard
-(IBAction)textFieldDoneEditing:(id)sender
{
    
    NSString *textValue = [radiusValueField text];
    
    float value = [textValue floatValue];
    
    radiusSlider.value = value;
    [sender resignFirstResponder];
    [self findBadBoard:value];
}

//
// Radius value changed either via slider or textfield
- (IBAction)sliderValueChange:(UISlider *)sender{
    float x;
    x = [sender value];
    radiusValueField.text = [NSString stringWithFormat:@"%.1f", [sender value]];
    [self findBadBoard:x];
}



//
// Get ADC2 QV2
//
- (void)findBadBoard:(float)radius_measured{
    
    float ringMeasure;
    float low;
    float high;
    float x;
    
    [labelOneChannelHigh setTextColor:[UIColor blackColor]];
    [labelTwoChannelHigh setTextColor:[UIColor blackColor]];
    [labelThreeChannelLow setTextColor:[UIColor blackColor]];
    [labelFourChannelLow setTextColor:[UIColor blackColor]];
    [labelFiveChannelHigh setTextColor:[UIColor blackColor]];
    [labelSixChannelLow setTextColor:[UIColor blackColor]];
    
    ringMeasure = radius_measured;
    
    //calculate low Channel
    x = ringMeasure / 600;  //divide radius by SID
    x = asin(x);			//arc sine value
    x = x * 18.25;			//total channels(896) / beam fan(49.25)
    x = x * 57.32;			//convert to degree
    x = 448.25 - x;			//sub center channel out(448.25)
    
    //if x < 1 that is no good because, anything less than one is
    //your risk a sprain to your wrist or ankle
    if( x < 1)
        x = 1;
    low = (int)x;			//cast to int to allow for comparison
    low = x;
    
    //NSLog(@"Low Channel Aq32/64: %d", (int)low);
    NSLog(@"Low Channel Aq32/64: %f", low);
    
    NSString *newTextLow = [[NSString alloc] initWithFormat:@"%d",(int)low];
    labelThreeChannelLow.text = newTextLow;
    
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
    
    //high = (int)x;			//cast to int to allow for comparison
    high = x;
    //NSLog(@"High Channel Aq32/64: %d", (int)high);
    NSLog(@"High Channel Aq32/64: %f", high);
    NSString *newTextHigh = [[NSString alloc] initWithFormat:@"%d",(int)high];
    labelOneChannelHigh.text = newTextHigh;
    
    //Low Channel ADC2
    //ADC2-1(+ref)
    if(low >= 1 & low <= 32){
        
        //
        // Card Edge
        if( low == 32)
            [labelSixChannelLow setTextColor:[UIColor redColor]];
        //
        // within 5 channels of card edge
        if (low >= 27 && low <= 31)
            [labelSixChannelLow setTextColor:[UIColor yellowColor]];
        
        //
        // Print label
        labelSixChannelLow.text = @"1";
    }
    //
    //ADC2-2
    if(low >= 33 & low <= 80){
        
        //
        // Card Edge
        if( low == 80)
            [labelSixChannelLow setTextColor:[UIColor redColor]];
        //
        // within 5 channels of card edge
        if (low >= 75 && low <= 79)
            [labelSixChannelLow setTextColor:[UIColor yellowColor]];
        
        //
        // Print label
        labelSixChannelLow.text = @"2";
    }
    //ADC2-3
    if(low >= 81 & low <= 128){
        if (low == 128)
            [labelSixChannelLow setTextColor:[UIColor redColor]];
        if (low >= 123 && low <= 127) {
            [labelSixChannelLow setTextColor:[UIColor yellowColor]];
        }
        labelSixChannelLow.text = @"3";
    }
    //ADC2-4
    if(low >= 129 & low <= 176){
        if (low == 176)
            [labelSixChannelLow setTextColor:[UIColor redColor]];
        if (low >= 171 && low <= 175) {
            [labelSixChannelLow setTextColor:[UIColor yellowColor]];
        }
        labelSixChannelLow.text = @"4";
    }
    //ADC2-5
    if(low >= 177 & low <= 224){
        if(low == 224)
            [labelSixChannelLow setTextColor:[UIColor redColor]];
        if (low >= 219 && low <= 223) {
            [labelSixChannelLow setTextColor:[UIColor yellowColor]];
        }
        labelSixChannelLow.text = @"5";
    }
    //ADC2-6
    if(low >=  225 & low <= 272){
        if(low == 272)
            [labelSixChannelLow setTextColor:[UIColor redColor]];
        if (low >= 267 && low <= 271) {
            [labelSixChannelLow setTextColor:[UIColor yellowColor]];
        }
        labelSixChannelLow.text = @"6";
    }
    //ADC2-7
    if(low >= 273 & low <= 320){
        if(low == 320)
            [labelSixChannelLow setTextColor:[UIColor redColor]];
        if (low >= 315 && low <= 319) {
            [labelSixChannelLow setTextColor:[UIColor yellowColor]];
        }
        labelSixChannelLow.text = @"7";
    }
    //ADC2-8
    if(low >= 321 & low <= 368){
        if( low == 368)
            [labelSixChannelLow setTextColor:[UIColor redColor]];
        if (low >= 363 && low <= 367) {
            [labelSixChannelLow setTextColor:[UIColor yellowColor]];
        }
        labelSixChannelLow.text = @"8";
    }
    //ADC2-9
    if(low >= 369 & low <= 416){
        if ( low == 416)
            [labelSixChannelLow setTextColor:[UIColor redColor]];
        if (low >= 411 && low <= 415) {
            [labelSixChannelLow setTextColor:[UIColor yellowColor]];
        }
        labelSixChannelLow.text = @"9";
    }
    
    //ADC2-10
    //if( fabs(low-417) < .1 & fabs(low - 464) < .1){
    //	low_ADC2 = @"ADC2-10";
    //	label_ADC2.text = low_ADC2;
    //}
    if(low >= 417 & low <= 464){
        if ( low == 464)
            [labelSixChannelLow setTextColor:[UIColor redColor]];
        if (low >= 459 && low <= 463)
            [labelSixChannelLow setTextColor:[UIColor yellowColor]];
        
        labelSixChannelLow.text = @"10";
    }
    
    //Low QV2
    //Now find the QV2 card that might be
    //bad...  again from lookup table on
    //excel spreadsheet
    // added yellow 5 channel transistion code
    
    //QV2-1
    if(low >= 1 & low <= 8){
        if (low == 8)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 3 && low <= 7)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"1";
    }
    //QV2-2
    if(low >= 9 & low <= 32){
        if (low == 32)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 27 && low <= 31)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"2";
    }
    //QV2-3
    if(low >= 33 & low <= 56){
        if (low == 56)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 51 && low <= 55)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"3";
    }
    //QV2-4
    if(low >= 57 & low <= 80){
        if(low == 80 )
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 75 && low <= 79)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"4";
    }
    //QV2-5
    if(low >= 81 & low <= 104){
        if(low == 104)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 99 && low <= 103)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"5";
    }
    //QV2-6
    if(low >= 105 & low <= 128){
        if(low == 128)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 123 && low <= 127)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"6";
    }
    //QV2-7
    if(low >= 129 & low <= 152){
        if(low == 152)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 147 && low <= 151)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"7";
    }
    //QV2-8
    if(low >= 153 & low <= 176){
        if (low == 176)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 171 && low <= 175)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"8";
    }
    //QV2-9
    if(low >= 177 & low <= 200){
        if(low == 200)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 195 && low <= 199)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"9";
    }
    //QV2-10
    if(low >= 201 & low <= 224){
        if(low == 224)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 219 && low <= 223)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"10";
    }
    //QV2-11
    if(low >= 225 & low <= 248){
        if(low == 248)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 243 && low <= 247)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"11";
    }
    //QV2-12
    if(low >= 249 & low <= 272){
        if(low == 272)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 267 && low <= 271)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"12";
    }
    //QV2-13
    if(low >= 273 & low <= 296){
        if(low == 296)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 291 && low <= 295)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"13";
    }
    //QV2-14
    if(low >= 297 & low <= 320){
        if(low == 320)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 315 && low <= 319)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"14";
    }
    //QV2-15
    if(low >= 321 & low <= 344){
        if(low == 344)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 339 && low <= 343)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"15";
    }
    //QV2-16
    if(low >= 345 & low <= 368){
        if(low == 368)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 363 && low <= 367)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"16";
    }
    //QV2-17
    if(low >= 369 & low <= 392){
        if(low == 392)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 387 && low <= 391)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"17";
    }
    //QV2-18
    if(low >= 393 & low <= 416){
        if(low == 416)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 411 && low <= 415)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"18";
    }
    //QV2-19
    if(low >= 417 & low <= 440){
        if(low == 440)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 435 && low <= 439)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"19";
    }
    //QV2-20
    if(low >= 441 & low <= 464){
        if(low == 464)
            [labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 459 && low <= 463)
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        
        labelFourChannelLow.text = @"20";
    }
    
    //OK now to hack out the high side of the detector
    //Start with the ADC2 boards
    //keep in mind that some of the low and high share the same
    //ADC2 cards....
    
    //High ADC2
    //ADC2-10
    if(high >= 417 & high<= 464){
        if(high == 464)
            [labelFiveChannelHigh setTextColor:[UIColor redColor]];
        labelFiveChannelHigh .text = @"10";
    }
    //ADC2-11
    if(high >= 465 & high <= 512 ){
        if(high == 512)
            [labelFiveChannelHigh  setTextColor:[UIColor redColor]];
        labelFiveChannelHigh.text = @"11";
    }
    //ADC2-12
    if(high >= 513 & high <= 560 ){
        if(high == 560)
            [labelFiveChannelHigh  setTextColor:[UIColor redColor]];
        labelFiveChannelHigh.text = @"12";
    }
    //ADC2-13
    if(high >= 561 & high <= 608 ){
        if(high == 608)
            [labelFiveChannelHigh  setTextColor:[UIColor redColor]];
        labelFiveChannelHigh .text = @"13";
    }
    //ADC2-14
    if(high >= 609 & high <= 656 ){
        if(high == 656)
            [labelFiveChannelHigh  setTextColor:[UIColor redColor]];
        labelFiveChannelHigh.text = @"14";
    }
    //ADC2-15
    if(high >= 657 & high <= 704 ){
        if(high == 704)
            [labelFiveChannelHigh  setTextColor:[UIColor redColor]];
        labelFiveChannelHigh.text = @"15";
    }
    //ADC2-16
    if(high >= 705 & high <= 752 ){
        if(high == 752)
            [labelFiveChannelHigh setTextColor:[UIColor redColor]];
        labelFiveChannelHigh.text = @"16";
    }
    //ADC2-17
    if(high >= 753 & high <= 800 ){
        if(high == 800)
            [labelFiveChannelHigh setTextColor:[UIColor redColor]];
        labelFiveChannelHigh.text = @"17";
    }
    //ADC2-18
    if(high >= 801.00 & high <= 848){
        if(high == 848)
            [labelFiveChannelHigh setTextColor:[UIColor redColor]];
        labelFiveChannelHigh.text = @"18";
    }
    //ADC-19
    if(high >= 849 & high <= 896 ){
        if(high == 896)
            [labelFiveChannelHigh setTextColor:[UIColor redColor]];
        labelFiveChannelHigh.text = @"19";
    }
    
    //High Side QV2
    
    //QV2-20
    if(high >= 441 & high <= 464){
        if(high == 464)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"20";
    }
    //QV2-21
    if(high >= 465 & high <= 488){
        if(high == 488)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"21";
    }
    //QV2-22
    if(high >= 489 & high <= 512){
        if(high == 512)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"22";
    }
    //QV2-23
    if(high >= 513 & high <= 536){
        if(high == 536)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"23";
    }
    //QV2-24
    if(high >= 537 & high <= 560){
        if(high == 560)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"24";
    }
    //QV2-25
    if(high >= 561 & high <= 584){
        if(high == 584)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"25";
    }
    //QV2-26
    if(high >= 585 & high <= 608){
        if(high == 608)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"26";
    }
    //QV2-27
    if(high >= 609 & high <= 632){
        if(high == 632)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"27";
    }
    //QV2-28
    if(high >= 633 & high <= 656){
        if(high == 656)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"28";
    }
    //QV2-29
    if(high >= 657 & high <= 680){
        if(high == 680)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"29";
    }
    //QV2-30
    if(high >= 681 & high <= 704){
        if(high == 704)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"30";
    }
    //QV2-31
    if(high >= 705 & high <= 728){
        if(high == 728)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"31";
    }
    //QV2-32
    if(high >= 729 & high <= 752){
        if(high == 752)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"32";
    }
    //QV2-33
    if(high >= 753 & high <= 776){
        if(high == 776)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"33";
    }
    //QV2-34
    if(high >= 777 & high <= 800){
        if(high == 800)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"34";
    }
    //QV2-35
    if(high >= 801 & high <= 824){
        if(high == 824)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"35";
    }
    //QV2-36
    if(high >= 825 & high <= 848){
        if(high == 848)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"36";
    }
    //QV2-37
    if(high >= 849 & high <= 872){
        if(high == 872)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"37";
    }
    //QV2-38
    if(high >= 873 & high <= 896){
        if(high == 896)
            [labelTwoChannelHigh setTextColor:[UIColor redColor]];
        labelTwoChannelHigh.text = @"38";
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



- (IBAction)increaseRadius:(id)sender {
    
    NSString *textValue = [radiusValueField text];
    
    float value = [textValue floatValue];
    if (value > 0) {
        
        
        value = value + .1;
        radiusSlider.value = value;
        
        radiusValueField.text = [NSString stringWithFormat:@"%.1f", value];
        [self findBadBoard:value];
    }
    
}
- (IBAction)decreaseRadius:(id)sender {
    
    NSString *textValue = [radiusValueField text];
    
    float value = [textValue floatValue];
    if (value > 0) {
        
        value = value - .1;
        
        
        radiusSlider.value = value;
        
        radiusValueField.text = [NSString stringWithFormat:@"%.1f", value];
        [self findBadBoard:value];
    }
    
}
@end
