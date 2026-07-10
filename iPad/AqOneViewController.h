//
//  AqOneViewController.h
//  RingDiag
//
//  Created by Stan Benoit on 6/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AqOneViewController : UIViewController {
	IBOutlet UISlider *radiusSlider;
	
	IBOutlet UILabel *labelOneChannelHigh;
	IBOutlet UILabel *labelTwoChannelHigh;
	IBOutlet UILabel *labelThreeChannelLow;
	IBOutlet UILabel *labelFourChannelLow;
	// 32/64 QV2 ADC
	IBOutlet UILabel *labelFiveChannelHigh;
	IBOutlet UILabel *labelSixChannelLow;
	
	IBOutlet UITextField *radiusValueField;
	

}

//
// Labels
@property(strong, nonatomic)IBOutlet UILabel *labelOneChannelHigh;
@property(strong, nonatomic)IBOutlet UILabel *labelTwoChannelHigh;
@property(strong, nonatomic)IBOutlet UILabel *labelThreeChannelLow;
@property(strong, nonatomic)IBOutlet UILabel *labelFourChannelLow;
@property(strong, nonatomic)IBOutlet UILabel *labelFiveChannelHigh;
@property(strong, nonatomic)IBOutlet UILabel *labelSixChannelLow;

//
// Text Fields
@property(strong, nonatomic)IBOutlet UITextField *radiusValueField;

//
// Slider
@property(strong, nonatomic)IBOutlet UISlider *radiusSlider;

//
// Methods

// Change of radisu value textfield
- (IBAction)sliderValueChange:(UISlider *)sender;

//
//dismiss keyboard
-(IBAction)textFieldDoneEditing:(id)sender;

//
//find bad converter 32/64
- (void)findBadBoard:(float)radiusMeasured;

@end
