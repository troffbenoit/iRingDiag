//
//  Aq16ViewController.m
//  RingDiag
//
//  Created by Stan Benoit on 6/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Aq16ViewController.h"



@implementation Aq16ViewController
@synthesize radiusSlider;
@synthesize labelOneChannelHigh;
@synthesize labelTwoChannelHigh;
@synthesize labelThreeChannelLow;
@synthesize labelFourChannelLow;
@synthesize radiusValueField;
@synthesize ledDC_1;
@synthesize ledDC_2;
@synthesize ledDC_3;
@synthesize ledDC_4;
@synthesize ledDC_5;
@synthesize ledDC_6;
@synthesize ledAC_1;
@synthesize ledAC_2;
@synthesize ledAC_3;
@synthesize ledAC_4;
@synthesize ledAC_5;
@synthesize ledAC_6;
//DC volt user inputs
@synthesize DCVolts_CNN1;
@synthesize DCVolts_CNN2;
@synthesize DCVolts_CNN3;
@synthesize DCVolts_CNN4;
@synthesize DCVolts_CNN5;
@synthesize DCVolts_CNN6;
@synthesize DCVolts_CNN7;
@synthesize DCVolts_CNN8;
//AC volt user inputs
@synthesize ACVolts_CNN1;
@synthesize ACVolts_CNN2;
@synthesize ACVolts_CNN3;
@synthesize ACVolts_CNN4;
@synthesize ACVolts_CNN5;
@synthesize ACVolts_CNN6;
@synthesize ACVolts_CNN7;
@synthesize ACVolts_CNN8;

- (id)init{
	// Call the superclass's designated initializer
	if (!(self = [super initWithNibName:nil
					bundle:nil])) return nil;
	
	// Get the tab bar item
	UITabBarItem *tbi = [self tabBarItem];
	
	// Give it a label
	[tbi setTitle:@"AQ 16"];
	return self;
}


- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    if ((self = [super initWithNibName:nibName bundle:bundle])) {
        // Custom initialization
		// Disregard parameters - nib name is an implementation detail
		return [self init];
    }
    return self;
}


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	// Set Background color of the view so we can see it
	[[self view] setBackgroundColor:[UIColor blackColor]];
	
	// Set leds to off image
	// We have 12 leds 6 for DC testing and 6 for AC ripple Testing
	//
	
	// LED for DC position 1
	[self.ledDC_1 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledDC_1.opaque = YES; // explicitly opaque for performance
	self.ledDC_1.backgroundColor = [UIColor clearColor];
	
	// LED for AC Position 1
	[self.ledAC_1 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledAC_1.opaque = YES; // explicitly opaque for performance
	self.ledAC_1.backgroundColor = [UIColor clearColor];
	
	// LED for DC Position 2
	[self.ledDC_2 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledDC_2.opaque = YES; // explicitly opaque for performance
	self.ledDC_2.backgroundColor = [UIColor clearColor];
	
	// LED for AC Position 2
	[self.ledAC_2 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledAC_2.opaque = YES; // explicitly opaque for performance
	self.ledAC_2.backgroundColor = [UIColor clearColor];
	
	// LED for DC Position 3
	[self.ledDC_3 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledDC_3.opaque = YES; // explicitly opaque for performance
	self.ledDC_3.backgroundColor = [UIColor clearColor];
	
	// LED for AC Position 3
	[self.ledAC_3 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledAC_3.opaque = YES; // explicitly opaque for performance
	self.ledAC_3.backgroundColor = [UIColor clearColor];
	
	// LED for DC Position 4
	[self.ledDC_4 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledDC_4.opaque = YES; // explicitly opaque for performance
	self.ledDC_4.backgroundColor = [UIColor clearColor];
	
	// LED for AC Position 4
	[self.ledAC_4 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledAC_4.opaque = YES; // explicitly opaque for performance
	self.ledAC_4.backgroundColor = [UIColor clearColor];
	
	// LED for DC Position 5
	[self.ledDC_5 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledDC_5.opaque = YES; // explicitly opaque for performance
	self.ledDC_5.backgroundColor = [UIColor clearColor];
	
	// LED for AC Position 5
	[self.ledAC_5 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledAC_5.opaque = YES; // explicitly opaque for performance
	self.ledAC_5.backgroundColor = [UIColor clearColor];
	
	// LED for DC Position 6
	[self.ledDC_6 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledDC_6.opaque = YES; // explicitly opaque for performance
	self.ledDC_6.backgroundColor = [UIColor clearColor];
	
	// LED for AC Position 6
	[self.ledAC_6 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledAC_6.opaque = YES; // explicitly opaque for performance
	self.ledAC_6.backgroundColor = [UIColor clearColor];
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
// Dismiss Keyboard power suppply check
-(IBAction)DismissPowerSupplyCheckKeyboard:(id)sender
{
	[sender resignFirstResponder];
	[self powerSupplyCheck:sender];
	
}

//
// LED green Off
-(void)turnOffLeds
{
	[ledDC_1 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	[ledDC_2 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	[ledDC_3 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	[ledDC_4 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	[ledDC_5 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	[ledDC_6 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	
	[ledAC_1 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	[ledAC_1 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	[ledAC_1 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	[ledAC_1 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	[ledAC_1 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
}

//
// Check power supply
//
- (IBAction)powerSupplyCheck:(id)sender{
	//floats
	double dcVoltage_Value = 0.000000;
	double acVoltage_Value = 0.000000;
	
	[self turnOffLeds];
	
	//PCN3-1,3 DC and AC ripple Check
	
	// DC
	if ([DCVolts_CNN1.text length] > 0)
	{
		[ledDC_1 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		dcVoltage_Value = [DCVolts_CNN1.text doubleValue];
		if((dcVoltage_Value) >= 5.7 & (dcVoltage_Value) <= 5.8)
		{
			[ledDC_1 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledDC_1 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
		}
		
	}
	
	// AC
	if ([ACVolts_CNN1.text length] > 0) {
		[ledAC_1 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		acVoltage_Value = [ACVolts_CNN1.text doubleValue];
		if((acVoltage_Value) <= .100)
		{
			[ledAC_1 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledAC_1 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
		}

	}
	
	//PCN4-1,3 DC and AC ripple Check
	
	//DC
	if ([DCVolts_CNN2.text length] > 0) {
		[ledDC_2 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		dcVoltage_Value = [DCVolts_CNN2.text doubleValue];
		if((dcVoltage_Value) >= 5.7 & (dcVoltage_Value) <= 5.8)
		{
			[ledDC_2 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledDC_2 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
		}

	}
	
	//AC 
	if ([ACVolts_CNN2.text length] > 0) {
		[ledAC_2 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		acVoltage_Value = [ACVolts_CNN2.text doubleValue];
		if((acVoltage_Value) <= .100)
		{
			[ledAC_2 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledAC_2 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
		}

	}
	
	//PCN1-1,3 DC and AC ripple check
	
	//DC
	if ([DCVolts_CNN3.text length] > 0) {
		
		[ledDC_3 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		dcVoltage_Value = [DCVolts_CNN3.text doubleValue];
		if((dcVoltage_Value) >= 5.7 & (dcVoltage_Value) <= 5.8)
		{
			[ledDC_3 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledDC_3 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
		}

	}
	
	//AC
	if ([ACVolts_CNN3.text length] > 0) {
		[ledAC_3 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		acVoltage_Value = [ACVolts_CNN3.text doubleValue];
		if((acVoltage_Value) <= .100)
		{
			[ledAC_3 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledAC_3 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
		}

	}
	
	//PCN1-5,6 DC and AC ripple check
	//DC
	if ([DCVolts_CNN4.text length] > 0) {
		
		[ledDC_4 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		dcVoltage_Value = [DCVolts_CNN4.text doubleValue];
		if((dcVoltage_Value) >= 3.3 & (dcVoltage_Value) <= 3.4)
		{
			[ledDC_4 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledDC_4 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
		}

	}
	
	//AC
	if ([ACVolts_CNN4.text length] > 0) {
		[ledAC_4 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		acVoltage_Value = [ACVolts_CNN4.text doubleValue];
		if((acVoltage_Value) <= .100)
		{
			[ledAC_4 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledAC_4 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
		}

	}
	
	//PCN2-1,3 DC and AC ripple check
	//DC
	if ([DCVolts_CNN5.text length] > 0) {
		
		[ledDC_5 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		dcVoltage_Value = [DCVolts_CNN5.text doubleValue];
		if((dcVoltage_Value) >= 5.7 & (dcVoltage_Value) <= 5.8)
		{
			[ledDC_5 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledDC_5 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
		}

	}
	
	//AC
	if ([ACVolts_CNN5.text length] > 0) {
		[ledAC_5 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		acVoltage_Value = [ACVolts_CNN5.text doubleValue];
		if((acVoltage_Value) <= .100)
		{
			[ledAC_5 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledAC_5 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
		}

	}
	//PCN2-5,6 DC and AC ripple check
	//DC
	if ([DCVolts_CNN6.text length] > 0) {
		
		[ledDC_6 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		dcVoltage_Value = [DCVolts_CNN6.text doubleValue];
		if((dcVoltage_Value) >= 3.3 & (dcVoltage_Value) <= 3.4)
		{
			[ledDC_6 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledDC_6 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
		}

	}
	
	//AC
	if ([ACVolts_CNN6.text length] > 0) {
		[ledAC_6 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		acVoltage_Value = [ACVolts_CNN6.text doubleValue];
		if((acVoltage_Value) <= .100)
		{
			[ledAC_6 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledAC_6 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
		}

	}
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
	
	if ((interfaceOrientation==UIInterfaceOrientationPortrait)||(interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown))
	{
		return NO;
	}
	if ((interfaceOrientation==UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation==UIInterfaceOrientationLandscapeRight))
	{
		return YES;
	}
	return NO;
	
}

//
// Radius value changed either via slider or textfield
- (IBAction)sliderValueChange:(UISlider *)sender{
	float x;
	x = [sender value];
	radiusValueField.text = [NSString stringWithFormat:@"%.1f", [sender value]];
	[self findBadBoard:x];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//
// get CONV16 
- (void)findBadBoard:(float)radius_measured{
	
	float ringMeasure;
	float low;
	float high;
	float x;
	
	[labelOneChannelHigh setTextColor:[UIColor greenColor]];
	NSLog(@"label One info: %@", [labelOneChannelHigh description]);
	[labelTwoChannelHigh setTextColor:[UIColor greenColor]];
	[labelThreeChannelLow setTextColor:[UIColor greenColor]];
	[labelFourChannelLow setTextColor:[UIColor greenColor]];
	
	
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
	NSLog(@"Low Channel Aq16: %d", (int)low);
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
	
	high = (int)x;			//cast to int to allow for comparison
	NSLog(@"High Channel Aq16: %d", (int)high);
	NSString *newTextHigh = [[NSString alloc] initWithFormat:@"%d",(int)high];
	labelOneChannelHigh.text = newTextHigh;
	
	//find converter 16 for low side
	if(low >= 1 & low <= 32){
		if(low == 32)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		
		labelFourChannelLow.text = @"1";
	}
	
	if(low >= 33 & low <= 80){
		if(low == 80)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"2";
	}
	
	if(low >= 81 & low <= 128){
		if(low == 128)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"3";
	}
	
	if(low >= 129 & low <= 152){
		if(low == 152)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"4";
	}
	
	if(low >= 153 & low <= 176){
		if(low == 176)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"5";
	}
	
	if(low >= 177 & low <= 200){
		if(low == 200)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"6";
	}
	
	if(low >= 201 & low <= 224){
		if(low == 224)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"7";
	}
	
	if(low >= 225 & low <= 248){
		if(low == 248)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"8";
	}
	
	if(low >= 249 & low <= 272){
		if(low == 272)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"9";
	}
	
	if(low >= 273 & low <= 296){
		if(low == 296)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"10";
	}
	
	if(low >= 297 & low <= 320){
		if(low == 320)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"11";
	}
	
	if(low >= 321 & low <= 341){
		if(low == 341)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"12";
	}
	
	if(low >= 342 & low <= 368){
		if(low == 368)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"13";
	}
	
	if(low >= 369 & low <= 392){
		if(low == 392)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"14";
	}
	
	if(low >= 393 & low <= 416){
		if(low == 416)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"15";
	}
	
	if(low >= 417 & low <= 440){
		if(low == 440)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"16";
	}
	
	if(low >= 441 & low <= 464){
		if(low == 464)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"17";
	}
	
	//High Side 
	if(high >= 441 & high <= 464){
		if(high == 464)
			[ labelTwoChannelHigh setTextColor:[UIColor redColor]];
		labelTwoChannelHigh.text = @"17";
	}
	
	if(high >= 465 & high <= 488){
		if(high == 488)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
		
		labelTwoChannelHigh.text = @"18";
	}
	
	if(high >= 489 & high <= 512){
		if(high == 512)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
		
		labelTwoChannelHigh.text = @"19";
	}
	
	if(high >= 513 & high <= 536){
		if(high == 536)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
		
		labelTwoChannelHigh.text = @"20";
	}
	
	if(high >= 537 & high <= 560){
		if(high == 560)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
		
		labelTwoChannelHigh.text = @"21";
	}
	
	if(high >= 561 & high <= 584){
		if(high == 584)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
		
		labelTwoChannelHigh.text = @"22";
	}
	
	if(high >= 585 & high <= 608){
		if(high == 608)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
		
		labelTwoChannelHigh.text = @"23";
	}
	
	if(high >= 609 & high <= 632){
		if(high == 632)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
		
		labelTwoChannelHigh.text = @"24";
	}
	
	if(high >= 633 & high <= 656){
		if(high == 656)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
		
		labelTwoChannelHigh.text = @"25";
	}
	
	if(high >= 657 & high <= 680){
		if(high == 680)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
		
		labelTwoChannelHigh.text = @"26";
	}
	
	if(high >= 681 & high <= 704){
		if(high == 704)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
		
		labelTwoChannelHigh.text = @"27";
	}
	
	if(high >= 705 & high <= 728){
		if(high == 728)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
		
		labelTwoChannelHigh.text = @"28";
	}
	
	if(high >= 729 & high <= 752){
		if(high == 752)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
		
		labelTwoChannelHigh.text = @"29";
	}
	
	if(high >= 753 & high <= 800){
		if(high == 800)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
		
		labelTwoChannelHigh.text = @"30";
	}
	
	if(high >= 801 & high <= 848){
		if(high == 848)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
		
		labelTwoChannelHigh.text = @"31";
	}
	
	if(high >= 849 & high <= 896){
		if(high == 896)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
		
		labelTwoChannelHigh.text = @"32";
	}
	
	
}





- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




@end
