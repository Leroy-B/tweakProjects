#line 1 "Tweak.xm"
#import <UIKit/UIKit.h>


static NSString * const CustomCCPreferencesFile = @"/var/mobile/Library/Preferences/com.leroy.CustomCCPreferences.plist";








NSString *posChoice = @"";
NSString *posXString = @"";
NSString *posYString = @"";

NSString *sizeChoice = @"";
NSString *sizeWValue = @"";
NSString *sizeHValue = @"";
BOOL enableTweak = NO;


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

@class SBControlCenterWindow; @class CCUIModuleCollectionView; @class CCUIHeaderPocketView; 
static void (*_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$)(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); static void (*_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST, SEL, CGRect); static void (*_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST, SEL, CGRect); 

#line 22 "Tweak.xm"


    static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){

      CGRect newFrame = arg1;
      newFrame.origin.x = 0;
      newFrame.origin.y = 0;
      newFrame.size.height = 667;
      newFrame.size.width = 375;

      CGSize screenSize = [UIScreen mainScreen].bounds.size;
      double screenHeight = screenSize.height;
      double screenWidth = screenSize.width;

      

      NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: CustomCCPreferencesFile];

      if(settings){
        enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
        if(enableTweak){

          posChoice = [settings objectForKey: @"posPrefChoice"] ? [settings objectForKey: @"posPrefChoice"] : posChoice;
          posYString = [settings objectForKey: @"posYPrefValue"] ? [settings objectForKey: @"posYPrefValue"] : posYString;
          posXString = [settings objectForKey: @"posXPrefValue"] ? [settings objectForKey: @"posXPrefValue"] : posXString;

          double posY = [posYString doubleValue];
          double posX = [posXString doubleValue];

          sizeChoice = [settings objectForKey: @"sizePrefChoice"] ? [settings objectForKey: @"sizePrefChoice"] : sizeChoice;
          sizeWValue = [settings objectForKey: @"sizeWPrefValue"] ? [settings objectForKey: @"sizeWPrefValue"] : sizeWValue;
          sizeHValue = [settings objectForKey: @"sizeHPrefValue"] ? [settings objectForKey: @"sizeHPrefValue"] : sizeHValue;

          double sizeW = [sizeWValue doubleValue];
          double sizeH = [sizeHValue doubleValue];

          NSArray *posItems = @[@"Bottom", @"Top", @"Above Dock", @"Custom"];
          int posItem = [posItems indexOfObject:posChoice];
          switch (posItem) {
              case 0:
                newFrame.origin.y = 330;
                break;
              case 1:
                newFrame.origin.y = 0;
                break;
              case 2:
                newFrame.origin.y = 245;
                break;
              case 3:
                newFrame.origin.y = posY;
                newFrame.origin.x = posX;
                break;
              default:
                newFrame.origin.y = 0;
                newFrame.origin.x = 0;
                break;
          }


          NSArray *sizeItems = @[@"Full", @"Half", @"Custom"];
          int sizeItem = [sizeItems indexOfObject:sizeChoice];
          switch (sizeItem) {
              case 0:
                newFrame.origin.y = 0;
                newFrame.origin.x = 0;
                newFrame.size.height = screenHeight;
                newFrame.size.width = screenWidth;
                break;
              case 1:
                newFrame.size.height = screenHeight/2;
                break;
              case 2:
                newFrame.size.width = sizeW;
                newFrame.size.height = sizeH;
                break;
              default:
                newFrame.origin.y = 0;
                newFrame.origin.x = 0;
                newFrame.size.height = 667;
                newFrame.size.width = 375;
                break;
          }

          
          
          
          
          
          
          _logos_orig$_ungrouped$SBControlCenterWindow$setFrame$(self, _cmd, newFrame);
        } else {
          _logos_orig$_ungrouped$SBControlCenterWindow$setFrame$(self, _cmd, arg1);
        }
      }



      
      
      
      
      
      
      
      
      
      
      
    }





    static void _logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){

      CGRect newFrame = arg1;
      newFrame.size.height = 32;
      NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: CustomCCPreferencesFile];
      if(settings){
        enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
        if(enableTweak){
          _logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$(self, _cmd, newFrame);
        } else {
          _logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$(self, _cmd, arg1);
        }
      }

      
      
      
      
      
      
      
      
      
      
      
    }





    static void _logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){

      CGRect newFrame = arg1;
      newFrame.origin.y = -30;
      NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: CustomCCPreferencesFile];
      if(settings){
        enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
        if(enableTweak){
          _logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$(self, _cmd, newFrame);
        } else {
          _logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$(self, _cmd, arg1);
        }
      }

      
      
      
      
      
      
      
      
      
      
      
    }



















    























static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBControlCenterWindow = objc_getClass("SBControlCenterWindow"); MSHookMessageEx(_logos_class$_ungrouped$SBControlCenterWindow, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$SBControlCenterWindow$setFrame$, (IMP*)&_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$);Class _logos_class$_ungrouped$CCUIHeaderPocketView = objc_getClass("CCUIHeaderPocketView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIHeaderPocketView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$);Class _logos_class$_ungrouped$CCUIModuleCollectionView = objc_getClass("CCUIModuleCollectionView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIModuleCollectionView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$);} }
#line 236 "Tweak.xm"
