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
UIColor *colorPrefCustomValue = LCPParseColorString(colorPrefCustom, @"#ff0000");

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

@class SBControlCenterController; @class SpringBoard; @class CCUIHeaderPocketView; @class SBControlCenterWindow; @class _MTBackdropView; @class CCUIModuleCollectionView; 
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
		double myBlur = 30;
		if(!enableTweak){
			_logos_orig$_ungrouped$_MTBackdropView$setBlurRadius$(self, _cmd, arg1);
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
			_logos_orig$_ungrouped$_MTBackdropView$setBlurRadius$(self, _cmd, myBlur);
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
		double myAlpha = 100;

    if(!enableTweak){
      _logos_orig$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$(self, _cmd, arg1);
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
      _logos_orig$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$(self, _cmd, myAlpha/100);
    }

  }

  static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1) {
		loadPreferences();
    CGRect newFrame = arg1;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;

    if (!enableTweak) {
      return _logos_orig$_ungrouped$SBControlCenterWindow$setFrame$(self, _cmd, arg1);
    } else {
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
      _logos_orig$_ungrouped$SBControlCenterWindow$setFrame$(self, _cmd, newFrame);

      
      if ([cornerRadiusPrefChoice isEqualToString:@"Default"]) {
        self._cornerRadius = 0;
      } else if ([cornerRadiusPrefChoice isEqualToString:@"25"]) {
        self._cornerRadius = 25;
      } else if ([cornerRadiusPrefChoice isEqualToString:@"50"]) {
        self._cornerRadius = 50;
      } else if ([cornerRadiusPrefChoice isEqualToString:@"Custom"]) {
        if ([cornerRadiusPrefCustom isEqualToString:@""]) {
          self._cornerRadius = 0;
        } else {
          self._cornerRadius = [cornerRadiusPrefCustom doubleValue];
        }
      }
			setValueForKey(cornerRadiusPrefChoice, @"cornerRadiusPrefChoice");
			setValueForKey(cornerRadiusPrefCustom, @"cornerRadiusPrefCustom");
			

			
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
						scaleH = scaleW = 1;
						break;
					case 1:
						scaleH = scaleW = 0.75;
						break;
					case 2:
						scaleH = scaleW = 0.5;
						break;
					case 3:
						if (([scaleCCPrefH isEqualToString:@""]) && ([scaleCCPrefW isEqualToString:@""])) {
							scaleH = scaleW = 1;
						} else {
							if ([scaleCCPrefH isEqualToString:@""]) {
								scaleH = 1;
								scaleW = [scaleCCPrefW doubleValue]/100;
							} else if ([scaleCCPrefW isEqualToString:@""]) {
								scaleH = [scaleCCPrefH doubleValue]/100;
								scaleW = 1;
							} else {
								scaleH = [scaleCCPrefH doubleValue]/100;
								scaleH = [scaleCCPrefH doubleValue]/100;
							}
						}
						break;
					default:
						NSLog(@"CustomCC ERROR: scaleCCPrefChoice is default!");
						scaleH = scaleW = 1;
						break;
				}
				setValueForKey(scaleCCPrefChoice, @"scaleCCPrefChoice");
				setValueForKey(scaleCCPrefH, @"scaleCCPrefH");
				setValueForKey(scaleCCPrefW, @"scaleCCPrefW");
				self.transform = CGAffineTransformMakeScale(scaleW, scaleH);
			}
			
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



static __attribute__((constructor)) void _logosLocalCtor_b145a852(int __unused argc, char __unused **argv, char __unused **envp) {

	
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPreferences, CFSTR("com.leroy.CustomCCPreferences/preferencesChanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	loadPreferences();
	
	
	
	
	
}







static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$_MTBackdropView = objc_getClass("_MTBackdropView"); MSHookMessageEx(_logos_class$_ungrouped$_MTBackdropView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$_MTBackdropView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$_MTBackdropView$layoutSubviews);MSHookMessageEx(_logos_class$_ungrouped$_MTBackdropView, @selector(setBlurRadius:), (IMP)&_logos_method$_ungrouped$_MTBackdropView$setBlurRadius$, (IMP*)&_logos_orig$_ungrouped$_MTBackdropView$setBlurRadius$);Class _logos_class$_ungrouped$SBControlCenterController = objc_getClass("SBControlCenterController"); MSHookMessageEx(_logos_class$_ungrouped$SBControlCenterController, @selector(dismissAnimated:), (IMP)&_logos_method$_ungrouped$SBControlCenterController$dismissAnimated$, (IMP*)&_logos_orig$_ungrouped$SBControlCenterController$dismissAnimated$);Class _logos_class$_ungrouped$SpringBoard = objc_getClass("SpringBoard"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITapGestureRecognizer* ), strlen(@encode(UITapGestureRecognizer* ))); i += strlen(@encode(UITapGestureRecognizer* )); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(handleTapGesture:), (IMP)&_logos_method$_ungrouped$SpringBoard$handleTapGesture$, _typeEncoding); }Class _logos_class$_ungrouped$SBControlCenterWindow = objc_getClass("SBControlCenterWindow"); MSHookMessageEx(_logos_class$_ungrouped$SBControlCenterWindow, @selector(setAlphaAndObeyBecauseIAmTheWindowManager:), (IMP)&_logos_method$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$, (IMP*)&_logos_orig$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$);MSHookMessageEx(_logos_class$_ungrouped$SBControlCenterWindow, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$SBControlCenterWindow$setFrame$, (IMP*)&_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$);Class _logos_class$_ungrouped$CCUIHeaderPocketView = objc_getClass("CCUIHeaderPocketView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIHeaderPocketView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$);Class _logos_class$_ungrouped$CCUIModuleCollectionView = objc_getClass("CCUIModuleCollectionView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIModuleCollectionView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$);} }
#line 519 "Tweak.xm"
