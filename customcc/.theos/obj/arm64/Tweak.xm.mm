#line 1 "Tweak.xm"
#import <UIKit/UIKit.h>
#define preferencesPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.leroy.CustomCCPreferences.plist"]

@interface SBControlCenterWindow : UIView
	@property (assign,setter=_setCornerRadius:,nonatomic) double _cornerRadius;
  @property (nonatomic,assign,readwrite) CGAffineTransform transform;
@end



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

@class CCUIHeaderPocketView; @class SBControlCenterWindow; @class CCUIModuleCollectionView; 
static void (*_logos_orig$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$)(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, double); static void _logos_method$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, double); static void (*_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$)(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); static void (*_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST, SEL, CGRect); static void (*_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST, SEL, CGRect); 

#line 10 "Tweak.xm"



  static void _logos_method$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, double arg1) {
      double myAlpha = 100;
      NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
      bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
      NSString *alphaViewPrefChoice = [preferences objectForKey:@"alphaViewPrefChoice"];
      NSString *alphaViewPrefCustom = [preferences objectForKey:@"alphaViewPref"];

      if(!enableTweak){
        return _logos_orig$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$(self, _cmd, arg1);
      } else {
        if ([alphaViewPrefChoice isEqualToString:@"Default"]){
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
        _logos_orig$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$(self, _cmd, myAlpha/100);
      }

  }

  static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1) {
    CGRect newFrame = arg1;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;

    NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
    bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];

    
    NSString *posPrefChoice = [preferences objectForKey:@"posPrefChoice"];
    NSString *posPrefX = [preferences objectForKey:@"posPrefX"];
    NSString *posPrefY = [preferences objectForKey:@"posPrefY"];
    
    NSString *sizePrefChoice = [preferences objectForKey:@"sizePrefChoice"];
    NSString *sizePrefW = [preferences objectForKey:@"sizePrefW"];
    NSString *sizePrefH = [preferences objectForKey:@"sizePrefH"];
    
    NSString *cornerRadiusPrefChoice = [preferences objectForKey:@"cornerRadiusPrefChoice"];
    NSString *cornerRadiusPrefCustom = [preferences objectForKey:@"cornerRadiusPrefCustom"];
		
    NSString *scaleCCPrefChoice = [preferences objectForKey:@"scaleCCPrefChoice"];
    NSString *scaleCCPrefH = [preferences objectForKey:@"scaleCCPrefH"];
		NSString *scaleCCPrefW = [preferences objectForKey:@"scaleCCPrefW"];

    if(!enableTweak){
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
			

			
			double scaleH, scaleW;
			if ([scaleCCPrefChoice isEqualToString:@""]) {
				NSLog(@"ERROR: scaleCCPrefChoice is empty!");
			} else {
				NSArray *items = @[@"Default", @"75", @"50", @"Custom"];
				int item = [items indexOfObject:scaleCCPrefChoice];
				switch (item) {
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
						if (([scaleCCPrefH isEqualToString:@""]) && ([scaleCCPrefH isEqualToString:@""])) {
							scaleH = scaleW = 1;
							
						} else if ([scaleCCPrefH isEqualToString:@""]) {
							scaleH = 1;
							scaleW = [scaleCCPrefW doubleValue];
							
						} else {
							scaleH = [scaleCCPrefH doubleValue];
							scaleW = 1;
							
						}
						break;
					default:
						NSLog(@"ERROR: scaleCCPrefChoice is default!");
						scaleH = scaleW = 1;
						break;
				}
				self.transform = CGAffineTransformMakeScale(scaleW, scaleH);


				
				
				
				
				
				
				
				
				
				
				
				
				
				
				

			}
			

    }
  }





    static void _logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){
      CGRect newFrame = arg1;
      NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
      bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
      NSString *posHeaderViewPrefChoice = [preferences objectForKey:@"posHeaderPrefChoice"];
      NSString *posHeaderViewPrefH = [preferences objectForKey:@"posHeaderViewPrefH"];

      if(enableTweak){
        if ([posHeaderViewPrefChoice isEqualToString:@"Default"]){
          newFrame.size.height = 64;
        } else if ([posHeaderViewPrefChoice isEqualToString:@"Half"]) {
          newFrame.size.height = 32;
        } else if ([posHeaderViewPrefChoice isEqualToString:@"Quarter"]) {
          newFrame.size.height = 16;
        } else if ([posHeaderViewPrefChoice isEqualToString:@"Custom"]) {
          if ([posHeaderViewPrefH isEqualToString:@""]) {
            newFrame.size.height = 64;
          } else {
            newFrame.size.height = [posHeaderViewPrefH doubleValue];
          }
        }
        _logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$(self, _cmd, newFrame);
      } else {
        _logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$(self, _cmd, arg1);
      }
    }





    static void _logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){
      CGRect newFrame = arg1;
      NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
      bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
      NSString *posCollectionViewPrefChoice = [preferences objectForKey:@"posCollectionViewPrefChoice"];
      NSString *posCollectionViewPrefX = [preferences objectForKey:@"posCollectionViewPrefX"];
      NSString *posCollectionViewPrefY = [preferences objectForKey:@"posCollectionViewPrefY"];

      if(enableTweak){
        if ([posCollectionViewPrefChoice isEqualToString:@"Default"]){
          newFrame.origin.x = 0;
          newFrame.origin.y = 0;
        } else if ([posCollectionViewPrefChoice isEqualToString:@"Top"]) {
          newFrame.origin.y = -40;
        } else if ([posCollectionViewPrefChoice isEqualToString:@"Bottom"]) {
          newFrame.origin.y = 50;
        } else if ([posCollectionViewPrefChoice isEqualToString:@"Custom"]) {
          if ([posCollectionViewPrefX isEqualToString:@""]) {
            newFrame.origin.x = 0;
          } else {
            newFrame.origin.x = [posCollectionViewPrefX doubleValue];
          }
          if ([posCollectionViewPrefY isEqualToString:@""]) {
            newFrame.origin.y = 0;
          } else {
            newFrame.origin.y = [posCollectionViewPrefY doubleValue];
          }
        }
        _logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$(self, _cmd, newFrame);
      } else {
        _logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$(self, _cmd, arg1);
      }
    }


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBControlCenterWindow = objc_getClass("SBControlCenterWindow"); MSHookMessageEx(_logos_class$_ungrouped$SBControlCenterWindow, @selector(setAlphaAndObeyBecauseIAmTheWindowManager:), (IMP)&_logos_method$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$, (IMP*)&_logos_orig$_ungrouped$SBControlCenterWindow$setAlphaAndObeyBecauseIAmTheWindowManager$);MSHookMessageEx(_logos_class$_ungrouped$SBControlCenterWindow, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$SBControlCenterWindow$setFrame$, (IMP*)&_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$);Class _logos_class$_ungrouped$CCUIHeaderPocketView = objc_getClass("CCUIHeaderPocketView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIHeaderPocketView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$);Class _logos_class$_ungrouped$CCUIModuleCollectionView = objc_getClass("CCUIModuleCollectionView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIModuleCollectionView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$);} }
#line 273 "Tweak.xm"
