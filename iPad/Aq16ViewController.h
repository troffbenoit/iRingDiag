//
//  Aq16ViewController.h
//  RingDiag
//
//  Created by Stan Benoit on 6/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Aq16ViewController : UIViewController {
	IBOutlet UISlider *radiusSlider;
	IBOutlet UILabel *labelOneChannelHigh;
	IBOutlet UILabel *labelTwoChannelHigh;
	IBOutlet UILabel *labelThreeChannelLow;
	IBOutlet UILabel *labelFourChannelLow;
	IBOutlet UITextField *radiusValueField;
	
	//
	// LED's for voltage test
	// Green Dark = off
	// Green Light = Good
	// Red Light = Fail
	// DC Volts
	IBOutlet UIImageView *ledDC_1;
	IBOutlet UIImageView *ledDC_2;
	IBOutlet UIImageView *ledDC_3;
	IBOutlet UIImageView *ledDC_4;
	IBOutlet UIImageView *ledDC_5;
	IBOutlet UIImageView *ledDC_6;
	
	// AC Volts
	IBOutlet UIImageView *ledAC_1;
	IBOutlet UIImageView *ledAC_2;
	IBOutlet UIImageView *ledAC_3;
	IBOutlet UIImageView *ledAC_4;
	IBOutlet UIImageView *ledAC_5;
	IBOutlet UIImageView *ledAC_6;
	
	//Text fields for voltage input
	//DC voltages
	IBOutlet UITextField *DCVolts_CNN1;
	IBOutlet UITextField *DCVolts_CNN2;
	IBOutlet UITextField *DCVolts_CNN3;
	IBOutlet UITextField *DCVolts_CNN4;
	IBOutlet UITextField *DCVolts_CNN5;
	IBOutlet UITextField *DCVolts_CNN6;
	IBOutlet UITextField *DCVolts_CNN7;
	IBOutlet UITextField *DCVolts_CNN8;
	
	//AC voltages
	IBOutlet UITextField *ACVolts_CNN1;
	IBOutlet UITextField *ACVolts_CNN2;
	IBOutlet UITextField *ACVolts_CNN3;
	IBOutlet UITextField *ACVolts_CNN4;
	IBOutlet UITextField *ACVolts_CNN5;
	IBOutlet UITextField *ACVolts_CNN6;
	IBOutlet UITextField *ACVolts_CNN7;
	IBOutlet UITextField *ACVolts_CNN8;
}
//
// Labels
@property(strong, nonatomic)IBOutlet UILabel *labelOneChannelHigh;
@property(strong, nonatomic)IBOutlet UILabel *labelTwoChannelHigh;
@property(strong, nonatomic)IBOutlet UILabel *labelThreeChannelLow;
@property(strong, nonatomic)IBOutlet UILabel *labelFourChannelLow;

//
// Background LED image
@property(strong, nonatomic)IBOutlet UIImageView *ledDC_1;
@property(strong, nonatomic)IBOutlet UIImageView *ledDC_2;
@property(strong, nonatomic)IBOutlet UIImageView *ledDC_3;
@property(strong, nonatomic)IBOutlet UIImageView *ledDC_4;
@property(strong, nonatomic)IBOutlet UIImageView *ledDC_5;
@property(strong, nonatomic)IBOutlet UIImageView *ledDC_6;

@property(strong, nonatomic)IBOutlet UIImageView *ledAC_1;
@property(strong, nonatomic)IBOutlet UIImageView *ledAC_2;
@property(strong, nonatomic)IBOutlet UIImageView *ledAC_3;
@property(strong, nonatomic)IBOutlet UIImageView *ledAC_4;
@property(strong, nonatomic)IBOutlet UIImageView *ledAC_5;
@property(strong, nonatomic)IBOutlet UIImageView *ledAC_6;
//Text fields for voltage input
//DC voltages
@property(strong, nonatomic) IBOutlet UITextField *DCVolts_CNN1;
@property(strong, nonatomic) IBOutlet UITextField *DCVolts_CNN2;
@property(strong, nonatomic) IBOutlet UITextField *DCVolts_CNN3;
@property(strong, nonatomic) IBOutlet UITextField *DCVolts_CNN4;
@property(strong, nonatomic) IBOutlet UITextField *DCVolts_CNN5;
@property(strong, nonatomic) IBOutlet UITextField *DCVolts_CNN6;
@property(strong, nonatomic) IBOutlet UITextField *DCVolts_CNN7;
@property(strong, nonatomic) IBOutlet UITextField *DCVolts_CNN8;

//AC voltages
@property(strong, nonatomic) IBOutlet UITextField *ACVolts_CNN1;
@property(strong, nonatomic) IBOutlet UITextField *ACVolts_CNN2;
@property(strong, nonatomic) IBOutlet UITextField *ACVolts_CNN3;
@property(strong, nonatomic) IBOutlet UITextField *ACVolts_CNN4;
@property(strong, nonatomic) IBOutlet UITextField *ACVolts_CNN5;
@property(strong, nonatomic) IBOutlet UITextField *ACVolts_CNN6;
@property(strong, nonatomic) IBOutlet UITextField *ACVolts_CNN7;
@property(strong, nonatomic) IBOutlet UITextField *ACVolts_CNN8;

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
//find bad converter 16
- (void)findBadBoard:(float)radiusMeasured;

//
// Power Supply
- (IBAction)powerSupplyCheck:(id)sender;
- (IBAction)DismissPowerSupplyCheckKeyboard:(id)sender;



@end
