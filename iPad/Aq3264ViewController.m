    //
//  Aq3264ViewController.m
//  RingDiag
//
//  Created by Stan Benoit on 6/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Aq3264ViewController.h"


@implementation Aq3264ViewController

@synthesize radiusSlider;
@synthesize labelOneChannelHigh;
@synthesize labelTwoChannelHigh;
@synthesize labelThreeChannelLow;
@synthesize labelFourChannelLow;
@synthesize labelFiveChannelHigh;
@synthesize labelSixChannelLow;
//
//DC LEDS
@synthesize ledDC_1;
@synthesize ledDC_2;
@synthesize ledDC_3;
@synthesize ledDC_4;
@synthesize ledDC_5;
@synthesize ledDC_6;
@synthesize ledDC_7;
@synthesize ledDC_8;
//
//AC LEDS
@synthesize ledAC_1;
@synthesize ledAC_2;
@synthesize ledAC_3;
@synthesize ledAC_4;
@synthesize ledAC_5;
@synthesize ledAC_6;
@synthesize ledAC_7;
@synthesize ledAC_8;
//
//DC volt user inputs
@synthesize DCVolts_CNN1;
@synthesize DCVolts_CNN2;
@synthesize DCVolts_CNN3;
@synthesize DCVolts_CNN4;
@synthesize DCVolts_CNN5;
@synthesize DCVolts_CNN6;
@synthesize DCVolts_CNN7;
@synthesize DCVolts_CNN8;
//
//AC volt user inputs
@synthesize ACVolts_CNN1;
@synthesize ACVolts_CNN2;
@synthesize ACVolts_CNN3;
@synthesize ACVolts_CNN4;
@synthesize ACVolts_CNN5;
@synthesize ACVolts_CNN6;
@synthesize ACVolts_CNN7;
@synthesize ACVolts_CNN8;


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
// get ADC2 QV2
- (void)findBadBoard:(float)radius_measured{
	
	float ringMeasure;
	float low;
	float high;
	float x;
	
	[labelOneChannelHigh setTextColor:[UIColor greenColor]];
	[labelTwoChannelHigh setTextColor:[UIColor greenColor]];
	[labelThreeChannelLow setTextColor:[UIColor greenColor]];
	[labelFourChannelLow setTextColor:[UIColor greenColor]];
	[labelFiveChannelHigh setTextColor:[UIColor greenColor]];
	[labelSixChannelLow setTextColor:[UIColor greenColor]];
	
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
	NSLog(@"Low Channel Aq32/64: %d", (int)low);
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
	NSLog(@"High Channel Aq32/64: %d", (int)high);
	NSString *newTextHigh = [[NSString alloc] initWithFormat:@"%d",(int)high];
	labelOneChannelHigh.text = newTextHigh;
	
	//Low Channel ADC2
	//ADC2-1(+ref)
	if(low >= 1 & low <= 32){
		if( low == 32)
			[labelSixChannelLow setTextColor:[UIColor redColor]];
		labelSixChannelLow.text = @"1";
	}
	//ADC2-2
	if(low >= 33 & low <= 80){
		if( low == 80)
			[labelSixChannelLow setTextColor:[UIColor redColor]];	
		labelSixChannelLow.text = @"2";
	}
	//ADC2-3
	if(low >= 81 & low <= 128){
		if (low == 128)
			[labelSixChannelLow setTextColor:[UIColor redColor]];
		labelSixChannelLow.text = @"3";
	}
	//ADC2-4
	if(low >= 129 & low <= 176){
		if (low == 176)
			[labelSixChannelLow setTextColor:[UIColor redColor]];
		labelSixChannelLow.text = @"4";
	}
	//ADC2-5
	if(low >= 177 & low <= 224){
		if(low == 224)
			[labelSixChannelLow setTextColor:[UIColor redColor]];
		labelSixChannelLow.text = @"5";
	}
	//ADC2-6
	if(low >=  225 & low <= 272){
		if(low == 272)
			[labelSixChannelLow setTextColor:[UIColor redColor]];
		labelSixChannelLow.text = @"6";
	}
	//ADC2-7
	if(low >= 273 & low <= 320){
		if(low == 320)
			[labelSixChannelLow setTextColor:[UIColor redColor]];
		labelSixChannelLow.text = @"7";
	}
	//ADC2-8
	if(low >= 321 & low <= 368){
		if( low == 368)
			[labelSixChannelLow setTextColor:[UIColor redColor]];
		labelSixChannelLow.text = @"8";
	}
	//ADC2-9
	if(low >= 369 & low <= 416){
		if ( low == 416)
			[labelSixChannelLow setTextColor:[UIColor redColor]];
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
		labelSixChannelLow.text = @"10";
	}
	
	//Low QV2
	//Now find the QV2 card that might be
	//bad...  again from lookup table on 
	//excel spreadsheet
	
	//QV2-1
	if(low >= 1 & low <= 8){
		if (low == 8)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"1";
	}
	//QV2-2
	if(low >= 9 & low <= 32){
		if (low == 32)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"2";
	}
	//QV2-3
	if(low >= 33 & low <= 56){
		if (low == 56)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"3";
	}
	//QV2-4
	if(low >= 57 & low <= 80){
		if(low == 80 )
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"4";
	}
	//QV2-5
	if(low >= 81 & low <= 104){
		if(low == 104)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"5";
	}
	//QV2-6
	if(low >= 105 & low <= 128){
		if(low == 128)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"6";
	}
	//QV2-7
	if(low >= 129 & low <= 152){
		if(low == 152)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"7";
	}
	//QV2-8
	if(low >= 153 & low <= 176){
		if (low == 176)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"8";
	}
	//QV2-9
	if(low >= 177 & low <= 200){
		if(low == 200)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"9";
	}
	//QV2-10
	if(low >= 201 & low <= 224){
		if(low == 224)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"10";
	}
	//QV2-11
	if(low >= 225 & low <= 248){
		if(low == 248)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"11";
	}
	//QV2-12
	if(low >= 249 & low <= 272){
		if(low == 272)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"12";
	}
	//QV2-13
	if(low >= 273 & low <= 296){
		if(low == 296)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"13";
	}
	//QV2-14
	if(low >= 297 & low <= 320){
		if(low == 320)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"14";
	}
	//QV2-15
	if(low >= 321 & low <= 344){
		if(low == 344)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"15";
	}
	//QV2-16
	if(low >= 345 & low <= 368){
		if(low == 368)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"16";
	}
	//QV2-17
	if(low >= 369 & low <= 392){
		if(low == 392)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"17";
	}
	//QV2-18
	if(low >= 393 & low <= 416){
		if(low == 416)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"18";
	}
	//QV2-19
	if(low >= 417 & low <= 440){
		if(low == 440)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
		labelFourChannelLow.text = @"19";
	}
	//QV2-20
	if(low >= 441 & low <= 464){
		if(low == 464)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
    voltageDisplayScrollView.contentSize = CGSizeMake(300, 340);
    voltageDisplayScrollView.showsVerticalScrollIndicator = YES;
    //voltageDisplayScrollView.clipsToBounds = YES;

	// Set the background color of the view so we can see it
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
	
	// LED for DC Position 7
	[self.ledDC_7 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledDC_7.opaque = YES; // explicitly opaque for performance
	self.ledDC_7.backgroundColor = [UIColor clearColor];
	
	// LED for AC Position 7
	[self.ledAC_7 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledAC_7.opaque = YES; // explicitly opaque for performance
	self.ledAC_7.backgroundColor = [UIColor clearColor];
	
	// LED for DC Position 8
	[self.ledDC_8 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledDC_8.opaque = YES; // explicitly opaque for performance
	self.ledDC_8.backgroundColor = [UIColor clearColor];
	
	// LED for AC Position 8
	[self.ledAC_8 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
	self.ledAC_8.opaque = YES; // explicitly opaque for performance
	self.ledAC_8.backgroundColor = [UIColor clearColor];
	
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
	
	//PCN4-1,2 DC and AC ripple Check
	
	// DC
	if ([DCVolts_CNN1.text length] > 0)
	{
		[ledDC_1 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		dcVoltage_Value = [DCVolts_CNN1.text doubleValue];
		if((dcVoltage_Value) >= -6.1 & (dcVoltage_Value) <= -6.0)
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
	
	//PCN4-4,6 DC and AC ripple Check
	
	//DC
	if ([DCVolts_CNN2.text length] > 0) {
		[ledDC_2 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		dcVoltage_Value = [DCVolts_CNN2.text doubleValue];
		if((dcVoltage_Value) >= 6.9 & (dcVoltage_Value) <= 7.0)
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
	
	//PCN3-1,2 DC and AC ripple check
	
	//DC
	if ([DCVolts_CNN3.text length] > 0) {
		
		[ledDC_3 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		dcVoltage_Value = [DCVolts_CNN3.text doubleValue];
		if((dcVoltage_Value) >= 12.0 & (dcVoltage_Value) <= 12.1)
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
	
	//PCN3-4,6 DC and AC ripple check
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
	
	//PCN2-1,2 DC and AC ripple check
	//DC
	if ([DCVolts_CNN5.text length] > 0) {
		
		[ledDC_5 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		dcVoltage_Value = [DCVolts_CNN5.text doubleValue];
		if((dcVoltage_Value) >= 12.0 & (dcVoltage_Value) <= 12.1)
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
	//PCN2-4,6 DC and AC ripple check
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
	
	//PCN1-1,2 DC and AC ripple check
	//DC
	if ([DCVolts_CNN7.text length] > 0) {
	
		[ledDC_7 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		dcVoltage_Value = [DCVolts_CNN7.text doubleValue];
		if((dcVoltage_Value) >= -6.1 & (dcVoltage_Value) <= -6.0)
		{
			[ledDC_7 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledDC_7 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
		}
		
	}
	
	//AC
	if ([ACVolts_CNN7.text length] > 0) {
		[ledAC_7 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		acVoltage_Value = [ACVolts_CNN7.text doubleValue];
		if((acVoltage_Value) <= .100)
		{
			[ledAC_7 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledAC_7 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
		}
	}
	
	//PCN1-4,6 DC and AC ripple check
	//DC
	if ([DCVolts_CNN8.text length] > 0) {
		
		[ledDC_8 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		dcVoltage_Value = [DCVolts_CNN8.text doubleValue];
		if((dcVoltage_Value) >= 6.9 & (dcVoltage_Value) <= 7.0)
		{
			[ledDC_8 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledDC_8 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
		}
		
	}
	
	//AC
	if ([ACVolts_CNN8.text length] > 0) {
		[ledAC_8 setImage:[UIImage imageNamed:@"LED_Clear.png"]];
		acVoltage_Value = [ACVolts_CNN8.text doubleValue];
		if((acVoltage_Value) <= .100)
		{
			[ledAC_8 setImage:[UIImage imageNamed:@"LED_Green_On.png"]];
		}else {
			[ledAC_8 setImage:[UIImage imageNamed:@"LED_Red_On.png"]];
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


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    voltageDisplayScrollView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




@end
