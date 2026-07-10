//
//  Aq16ViewController_iPhone.m
//  RingDiag
//
//  Created by Stan Benoit on 6/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Aq16ViewController_iPhone.h"



@implementation Aq16ViewController_iPhone

@synthesize radiusSlider;
@synthesize labelOneChannelHigh;
@synthesize labelTwoChannelHigh;
@synthesize labelThreeChannelLow;
@synthesize labelFourChannelLow;
@synthesize radiusValueField;


- (id)init{
	// Call the superclass's designated initializer
	if (!(self = [super initWithNibName:nil
					bundle:nil])) return nil;
	
	// Get the tab bar item
	UITabBarItem *tbi = [self tabBarItem];
	
	// Give it a label
	[tbi setTitle:@"AQ 16"];
	
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
// get CONV16 

// 23 Oct 2011 added 5 channel yellow text message
//             alerts user when they are within 5 channel 
//             transistion point
- (void)findBadBoard:(float)radius_measured{
	
	float ringMeasure;
	float low;
	float high;
	float x;
	
	[labelOneChannelHigh setTextColor:[UIColor blackColor]];
	NSLog(@"label One info: %@", [labelOneChannelHigh description]);
	[labelTwoChannelHigh setTextColor:[UIColor blackColor]];
	[labelThreeChannelLow setTextColor:[UIColor blackColor]];
	[labelFourChannelLow setTextColor:[UIColor blackColor]];
    
	
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
	
    //
    // Low side of the detector
	//find converter 16 for low side
	if(low >= 1 & low <= 32){
		if(low == 32)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >=28 && low <= 31) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }
		labelFourChannelLow.text = @"1";
	}
	
	if(low >= 33 & low <= 80){
		if(low == 80)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >=75 && low <=79) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }
		labelFourChannelLow.text = @"2";
	}
	
	if(low >= 81 & low <= 128){
		if(low == 128)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 123 && low <= 127) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }
		labelFourChannelLow.text = @"3";
	}
	
	if(low >= 129 & low <= 152){
		if(low == 152)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 147 && low <= 152) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }

		labelFourChannelLow.text = @"4";
	}
	
	if(low >= 153 & low <= 176){
		if(low == 176)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 171 && low <= 175) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }

		labelFourChannelLow.text = @"5";
	}
	
	if(low >= 177 & low <= 200){
		if(low == 200)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 195 && low <= 199) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }

		labelFourChannelLow.text = @"6";
	}
	
	if(low >= 201 & low <= 224){
		if(low == 224)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 219 && low <= 223 ) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }

		labelFourChannelLow.text = @"7";
	}
	
	if(low >= 225 & low <= 248){
		if(low == 248)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 243 && low <= 247) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }

		labelFourChannelLow.text = @"8";
	}
	
	if(low >= 249 & low <= 272){
		if(low == 272)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 267 && low <= 271) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }

		labelFourChannelLow.text = @"9";
	}
	
	if(low >= 273 & low <= 296){
		if(low == 296)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 291 && low <= 295) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }

		labelFourChannelLow.text = @"10";
	}
	
	if(low >= 297 & low <= 320){
		if(low == 320)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 315 && low <= 319) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }

		labelFourChannelLow.text = @"11";
	}
	
	if(low >= 321 & low <= 341){
		if(low == 341)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 336 && low <= 340) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }

		labelFourChannelLow.text = @"12";
	}
	
	if(low >= 342 & low <= 368){
		if(low == 368)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 363 && low <= 367) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }

		labelFourChannelLow.text = @"13";
	}
	
	if(low >= 369 & low <= 392){
		if(low == 392)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 387 && low <= 391) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }

		labelFourChannelLow.text = @"14";
	}
	
	if(low >= 393 & low <= 416){
		if(low == 416)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 411 && low <= 415) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }

		labelFourChannelLow.text = @"15";
	}
	
	if(low >= 417 & low <= 440){
		if(low == 440)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 435 && low <= 439) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }

		labelFourChannelLow.text = @"16";
	}
	
	if(low >= 441 & low <= 464){
		if(low == 464)
			[labelFourChannelLow setTextColor:[UIColor redColor]];
        if (low >= 459 && low <= 463) {
            [labelFourChannelLow setTextColor:[UIColor yellowColor]];
        }

		labelFourChannelLow.text = @"17";
	}
	
    // Now the high side of the detector
    //
	//High Side 
    //
	if(high >= 441 & high <= 464){
		if(high == 464)
			[ labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 459 && high <= 463) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }

		labelTwoChannelHigh.text = @"17";
	}
	
	if(high >= 465 & high <= 488){
		if(high == 488)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 483 && high <= 487) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
		labelTwoChannelHigh.text = @"18";
	}
	
	if(high >= 489 & high <= 512){
		if(high == 512)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 507 && high <= 511) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
        
		labelTwoChannelHigh.text = @"19";
	}
	
	if(high >= 513 & high <= 536){
		if(high == 536)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 531 && high <= 535) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
		labelTwoChannelHigh.text = @"20";
	}
	
	if(high >= 537 & high <= 560){
		if(high == 560)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 555 && high <= 559) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
		labelTwoChannelHigh.text = @"21";
	}
	
	if(high >= 561 & high <= 584){
		if(high == 584)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 579 && high <= 583) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
		labelTwoChannelHigh.text = @"22";
	}
	
	if(high >= 585 & high <= 608){
		if(high == 608)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 580 && high <= 607) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
		labelTwoChannelHigh.text = @"23";
	}
	
	if(high >= 609 & high <= 632){
		if(high == 632)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 627 && high <= 631) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
		labelTwoChannelHigh.text = @"24";
	}
	
	if(high >= 633 & high <= 656){
		if(high == 656)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 651 && high <= 655) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
		labelTwoChannelHigh.text = @"25";
	}
	
	if(high >= 657 & high <= 680){
		if(high == 680)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 675 && high <= 679) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
		labelTwoChannelHigh.text = @"26";
	}
	
	if(high >= 681 & high <= 704){
		if(high == 704)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 699 && high <= 703 ) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
		labelTwoChannelHigh.text = @"27";
	}
	
	if(high >= 705 & high <= 728){
		if(high == 728)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 459 && high <= 463) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
		labelTwoChannelHigh.text = @"28";
	}
	
	if(high >= 729 & high <= 752){
		if(high == 752)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 723 && high <= 751) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
		labelTwoChannelHigh.text = @"29";
	}
	
	if(high >= 753 & high <= 800){
		if(high == 800)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 795 && high <= 799) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
		labelTwoChannelHigh.text = @"30";
	}
	
	if(high >= 801 & high <= 848){
		if(high == 848)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 796 && high <= 847) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
		labelTwoChannelHigh.text = @"31";
	}
	
	if(high >= 849 & high <= 896){
		if(high == 896)
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
        if (high >= 891 && high <= 895) {
            [ labelTwoChannelHigh setTextColor:[UIColor yellowColor]];
        }
		labelTwoChannelHigh.text = @"32";
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
