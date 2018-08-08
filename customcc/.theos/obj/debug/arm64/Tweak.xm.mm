#line 1 "Tweak.xm"










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

static NSString *sizePrefChoice;
static NSString *sizePrefW;
static NSString *sizePrefH;

static NSString *cornerRadiusPrefChoice;
static NSString *cornerRadiusPrefCustom;

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


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class CCUIModuleCollectionView; @class SpringBoard; @class SBControlCenterController; @class CCUIHeaderPocketView; @class SBControlCenterWindow; @class _MTBackdropView; 
static void (*_logos_orig$_ungrouped$_MTBackdropView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL _MTBackdropView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$_MTBackdropView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL _MTBackdropView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$_MTBackdropView$setBlurRadius$)(_LOGOS_SELF_TYPE_NORMAL _MTBackdropView* _LOGOS_SELF_CONST, SEL, double); static void _logos_method$_ungrouped$_MTBackdropView$setBlurRadius$(_LOGOS_SELF_TYPE_NORMAL _MTBackdropView* _LOGOS_SELF_CONST, SEL, double); static void (*_logos_orig$_ungrouped$SBControlCenterController$dismissAnimated$)(_LOGOS_SELF_TYPE_NORMAL SBControlCenterController* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$_ungrouped$SBControlCenterController$dismissAnimated$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterController* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$_ungrouped$SpringBoard$handleTapGesture$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, UITapGestureRecognizer* ); static void (*_logos_orig$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$)(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, double); static void _logos_method$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, double); static void (*_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$)(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); static void (*_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST, SEL, CGRect); static void (*_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST, SEL, CGRect); 

#line 110 "Tweak.xm"


	static void _logos_method$_ungrouped$_MTBackdropView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL _MTBackdropView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
		loadPreferences();
		if(!enableTweak){
			_logos_orig$_ungrouped$_MTBackdropView$layoutSubviews(self, _cmd);
		} else {
			self.colorAddColor = LCPParseColorString(colorPrefCustom, nil);
			_logos_orig$_ungrouped$_MTBackdropView$layoutSubviews(self, _cmd);
		}
	}

	static void _logos_method$_ungrouped$_MTBackdropView$setBlurRadius$(_LOGOS_SELF_TYPE_NORMAL _MTBackdropView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, double arg1) {
		loadPreferences();
		if(!enableTweak){
      _logos_orig$_ungrouped$_MTBackdropView$setBlurRadius$(self, _cmd, arg1);
    } else {
			
			double customBlur = 30;
			if ([backgroundBlurPrefChoice isEqualToString:@""]) {
				NSLog(@"CustomCC ERROR: backgroundBlurPrefChoice is empty!");
			} else {
				NSDictionary *cases = @{@"Default" : @0,
																		 @"25" : @1,
																		 @"none" : @2,
																 @"Custom" : @3,
															 };
				NSNumber *value = 0;
				value = [cases objectForKey:backgroundBlurPrefChoice];
				NSLog(@"CustomCC LOG: backgroundBlurPrefChoice value is: %@", value);
				switch ([value intValue]) {
					case 0:
						customBlur = 30;
						break;
					case 1:
						customBlur = 7.5;
						break;
					case 2:
						customBlur = 0;
						break;
					case 3:
						if ([backgroundBlurPrefCustom isEqualToString:@""]) {
							customBlur = 30;
						} else {
							customBlur = [backgroundBlurPrefCustom doubleValue];
						}
						break;
					default:
						NSLog(@"CustomCC ERROR: backgroundBlurPrefChoice switch is default!");
						customBlur = 30;
						break;
				}
				_logos_orig$_ungrouped$_MTBackdropView$setBlurRadius$(self, _cmd, customBlur);
				setValueForKey(backgroundBlurPrefChoice, @"backgroundBlurPrefChoice");
				setValueForKey(backgroundBlurPrefCustom, @"backgroundBlurPrefCustom");
			}
			
		}
	}


@interface SBControlCenterController : NSObject
@end


	static void _logos_method$_ungrouped$SBControlCenterController$dismissAnimated$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL arg1) {
		_logos_orig$_ungrouped$SBControlCenterController$dismissAnimated$(self, _cmd, arg1);
		NSLog(@"CustomCC LOG: arg1 is : %s", arg1 ? "true" : "false");

			
			
			
			
			
			
			
			
			

	}



@interface SpringBoard : UIViewController
	-(void)_runControlCenterDismissTest;
@end



	
	static void _logos_method$_ungrouped$SpringBoard$handleTapGesture$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITapGestureRecognizer*  sender) {
		HBLogDebug(@"-[<SpringBoard: %p> handleTapGesture:%@]", self, sender);
		
		
		
		
		
		
		
	}





  static void _logos_method$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, double arg1) {
		loadPreferences();
		
			if(!enableTweak){
	      _logos_orig$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$(self, _cmd, arg1);
	    } else {
				
				double customAlpha = 100;
				if ([alphaViewPrefChoice isEqualToString:@""]) {
					NSLog(@"CustomCC ERROR: alphaViewPrefChoice is empty!");
				} else {
					NSDictionary *cases = @{@"Default" : @0,
																			 @"50" : @1,
																			 @"25" : @2,
																	 @"Custom" : @3,
																 };
					NSNumber *value = 0;
					value = [cases objectForKey:alphaViewPrefChoice];
					NSLog(@"CustomCC LOG: alphaViewPrefChoice value is: %@", value);
					switch ([value intValue]) {
						case 0:
							customAlpha = 100;
							break;
						case 1:
							customAlpha = 50;
							break;
						case 2:
							customAlpha = 25;
							break;
						case 3:
							if ([alphaViewPrefCustom isEqualToString:@""]) {
								customAlpha = 100;
							} else {
								customAlpha = [alphaViewPrefCustom doubleValue];
							}
							break;
						default:
							NSLog(@"CustomCC ERROR: alphaViewPrefChoice switch is default!");
							customAlpha = 100;
							break;
					}
					_logos_orig$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$(self, _cmd, customAlpha/100);
					setValueForKey(alphaViewPrefChoice, @"alphaViewPrefChoice");
					setValueForKey(alphaViewPrefCustom, @"alphaViewPrefCustom");
				}
				
			}
		
  }

  static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1) {
		loadPreferences();
    CGRect newFrame = arg1;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;

    if (!enableTweak) {
      _logos_orig$_ungrouped$SBControlCenterWindow$setFrame$(self, _cmd, arg1);
    } else {
		

			double newFrameX = 0;
			double newFrameY = 0;
			double newFrameH = 0;
			double newFrameW = 0;

			
			double posAboveDock = screenHeight - 93;
			if ([posPrefChoice isEqualToString:@""]) {
				NSLog(@"CustomCC ERROR: posPrefChoice is empty!");
			} else {
				NSDictionary *cases = @{@"Default" : @0,
																 @"Bottom" : @1,
															 @"Midpoint" : @2,
														 @"Above Dock" : @3,
														 			 @"Half" : @4,
																 @"Custom" : @5,
															 };
				NSNumber *value = 0;
				value = [cases objectForKey:posPrefChoice];
				NSLog(@"CustomCC LOG: posPrefChoice value is: %@", value);
				switch ([value intValue]) {
					case 0:
						newFrameY = 0;
						break;
					case 1:
						newFrameY = screenHeight - newFrameH;
						break;
					case 2:
						newFrameY = screenHeight/2;
						break;
					case 3:
						if ([sizePrefChoice isEqualToString:@"Half"]){
							newFrameY = posAboveDock - (screenHeight/2);
						} else if ([sizePrefChoice isEqualToString:@"Custom"]) {
							newFrameY = posAboveDock - [sizePrefH doubleValue];
						} else {
							newFrameY = posAboveDock;
						}
						break;
					case 4:
						newFrameY = 0;
						break;
					case 5:
						if ([posPrefX isEqualToString:@""]) {
							newFrameX = 0;
						} else {
							newFrameX = [posPrefX doubleValue];
						}
						if ([posPrefY isEqualToString:@""]) {
							newFrameY = 0;
						} else {
							newFrameY = [posPrefY doubleValue];
						}
						break;
					default:
						NSLog(@"CustomCC ERROR: posPrefChoice switch is default!");
						newFrameY = 0;
						break;
				}
				setValueForKey(posPrefChoice, @"posPrefChoice");
				setValueForKey(posPrefX, @"posPrefX");
				setValueForKey(posPrefY, @"posPrefY");
			}
			

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

      
			double cornerRadius = 0;
			if ([cornerRadiusPrefChoice isEqualToString:@""]) {
				NSLog(@"CustomCC ERROR: cornerRadiusPrefChoice is empty!");
			} else {
				NSDictionary *cases = @{@"Default" : @0,
                        						 @"25" : @1,
																		 @"50" : @2,
																 @"Custom" : @3
															 };
				NSNumber *value = 0;
				value = [cases objectForKey:cornerRadiusPrefChoice];
				NSLog(@"CustomCC LOG: cornerRadiusPrefChoice value is: %@", value);
				switch ([value intValue]) {
					case 0:
						cornerRadius = 0;
						break;
					case 1:
						cornerRadius = 25;
						break;
					case 2:
						cornerRadius = 50;
						break;
					case 3:
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
					case 0:
						scaleH = scaleW = 100;
						break;
					case 1:
						scaleH = scaleW = 75;
						break;
					case 2:
						scaleH = scaleW = 50;
						break;
					case 3:
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
			

			newFrame.size.width = newFrameW;
			newFrame.size.height = newFrameH;
			newFrame.origin.x = newFrameX;
			newFrame.origin.y = newFrameY;
			_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$(self, _cmd, newFrame);
    }
		
  }





    static void _logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){
			loadPreferences();
      CGRect newFrame = arg1;
			CGSize screenSize = [UIScreen mainScreen].bounds.size;
	    
	    double screenWidth = screenSize.width;

			double headerSizeH = 64;
			double headerSizeW = screenWidth;

			if (!enableTweak) {
	      return _logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$(self, _cmd, arg1);
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
						case 0:
							headerSizeH = 64;
							break;
						case 1:
							headerSizeH = 32;
							break;
						case 2:
							headerSizeH = 16;
							break;
						case 3:
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
					_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$(self, _cmd, newFrame);
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
			
    }





    static void _logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){
			loadPreferences();
      CGRect newFrame = arg1;

			if (!enableTweak) {
	      return _logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$(self, _cmd, arg1);
	    } else {
				
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
						case 0:
							posX = 0;
							posY = 0;
							break;
						case 1:
							posY = -40;
							break;
						case 2:
							posY = 50;
							break;
						case 3:
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
					_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$(self, _cmd, newFrame);
				}
				
			}
    }






















static __attribute__((constructor)) void _logosLocalCtor_4831a060(int __unused argc, char __unused **argv, char __unused **envp) {
	@autoreleasepool{
		loadPreferences();
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPreferences, CFSTR("com.leroy.CustomCCPreferences/preferencesChanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	}
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$_MTBackdropView = objc_getClass("_MTBackdropView"); MSHookMessageEx(_logos_class$_ungrouped$_MTBackdropView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$_MTBackdropView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$_MTBackdropView$layoutSubviews);MSHookMessageEx(_logos_class$_ungrouped$_MTBackdropView, @selector(setBlurRadius:), (IMP)&_logos_method$_ungrouped$_MTBackdropView$setBlurRadius$, (IMP*)&_logos_orig$_ungrouped$_MTBackdropView$setBlurRadius$);Class _logos_class$_ungrouped$SBControlCenterController = objc_getClass("SBControlCenterController"); MSHookMessageEx(_logos_class$_ungrouped$SBControlCenterController, @selector(dismissAnimated:), (IMP)&_logos_method$_ungrouped$SBControlCenterController$dismissAnimated$, (IMP*)&_logos_orig$_ungrouped$SBControlCenterController$dismissAnimated$);Class _logos_class$_ungrouped$SpringBoard = objc_getClass("SpringBoard"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITapGestureRecognizer* ), strlen(@encode(UITapGestureRecognizer* ))); i += strlen(@encode(UITapGestureRecognizer* )); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(handleTapGesture:), (IMP)&_logos_method$_ungrouped$SpringBoard$handleTapGesture$, _typeEncoding); }Class _logos_class$_ungrouped$SBControlCenterWindow = objc_getClass("SBControlCenterWindow"); MSHookMessageEx(_logos_class$_ungrouped$SBControlCenterWindow, @selector(setAlphaAndObeyBecauseIAmTheWindowManager:), (IMP)&_logos_method$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$, (IMP*)&_logos_orig$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$);MSHookMessageEx(_logos_class$_ungrouped$SBControlCenterWindow, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$SBControlCenterWindow$setFrame$, (IMP*)&_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$);Class _logos_class$_ungrouped$CCUIHeaderPocketView = objc_getClass("CCUIHeaderPocketView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIHeaderPocketView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$);Class _logos_class$_ungrouped$CCUIModuleCollectionView = objc_getClass("CCUIModuleCollectionView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIModuleCollectionView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$);} }
#line 645 "Tweak.xm"
