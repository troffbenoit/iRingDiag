//
//  AqOneViewController_iPhone.m
//  RingDiag
//
//  Created by Stan Benoit on 6/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AqOneViewController_iPhone.h"


@implementation AqOneViewController_iPhone

@synthesize radiusSlider;
@synthesize labelOneChannelHigh;
@synthesize labelTwoChannelHigh;
@synthesize labelThreeChannelLow;
@synthesize labelFourChannelLow;
@synthesize labelFiveChannelHigh;
@synthesize labelSixChannelLow;

@synthesize radiusValueField;


- (id)init{
	//Call the superclass's designated initializer
	if (!(self = [super initWithNibName:nil
					bundle:nil])) return nil;
	
	// Get the tab bar item
	UITabBarItem *tbi = [self tabBarItem];
	
	// Give it a label
	[tbi setTitle:@"AQ ONE"];
	
	return self;
}



- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    if ((self = [super initWithNibName:nibName bundle:bundle])) {
        // Custom initialization
		return [self init];
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// set background color
	//[[self view] setBackgroundColor:[UIColor redColor]];
	//
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
// get ADC2 QV2
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
	NSLog(@"Low Channel Aq ONE: %d", (int)low);
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
	NSLog(@"High Channel Aq ONE: %d", (int)high);
	NSString *newTextHigh = [[NSString alloc] initWithFormat:@"%d",(int)high];
	labelOneChannelHigh.text = newTextHigh;
	//Low Channel ADC
	if(low >= 1 & low <= 8)
		{
		if(low == 8)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"1";
		labelFourChannelLow.text = @"1";
		}
	
	if(low >= 9 & low <= 32)
		{
		if(low == 32)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"2";
		labelFourChannelLow.text = @"2";
		}
	
	if(low >= 33 & low <= 56)
		{
		if(low == 56)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"3";
		labelFourChannelLow.text = @"3";
		}
	
	if(low >= 57 & low <= 80)
		{
		if(low == 80)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"4";
		labelFourChannelLow.text = @"4";
		}
	
	if(low >= 81 & low <= 104)
		{
		if(low == 104)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"5";
		labelFourChannelLow.text = @"5";
		}
	
	if(low >= 105 & low <= 128)
		{
		if(low == 128)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"6";
		labelFourChannelLow.text =@"6";
		}
	
	if(low >= 129 & low <= 152)
		{
		if(low == 152)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"7";
		labelFourChannelLow.text = @"7";
		}
	
	if(low >= 153 & low <= 176)
		{
		if(low == 176)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"8";
		labelFourChannelLow.text = @"8";
		}
	
	if(low >= 177 & low <= 200)
		{
		if(low == 200)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"9";
		labelFourChannelLow.text = @"9";
		}
	
	if(low >= 201 & low <= 224)
		{
		if(low == 224)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"10";
		labelFourChannelLow.text = @"10";
		}
	
	if(low >= 225 & low <= 248)
		{
		if(low == 248)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"11";
		labelFourChannelLow.text = @"11";
		}
	
	if(low >= 249 & low <= 272)
		{
		if(low == 272)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"12";
		labelFourChannelLow.text = @"12";
		}
	
	if(low >= 273 & low <= 296)
		{
		if(low == 296)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"13";
		labelFourChannelLow.text = @"13";
		}
	
	if(low >= 297 & low <= 320)
		{
		if(low == 320)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"14";
		labelFourChannelLow.text = @"14";
		}
	
	if(low >= 321 & low <= 344)
		{
		if(low == 344)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"15";
		labelFourChannelLow.text = @"15";
		}
	
	if(low >= 345 & low <= 368)
		{
		if(low == 368)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"16";
		labelFourChannelLow.text = @"16";
		}
	
	if(low >= 369 & low <= 392)
		{
		if(low == 392)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"17";
		labelFourChannelLow.text = @"17";
		}
	
	if(low >= 393 & low <= 416)
		{
		if(low == 416)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"18";
		labelFourChannelLow.text = @"18";
		}
	
	if(low >= 417 & low <= 440)
		{
		if(low == 440)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"19";
		labelFourChannelLow.text = @"19";
		}
	
	if(low >= 441 & low <= 464)
		{
		if(low == 464)
			{
			[labelSixChannelLow setTextColor:[UIColor redColor]];
			[labelFourChannelLow setTextColor:[UIColor redColor]];
			}
		labelSixChannelLow.text = @"20";
		labelFourChannelLow.text = @"20";
		}
	
	if(high >= 441 & high <= 464){
		if(high == 464)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"20";
		labelFiveChannelHigh.text = @"20";
	}
	
	if(high >= 465 & high <= 488){
		if(high == 488)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"21";
		labelFiveChannelHigh.text = @"21";
	}
	
	if(high >= 489 & high <= 512){
		if(high == 512)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"22";
		labelFiveChannelHigh.text = @"22";
	}
	
	if(high >= 513 & high <= 536){
		if(high == 536)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"23";
		labelFiveChannelHigh.text = @"23";
	}
	
	if(high >= 537 & high <= 560){
		if(high == 560)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"24";
		labelFiveChannelHigh.text = @"24";
	}
	
	if(high >= 561 & high <= 584){
		if(high == 584)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"25";
		labelFiveChannelHigh.text = @"25";
	}
	
	if(high >= 585 & high <= 608){
		if(high == 608)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"26";
		labelFiveChannelHigh.text = @"26";
	}
	
	if(high >= 609 & high <= 632){
		if(high == 632)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"27";
		labelFiveChannelHigh.text = @"27";
	}
	
	if(high >= 633 & high <= 656){
		if(high == 656)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"28";
		labelFiveChannelHigh.text = @"28";
	}
	
	if(high >= 657 & high <= 680){
		if(high == 680)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"29";
		labelFiveChannelHigh.text = @"29";
	}
	
	if(high >= 681 & high <= 704){
		if(high == 704)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"30";
		labelFiveChannelHigh.text = @"30";
	}
	
	if(high >= 705 & high <= 728){
		if(high == 728)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"31";
		labelFiveChannelHigh.text = @"31";
	}
	
	if(high >= 729 & high <= 752){
		if(high == 752)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"32";
		labelFiveChannelHigh.text = @"32";
	}
	
	if(high >= 753 & high <= 776){
		if(high == 776)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"33";
		labelFiveChannelHigh.text = @"33";
	}
	
	if(high >= 777 & high <= 800){
		if(high == 800)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"34";
		labelFiveChannelHigh.text = @"34";
	}
	
	if(high >= 801 & high <= 824){
		if(high == 824)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"35";
		labelFiveChannelHigh.text = @"35";
	}
	
	if(high >= 825 & high <= 848){
		if(high == 848)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"36";
		labelFiveChannelHigh.text = @"36";
	}
	
	if(high >= 849 & high <= 872){
		if(high == 872)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"37";
		labelFiveChannelHigh.text = @"37";
	}
	
	if(high >= 873 & high <= 896){
		if(high == 896)
			{
			[labelTwoChannelHigh setTextColor:[UIColor redColor]];
			[labelFiveChannelHigh setTextColor:[UIColor redColor]];
			}
		labelTwoChannelHigh.text = @"38";
		labelFiveChannelHigh.text = @"38";
	}
	
	
	
	
	
}	

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
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
