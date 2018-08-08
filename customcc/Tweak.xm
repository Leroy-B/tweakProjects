/*
TODO LIST:
	- dismiss keyboard on tap anywhere else
	-	(hard) draw cc like snapper2
	- does landscape work yet?
	- hide header view Altogether (u/shotnine)
	- hide view colletion earlier than normal on dismiss
	- dim background toggles normal
*/

#import "libcolorpicker.h"


@interface SBControlCenterWindow : UIView
	@property (assign,setter=_setCornerRadius:,nonatomic) double _cornerRadius;
  @property (nonatomic,assign,readwrite) CGAffineTransform transform;
@end

@interface CCUIHeaderPocketView : UIView
  @property (nonatomic,assign,readwrite) CGAffineTransform transform;
	@property (nonatomic,assign,readwrite) BOOL hidden;
	@property (nonatomic,assign,readwrite) CGRect frame;
@end

@interface _MTBackdropView : SBControlCenterWindow
	@property (assign,nonatomic) double blurRadius;
	@property (nonatomic, copy, readwrite) UIColor *colorAddColor;
@end

static bool enableTweak = NO;
static NSString *colorPrefCustom;

static NSString *backgroundBlurPrefChoice;
static NSString *backgroundBlurPrefCustom;

static NSString *posPrefChoice;
static NSString *posPrefX;
static NSString *posPrefY;
//CC size
static NSString *sizePrefChoice;
static NSString *sizePrefW;
static NSString *sizePrefH;
//CC cornerRadius
static NSString *cornerRadiusPrefChoice;
static NSString *cornerRadiusPrefCustom;
//CC scale
static NSString *scaleCCPrefChoice;
static NSString *scaleCCPrefH;
static NSString *scaleCCPrefW;

static NSString *alphaViewPrefChoice;
static NSString *alphaViewPrefCustom;

static NSString *posHeaderViewPrefChoice;
static NSString *posHeaderViewPrefH;
static NSString *posHeaderViewPrefW;
static bool hideHeaderPref = NO;

static NSString *posCollectionViewPrefChoice;
static NSString *posCollectionViewPrefX;
static NSString *posCollectionViewPrefY;


#define PLIST_PATH "/var/mobile/Library/Preferences/com.leroy.CustomCCPreferences.plist"
#define PreferencesChangedNotification "com.leroy.CustomCCPreferences/preferencesChanged"
#define boolValueForKey(key) [[[NSDictionary dictionaryWithContentsOfFile:@(PLIST_PATH)] valueForKey:key] boolValue]
#define valueForKey(key) [[NSDictionary dictionaryWithContentsOfFile:@(PLIST_PATH)] valueForKey:key]

static void loadPreferences() {
    enableTweak = boolValueForKey(@"enableTweak");
    colorPrefCustom = valueForKey(@"colorPrefCustom");

		backgroundBlurPrefChoice = valueForKey(@"backgroundBlurPrefChoice");
		backgroundBlurPrefCustom = valueForKey(@"backgroundBlurPrefCustom");

		posPrefChoice = valueForKey(@"posPrefChoice");
		posPrefX = valueForKey(@"posPrefX");
		posPrefY = valueForKey(@"posPrefY");

		sizePrefChoice = valueForKey(@"sizePrefChoice");
		sizePrefW = valueForKey(@"sizePrefW");
		sizePrefH = valueForKey(@"sizePrefH");

		cornerRadiusPrefChoice = valueForKey(@"cornerRadiusPrefChoice");
		cornerRadiusPrefCustom = valueForKey(@"cornerRadiusPrefCustom");

		scaleCCPrefChoice = valueForKey(@"scaleCCPrefChoice");
		scaleCCPrefH = valueForKey(@"scaleCCPrefH");
		scaleCCPrefW = valueForKey(@"scaleCCPrefW");

		alphaViewPrefChoice = valueForKey(@"alphaViewPrefChoice");
		alphaViewPrefCustom = valueForKey(@"alphaViewPrefCustom");

		posHeaderViewPrefChoice = valueForKey(@"posHeaderViewPrefChoice");
		posHeaderViewPrefH = valueForKey(@"posHeaderViewPrefH");
		posHeaderViewPrefW = valueForKey(@"posHeaderViewPrefW");
		hideHeaderPref = boolValueForKey(@"hideHeaderPref");

		posCollectionViewPrefChoice = valueForKey(@"posCollectionViewPrefChoice");
		posCollectionViewPrefX = valueForKey(@"posCollectionViewPrefX");
		posCollectionViewPrefY = valueForKey(@"posCollectionViewPrefY");
}

static void setValueForKey(id value, NSString *key) {
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:@(PLIST_PATH)];
    [dict setValue:value forKey:key];
    [dict writeToFile:@(PLIST_PATH) atomically:YES];
}

%hook _MTBackdropView

	-(void)layoutSubviews {
		loadPreferences();
		if(!enableTweak){
			%orig();
		} else {
			self.colorAddColor = LCPParseColorString(colorPrefCustom, nil);
			%orig();
		}
	}

	-(void)setBlurRadius:(double)arg1 {
		loadPreferences();
		double myBlur = 30;
		if(!enableTweak){
			%orig(arg1);
		} else {
			if ([backgroundBlurPrefChoice isEqualToString:@"Default"]){
				myBlur = 30;
			} else if ([backgroundBlurPrefChoice isEqualToString:@"25"]) {
				myBlur = 15;
			} else if ([backgroundBlurPrefChoice isEqualToString:@"none"]) {
				myBlur = 0;
			} else if ([backgroundBlurPrefChoice isEqualToString:@"Custom"]) {
				if ([backgroundBlurPrefCustom isEqualToString:@""]) {
					myBlur = 30;
				} else {
					myBlur = [backgroundBlurPrefCustom doubleValue];
				}
			}
			%orig(myBlur);
		}
	}
%end

@interface SBControlCenterController : NSObject
@end

%hook SBControlCenterController
	-(void)dismissAnimated:(BOOL)arg1 {
		%orig(arg1);
		NSLog(@"CustomCC LOG: arg1 is : %s", arg1 ? "true" : "false");

			// self = [super initWithFrame:frame];
			// self.backgroundColor = [UIColor clearColor];
			// self.windowLevel = UIWindowLevelStatusBar + 100.0;
			//
			// UIView *redRectangle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
			// [redRectangle setBackgroundColor:[UIColor redColor]];
			// [self.view addSubview:redRectangle];
			// UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:redRectangle action:@selector(handleTapGesture:)];
			// [self.view addGestureRecognizer:tap];

	}

%end

@interface SpringBoard : UIViewController
	-(void)_runControlCenterDismissTest;
@end

%hook SpringBoard

	%new
	-(void)handleTapGesture:(UITapGestureRecognizer* )sender {
		%log;
		//[[%c(SpringBoard) sharedApplication] _runControlCenterDismissTest];
		//[[%c(SBControlCenterController) sharedApplication] dismissAnimated];
		//[(SBHomeScreenViewController *)[%c(SBHomeScreenViewController) sharedApplication] dismissAnimated];
		//[(SpringBoard *)[UIApplication sharedApplication] _runControlCenterDismissTest];
		//[[%c(SBControlCenterController) sharedApplication] dismissAnimated];
		//-[SBControlCenterController dismissAnimated]
		//[[%c(SBHomeScreenViewController) sharedApplication] dismissAnimated];
	}

%end

%hook SBControlCenterWindow

  -(void)setAlphaAndObeyBecauseIAmTheWindowManager:(double)arg1 {
		loadPreferences();
		double myAlpha = 100;

    if(!enableTweak){
      %orig(arg1);
    } else {
      if ([alphaViewPrefChoice isEqualToString:@"Default"]) {
        myAlpha = 100;
      } else if ([alphaViewPrefChoice isEqualToString:@"50"]) {
        myAlpha = 50;
      } else if ([alphaViewPrefChoice isEqualToString:@"25"]) {
        myAlpha = 25;
      } else if ([alphaViewPrefChoice isEqualToString:@"Custom"]) {
        if ([alphaViewPrefCustom isEqualToString:@""]) {
          myAlpha = 100;
        } else {
          myAlpha = [alphaViewPrefCustom doubleValue];
        }
      }
			setValueForKey(alphaViewPrefChoice, @"alphaViewPrefChoice");
			setValueForKey(alphaViewPrefCustom, @"alphaViewPrefCustom");
      %orig(myAlpha/100);
    }

  }

  -(void)setFrame:(CGRect)arg1 {
		loadPreferences();
    CGRect newFrame = arg1;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;

    if (!enableTweak) {
      return %orig(arg1);
    } else {
		//else the tweak is enabled <start>
			// CCPos <start>
      if ([posPrefChoice isEqualToString:@"Default"]) {
        newFrame.origin.y = 0;
      } else if ([posPrefChoice isEqualToString:@"Bottom"]){
        newFrame.origin.y = screenHeight - newFrame.size.height;
      } else if ([posPrefChoice isEqualToString:@"Midpoint"]) {
        newFrame.origin.y = screenHeight/2;
      } else if ([posPrefChoice isEqualToString:@"Above Dock"]) {
        double posAboveDock = screenHeight - 93;
        if ([sizePrefChoice isEqualToString:@"Half"]){
          newFrame.origin.y = posAboveDock - (screenHeight/2);
        } else if ([sizePrefChoice isEqualToString:@"Custom"]) {
          newFrame.origin.y = posAboveDock - [sizePrefH doubleValue];
        } else {
          newFrame.origin.y = posAboveDock;
        }
      } else if ([posPrefChoice isEqualToString:@"Custom"]) {
        if ([posPrefX isEqualToString:@""]) {
          newFrame.origin.x = 0;
        } else {
          newFrame.origin.x = [posPrefX doubleValue];
        }
        if ([posPrefY isEqualToString:@""]) {
          newFrame.origin.y = 0;
        } else {
          newFrame.origin.y = [posPrefY doubleValue];
        }
      }
			setValueForKey(posPrefChoice, @"posPrefChoice");
			setValueForKey(posPrefX, @"posPrefX");
			setValueForKey(posPrefY, @"posPrefY");
			// CCPos <end>

      if ([sizePrefChoice isEqualToString:@"Full"]) {
        newFrame.origin.y = 0;
        newFrame.origin.x = 0;
        newFrame.size.height = screenHeight;
        newFrame.size.width = screenWidth;
      } else if ([sizePrefChoice isEqualToString:@"Half"]) {
        newFrame.size.height = screenHeight/2;
      } else if ([sizePrefChoice isEqualToString:@"Custom"]) {
        if ([sizePrefW isEqualToString:@""]) {
          newFrame.size.width = screenWidth;
        } else {
          newFrame.size.width = [sizePrefW doubleValue];
        }
        if ([sizePrefH isEqualToString:@""]) {
          newFrame.size.height = screenHeight;
        } else {
          newFrame.size.height = [sizePrefH doubleValue];
        }
      }

      if ([posPrefChoice isEqualToString:@"Bottom"] && [sizePrefChoice isEqualToString:@"Custom"]) {
        newFrame.origin.y = screenHeight - [sizePrefH doubleValue];
      }
			setValueForKey(sizePrefChoice, @"sizePrefChoice");
			setValueForKey(sizePrefH, @"sizePrefH");
			setValueForKey(sizePrefW, @"sizePrefW");
      %orig(newFrame);

      //setCornerRadius <start>
			double cornerRadius = 0;
			if ([cornerRadiusPrefChoice isEqualToString:@""]) {
				NSLog(@"CustomCC ERROR: cornerRadiusPrefChoice is empty!");
			} else {
				NSDictionary *cases = @{@"Default" : @0,
                        						 @"25" : @1,
																		 @"50" : @2,
																 @"Custom" : @3,
															 };
				NSNumber *value = 0;
				value = [cases objectForKey:cornerRadiusPrefChoice];
				NSLog(@"CustomCC LOG: cornerRadiusPrefChoice value is: %@", value);
				switch ([value intValue]) {
					case 0://default
						cornerRadius = 0;
						break;
					case 1://25
						cornerRadius = 25;
						break;
					case 2://50
						cornerRadius = 50;
						break;
					case 3://custom
						if ([cornerRadiusPrefCustom isEqualToString:@""]) {
							cornerRadius = 0;
						} else {
							cornerRadius = [cornerRadiusPrefCustom doubleValue];
						}
						break;
					default:
						NSLog(@"CustomCC ERROR: cornerRadiusPrefChoice switch is default!");
						cornerRadius = 0;
						break;
				}
				self._cornerRadius = cornerRadius;
				setValueForKey(cornerRadiusPrefChoice, @"cornerRadiusPrefChoice");
				setValueForKey(cornerRadiusPrefCustom, @"cornerRadiusPrefCustom");
			}
			//setCornerRadius <end>

			//setScaleCC start
			double scaleH = 0;
			double scaleW = 0;
			if ([scaleCCPrefChoice isEqualToString:@""]) {
				NSLog(@"CustomCC ERROR: scaleCCPrefChoice is empty!");
			} else {
				NSDictionary *cases = @{@"Default" : @0,
                        						 @"75" : @1,
																		 @"50" : @2,
																 @"Custom" : @3,
															 };
				NSNumber *value = 0;
				value = [cases objectForKey:scaleCCPrefChoice];
				NSLog(@"CustomCC LOG: scaleCCPrefChoice value is: %@", value);
				switch ([value intValue]) {
					case 0://default
						scaleH = scaleW = 100;
						break;
					case 1://75
						scaleH = scaleW = 75;
						break;
					case 2://50
						scaleH = scaleW = 50;
						break;
					case 3://custom
						if (([scaleCCPrefH isEqualToString:@""]) && ([scaleCCPrefW isEqualToString:@""])) {
							scaleH = scaleW = 100;
						} else {
							if ([scaleCCPrefH isEqualToString:@""]) {
								scaleH = 100;
								scaleW = [scaleCCPrefW doubleValue];
							} else if ([scaleCCPrefW isEqualToString:@""]) {
								scaleH = [scaleCCPrefH doubleValue];
								scaleW = 100;
							} else {
								scaleH = [scaleCCPrefH doubleValue];
								scaleH = [scaleCCPrefH doubleValue];
							}
						}
						break;
					default:
						NSLog(@"CustomCC ERROR: scaleCCPrefChoice switch is default!");
						scaleH = scaleW = 100;
						break;
				}
				self.transform = CGAffineTransformMakeScale(scaleW/100, scaleH/100);
				setValueForKey(scaleCCPrefChoice, @"scaleCCPrefChoice");
				setValueForKey(scaleCCPrefH, @"scaleCCPrefH");
				setValueForKey(scaleCCPrefW, @"scaleCCPrefW");
			}
			//setScaleCC <end>
    }
		//else the tweak is enabled <end>
  }

%end

%hook CCUIHeaderPocketView

    -(void)setFrame:(CGRect)arg1{
			loadPreferences();
      CGRect newFrame = arg1;
			CGSize screenSize = [UIScreen mainScreen].bounds.size;
	    //double screenHeight = screenSize.height;
	    double screenWidth = screenSize.width;

			double headerSizeH = 64;
			double headerSizeW = screenWidth;

			if (!enableTweak) {
	      return %orig(arg1);
	    } else {
				if ([posHeaderViewPrefChoice isEqualToString:@""]) {
					NSLog(@"CustomCC ERROR: posHeaderViewPrefChoice is empty!");
				} else {
					NSDictionary *cases = @{@"Default" : @0,
                    						 		 @"Half" : @1,
															 	  @"Quarter" : @2,
																	 @"Custom" : @3,
																 };
					NSNumber *value = 0;
					value = [cases objectForKey:posHeaderViewPrefChoice];
					NSLog(@"CustomCC LOG: posHeaderViewPrefChoice value is: %@", value);
					switch ([value intValue]) {
						case 0://default
							headerSizeH = 64;
							break;
						case 1://Half
							headerSizeH = 32;
							break;
						case 2://Quarter
							headerSizeH = 16;
							break;
						case 3://custom
							if (([posHeaderViewPrefH isEqualToString:@""]) && ([posHeaderViewPrefW isEqualToString:@""])) {
								headerSizeH = 64;
								headerSizeW = screenWidth;
							} else {
								if ([posHeaderViewPrefH isEqualToString:@""]) {
									headerSizeH = 64;
									headerSizeW = [posHeaderViewPrefW doubleValue];
								} else if ([posHeaderViewPrefW isEqualToString:@""]) {
									headerSizeH = [posHeaderViewPrefH doubleValue];
									headerSizeW = screenWidth;
								} else {
									headerSizeH = [posHeaderViewPrefH doubleValue];
									headerSizeW = [posHeaderViewPrefW doubleValue];
								}
							}
							break;
						default:
							NSLog(@"CustomCC ERROR: posHeaderViewPrefChoice switch is default!");
							headerSizeH = 64;
							headerSizeW = screenWidth;
							break;
					}
					newFrame.size.height = headerSizeH;
					newFrame.size.width = headerSizeW;
					%orig(newFrame);
				}
			}
			if (hideHeaderPref) {
				self.hidden = YES;
				newFrame.size.height = 0;
			} else {
				self.hidden = NO;
				newFrame.size.height = headerSizeH;
			}
			setValueForKey(posHeaderViewPrefChoice, @"posHeaderViewPrefChoice");
			setValueForKey(posHeaderViewPrefH, @"posHeaderViewPrefH");
			setValueForKey(posHeaderViewPrefW, @"posHeaderViewPrefW");
			//setValueForKey(hideHeaderPref, @"hideHeaderPref");
    }

%end

%hook CCUIModuleCollectionView

    -(void)setFrame:(CGRect)arg1{
			loadPreferences();
      CGRect newFrame = arg1;

			if (!enableTweak) {
	      return %orig(arg1);
	    } else {
				//ModuleCollectionPos <start>
				double posX = 0;
				double posY = 0;
				if ([posCollectionViewPrefChoice isEqualToString:@""]) {
					NSLog(@"CustomCC ERROR: posCollectionViewPrefChoice is empty!");
				} else {
					NSDictionary *cases = @{@"Default" : @0,
                        						 	@"Top" : @1,
																	 @"Bottom" : @2,
																	 @"Custom" : @3,
																 };
					NSNumber *value = 0;
					value = [cases objectForKey:posCollectionViewPrefChoice];
					NSLog(@"CustomCC LOG: posCollectionViewPrefChoice value is: %@", value);
					switch ([value intValue]) {
						case 0://default
							posX = 0;
							posY = 0;
							break;
						case 1://top
							posY = -40;
							break;
						case 2://bottom
							posY = 50;
							break;
						case 3://custom
							if (([posCollectionViewPrefX isEqualToString:@""]) && ([posCollectionViewPrefY isEqualToString:@""])) {
								posX = posY = 0;
							} else {
								if ([posCollectionViewPrefX isEqualToString:@""]) {
									posX = 0;
									posY = [posCollectionViewPrefY doubleValue];
								} else if ([posCollectionViewPrefY isEqualToString:@""]) {
									posX = [posCollectionViewPrefX doubleValue];
									posY = 0;
								} else {
									posX = [posCollectionViewPrefX doubleValue];
									posY = [posCollectionViewPrefY doubleValue];
								}
							}
							break;
						default:
							NSLog(@"CustomCC ERROR: posCollectionViewPrefChoice is default!");
							posX = posY = 0;
							break;
					}
					setValueForKey(posCollectionViewPrefChoice, @"posCollectionViewPrefChoice");
					setValueForKey(posCollectionViewPrefX, @"posCollectionViewPrefX");
					setValueForKey(posCollectionViewPrefY, @"posCollectionViewPrefY");
					newFrame.origin.x = posX;
					newFrame.origin.y = posY;
					%orig(newFrame);
				}
				//ModuleCollectionPos <end>
			}
    }

%end


// static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
// 	[preferences release];
// 	preferences = [[NSDictionary alloc] initWithContentsOfFile:PLIST_PATH];
// }
//
// __attribute__((constructor)) static void hookslaw_init() {
// 	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//
//     formatter = [[NSNumberFormatter alloc] init];
//     [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//
// 	preferences = [[NSDictionary alloc] initWithContentsOfFile:PLIST_PATH];
// 	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, PreferencesChangedCallback, CFSTR(PreferencesChangedNotification), NULL, CFNotificationSuspensionBehaviorCoalesce);
//
//
// 	[pool release];
// }

%ctor {
	@autoreleasepool{
		loadPreferences();
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPreferences, CFSTR("com.leroy.CustomCCPreferences/preferencesChanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	}
}
